@FriendsList = React.createClass

  mixins: [ReactMeteorData]

  componentDidMount: ->
    safeStartMonitor 5000, 1000, false

  getMeteorData: ->
    current_user_id = Meteor.userId()

    return(
      friends: new User(current_user_id).friends
      active_friend: Session.get('selected')
    )

  renderFriends: ->
    self = @
    _.map @data.friends, (friend) ->
      emitter  = friend.emitter
      receiver = friend.receiver

      concerned = if emitter is Meteor.userId()
        receiver
      else if receiver is Meteor.userId()
        emitter

      active = self.data.active_friend is concerned
      <Friend key={ friend._id } friendship={ friend } active={ active } />

  render: ->
    <div className='friends_list_wrapper'>
      <ul className='friends_list'>
        { @renderFriends() }
      </ul>
    </div>

safeStartMonitor = (threshold = 60000, interval = 5000, idleOnBlur = false) ->
  Deps.autorun (c) ->
    try
      settings = {threshold, interval, idleOnBlur}
      UserStatus.startMonitor(settings)
      c.stop()
      console.log "Idle monitor started with ", settings

@FriendsList = React.createClass

  mixins: [ReactMeteorData]

  componentDidMount: ->
    safeStartMonitor 5000, 1000, false

  getMeteorData: ->
    current_user_id = Meteor.userId()

    return friends: new User(current_user_id).friends

  renderFriends: ->
    _.map @data.friends, (friend) ->
      <Friend key={ friend._id } friendship={ friend } />

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

@Friend = React.createClass

  mixins: [ReactMeteorData]

  getMeteorData: ->
    friend: @getFriend()

  displayFriendName: ->
    [@data.friend.profile.first_name, @data.friend.profile.last_name].join(' ')

  getFriend: ->
    emitter  = Meteor.users.findOne({ _id: @props.friendship.emitter })
    receiver = Meteor.users.findOne({ _id: @props.friendship.receiver })

    friend = if emitter._id is Meteor.userId()
      receiver
    else if receiver._id is Meteor.userId()
      emitter

    friend

  getOnlineStatus: ->
    if @data.friend.status.online then 'online'

  componentWillReceiveProps: (nextProps) ->
    console.log 'Coucou'
    @renderLi()

  renderLi: ->
    <li>
      <a href='#'>

        <div className='friend_image_wrapper'>
          <img className='friend_image' src={ @data.friend.profile.image }/>
        </div>

        <span className='friend_name'>
          { @displayFriendName() }
        </span>

        <div className="friend_status_wrapper #{ @getOnlineStatus() }">
          <span className='friend_status'></span>
        </div>
      </a>
    </li>

  render: ->
    @renderLi()

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

  getStatusClass: ->
    if @data.friend.status.online then 'online'

  renderStatus: ->
    status = @data.friend.status
    if status.idle
      friend_status = 'idle'
      last_seen = moment(@data.friend.status.lastActivity).format()
    else if status.online
      friend_status = 'online'
      last_seen = ''
    else
      friend_status = 'offline'
      last_seen = moment(@data.friend.status.lastLogin.date).format()

    <FriendStatus status={ friend_status }
                  lastSeen={ last_seen } />

  render: ->
    <li>
      <a href='#'>

        <div className='friend_image_wrapper'>
          <img className='friend_image' src={ @data.friend.profile.image }/>
        </div>

        <span className='friend_name'>
          { @displayFriendName() }
        </span>

        { @renderStatus() }
      </a>
    </li>

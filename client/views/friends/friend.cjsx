{ Link } = ReactRouter

@Friend = React.createClass

  mixins: [ReactMeteorData]

  getMeteorData: ->
    friend: @getFriend()

  componentDidMount: ->
    $(@refs.friend_status_ago).timeago()

  clearDOM: ->
    $(@refs.friend_status_ago).text ''

  componentDidUpdate: (prevProps, prevState) ->
    @clearDOM()

    if prevProps.lastSeen is '' && @props.lastSeen != ''
      $(@refs.friend_status_ago).timeago('updateFromDOM')

    else if prevProps.lastSeen != '' && @props.lastSeen is ''
      $(@refs.friend_status_ago).off()

    else
      $(@refs.friend_status_ago).timeago()

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
    if @data.friend.status.idle
      'idle'
    else if @data.friend.status.online
      'online'
    else
      'offline'

  getLastSeen: ->
    status = @data.friend.status
    if status.idle
      moment(status.lastActivity).format()
    else if status.online
      ''
    else
      moment(status.lastLogin.date).format()

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
      <Link to="/#{ @data.friend._id }" data-toggle='tooltip'
                                        data-placement='left'
                                        title="J'aime la chatte">

        <div className="friend_image_wrapper #{ @getStatusClass() }">
          <img className='friend_image' src={ @data.friend.profile.image }/>
        </div>

        <span className='friend_name'>
          { @displayFriendName() }
        </span>

        <span ref='friend_status_ago'
            className='friend_last_seen'
            title="#{ @getLastSeen() }" />
      </Link>
    </li>

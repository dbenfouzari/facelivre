@FriendStatus = React.createClass
  getDefaultProps: ->
    status: 'offline'
    lastSeen: ''

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

  render: ->
    <div className="friend_status_wrapper #{ @props.status }">
      <span ref='friend_status_ago'
            className='friend_status_ago'
            title="#{ @props.lastSeen }" />

      <span ref='friend_status' className='friend_status' />
    </div>

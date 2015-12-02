@FriendsListItem = React.createClass
  displayName: 'FriendsListItem'

  mixins: [ReactMeteorData]

  getMeteorData: ->
    active: Session.get('selected')

  componentDidMount: ->
    self = this
    $(ReactDOM.findDOMNode(@refs.tooltip_ago)).tooltip()
    $(ReactDOM.findDOMNode(@refs.tooltip_ago)).on 'show.bs.tooltip', ->
      if self.getLastSeen()
        $(this).attr 'title', "Était en ligne #{$.timeago(self.getLastSeen())}"
        $(this).attr 'data-original-title', "Était en ligne #{self.getTimeAgo()}"
      else
        $(this).attr 'title', ''
        $(this).attr 'data-original-title', ''

    $(ReactDOM.findDOMNode(@refs.tooltip_ago)).on 'click', ->
      $(@).tooltip 'hide'

  displayFriendName: ->
    [@props.friend.profile.first_name, @props.friend.profile.last_name].join(' ')

  getStatusClass: ->
    if @props.friend.status.idle
      'idle'
    else if @props.friend.status.online
      'online'
    else
      'offline'

  getLastSeen: ->
    status = @props.friend.status

    date = if status.idle
      moment(status.lastActivity).format()
    else if status.online
      ''
    else
      moment(status.lastLogin.date).format()

  getTimeAgo: ->
    $.timeago @getLastSeen()

  getActive: ->
    if @data.active and @data.active is @props.friend.slug
      'active'
    else
      ''

  renderNewMessages: ->
    me = new User(Meteor.userId())
    new_messages = me.getNewMessages(@props.friend._id)
    nb = new_messages.length

    if nb > 0
      <div className='ribbon'><span>{ nb }</span></div>

  render: ->
    <li className={ @getActive() }>
      <Link to="/messages/#{ @props.friend.slug }" data-toggle='tooltip'
                   data-placement='left'
                   className='tooltip_ago'
                   ref='tooltip_ago'
                   title="Était en ligne #{ @getLastSeen() }"
                   data-original-title="Était en ligne #{ @getLastSeen() }" >

        { @renderNewMessages() }

        <div className="friend_image_wrapper #{ @getStatusClass() }">
          <img className='friend_image' src={ @props.friend.profile.image }/>
        </div>

        <span className='friend_name'>
          { @displayFriendName() }
        </span>
      </Link>
    </li>

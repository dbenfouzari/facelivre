{ Link } = ReactRouter

@Friend = React.createClass

  mixins: [ReactMeteorData]

  getMeteorData: ->
    friend: @getFriend()

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

    date = if status.idle
      moment(status.lastActivity).format()
    else if status.online
      ''
    else
      moment(status.lastLogin.date).format()

  getTimeAgo: ->
    $.timeago @getLastSeen()

  handleClick: (e) ->
    e.preventDefault()

    if Session.get('selected') and Session.get('selected') is @data.friend._id
      Session.set 'selected', null
    else
      Session.set 'selected', @data.friend._id

  getActive: ->
    if @props.active then 'active' else ''

  render: ->
    <li className={ @getActive() }>
      <Link to="#" data-toggle='tooltip'
                   data-placement='left'
                   className='tooltip_ago'
                   ref='tooltip_ago'
                   title="Était en ligne #{ @getLastSeen() }"
                   data-original-title="Était en ligne #{ @getLastSeen() }"
                   onClick={ @handleClick }>

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

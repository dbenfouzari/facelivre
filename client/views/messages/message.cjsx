@Message = React.createClass
  displayName: "Message"

  getMe: ->
    if @props.message.emitter is Meteor.userId()
      'me'
    else
      'person'

  getEmitterName: ->
    new User(@props.message.emitter).full_name

  getMessageStatus: ->
    if @props.message.read.read
      'read'
    else
      'unread'

  renderReadIcon: ->
    if @props.message.emitter is Meteor.userId()
      <i className="fa fa-check #{ @getMessageStatus() }"
         data-toggle='tooltip'
         data-placement='left'
         ref='tooltip_ago'
         title={ @getReadAt() }></i>

  getReadAt: ->
    if @props.message.read.read
      moment(@props.message.read.readAt).calendar()

  componentWillMount: ->
    if @props.message.receiver == Meteor.userId() && !@props.message.read.read
      MessageCollection.update({_id: @props.message._id}, $set: {read: {read: true, readAt: new Date()}})

  componentDidMount: ->
    $(@refs.timeago).timeago()
    $(@refs.paragraph).html(Emojis.parse($(@refs.paragraph).text()))
    $(@refs.tooltip_ago).tooltip()

  render: ->
    <li id={@props.message._id} className="msgbox-message #{ @getMe() }">
      <div className='info'>
        <a href='#'>{ @getEmitterName() }</a>
        <span ref='timeago' title="#{ @props.message.createdAt.toISOString() }"></span>
      </div>
      <a href='#' className='avatar'>
        <img width='35' src='https://placeholdit.imgix.net/~text?txtsize=12&txt=128%C3%97128&w=128&h=128'/>
      </a>
      <p ref='paragraph'>
        { @props.message.message }
      </p>
      { @renderReadIcon() }
    </li>

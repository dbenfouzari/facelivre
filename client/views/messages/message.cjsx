@Message = React.createClass
  displayName: "Message"

  getMe: ->
    if @props.message.emitter is Meteor.userId()
      'me'
    else
      'person'

  getMessageStatus: ->
    if @props.message.read.read
      'read'
    else
      'unread'

  getReadAt: ->
    if @props.message.read.read and @props.message.emitter is Meteor.userId()
      read_at = moment(@props.message.read.readAt).calendar()
      tolower = read_at.charAt(0).toLowerCase() + read_at.slice(1)
      <span className='ribbon'
            ref='read_at'
            data-placement='right'
            title="Lu #{ tolower }">
        ✓
      </span>

  componentWillMount: ->
    if @props.message.receiver == Meteor.userId() && !@props.message.read.read
      MessageCollection.update
        _id: @props.message._id
      , $set:
        read:
          read: true
          readAt: new Date()

  componentDidUpdate: ->
    $(@refs.read_at).tooltip()

  componentDidMount: ->
    $(@refs.read_at).tooltip()
    $(@refs.paragraph).html(Emojis.parse($(@refs.paragraph).text()))

  mixins: [ReactMeteorData]

  getMeteorData: ->
    author: Meteor.users.findOne({_id: @props.message.emitter})

  render: ->
    <li className={ @getMe() }>
      <div className='author_avatar_wrapper'>
        <img className='author_avatar'
            src={ @data.author.profile.image } />
      </div>

      <div className="message #{ @getMessageStatus() }">
        <p ref='paragraph'>
          { @props.message.message }
        </p>
        { @getReadAt() }
      </div>

      <section className='message_infos'>
        <span className='sent_at'>
          { moment(@props.message.createdAt).calendar() }
        </span>
      </section>
    </li>

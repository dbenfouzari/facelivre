@MessageBoxMessages = React.createClass
  displayName: "MessageBoxMessages"

  mixins: [ReactMeteorData]

  getMeteorData: ->
    messages: MessageCollection.find({
      $or: [{
        emitter: Meteor.userId(),
        receiver: @props.with._id
      }, {
        emitter: @props.with._id,
        receiver: Meteor.userId()
      }]
    }).fetch()

  handleSubmit: (e) ->
    e.preventDefault()
    self = this
    msg  = @refs.new_message.value

    message = MessageCollection.insert
      emitter: Meteor.userId()
      receiver: @props.with._id
      message: msg

    @refs.new_message.value = ''

    setTimeout @scrollToBottom, 200

  scrollToBottom: ->
    $('.msgbox-messages:first').animate
      scrollTop: $('.msgbox-messages:first').prop("scrollHeight")
    , 1000

  componentDidMount: ->
    setTimeout @scrollToBottom, 1000

  renderMessages: ->
    _.map @data.messages, (message) ->
      <Message key={ message._id } message={ message } />

  render: ->
    <div className='msgbox-messages-container'>
      <ul className='msgbox-messages'>
        { this.renderMessages() }
      </ul>

      <div className='create_message'>
        <form onSubmit={ @handleSubmit } >
          <textarea ref='new_message' className='message_entry'></textarea>
          <button type='submit' className='btn btn-submit'>Envoyer</button>
        </form>
      </div>
    </div>

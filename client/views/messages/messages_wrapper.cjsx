@MessagesWrapper = React.createClass
  displayName: "MessagesWrapper"

  mixins: [ReactMeteorData]

  getMeteorData: ->
    selected: Session.get('selected')
    friend: Meteor.users.findOne({slug: Session.get('selected')})

  getDisplay: ->
    if @data.selected && @data.friend
      'block'
    else
      'none'

  renderMessages: ->
    if @data.friend
      <MessageBox with={ @data.friend } />

  render: ->
    <div>
      <Overlay ref='page_overlay' display={ @getDisplay() } />
      <div ref='messages_wrapper' style={{display: @getDisplay()}}
                                  className='messages_wrapper'>
        { @renderMessages() }
      </div>
    </div>

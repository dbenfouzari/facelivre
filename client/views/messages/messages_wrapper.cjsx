@MessagesWrapper = React.createClass
  displayName: "MessagesWrapper"

  mixins: [ReactMeteorData]

  getMeteorData: ->
    if Session.get('selected')
      selected = 'block'
    else
      selected = 'none'

    selected: selected

  getInitialState: ->
    friend: null

  componentWillUpdate: ->
    @setState friend: Meteor.users.findOne({_id: Session.get('selected')})

  getDisplay: ->
    @data.selected

  render: ->
    <div>
      <Overlay ref='page_overlay' display={ @getDisplay() } />
      <div ref='messages_wrapper' style={{display: @getDisplay()}}
                                  className='messages_wrapper'>
      </div>
    </div>

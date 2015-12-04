@MessageBar = React.createClass
  mixins: [ReactMeteorData]

  getDefaultProps: ->
    type: 'info'
    message: 'Information'

  getInitialState: ->
    shown: false

  getMeteorData: ->
    type:    Session.get('message_bar_type')    || 'info'
    shown:   Session.get('message_bar_shown')   || false
    message: Session.get('message_bar_content') || ''

  componentDidMount: ->
    console.log @props.dismissible

  getClasses: ->
    klass = 'alert'
    klass += " alert-#{@data.type}"

    if @props.dismissible
      klass += ' alert-dismissible'

    klass

  getDismissible: ->
    if @props.dismissible
      <button type='button' className='close' data-dismiss='alert'>
        <span aria-hidden='true'>&times;</span>
      </button>

  render: ->
    <div className="#{ @getClasses() }">
      { @getDismissible() }
      { @props.children }
    </div>

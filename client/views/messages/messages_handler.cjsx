@MessagesHandler = React.createClass
  displayName: "MessagesHandler"

  set_var: (props) ->
    props = if props then props else @props
    href_user_id = props.params.user_slug

    if href_user_id
      Session.set 'selected', href_user_id

  componentWillMount: (props) ->
    @set_var(props)

  componentWillUpdate: (props) ->
    @set_var(props)

  componentWillUnmount: ->
    Session.set 'selected', null

  render: ->
    <div className='messages_click_right'>
      <h1>
        Click one of your friends to the right
        <i className='fa fa-hand-o-right'></i>
      </h1>
    </div>

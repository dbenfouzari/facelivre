@LoginButtons = React.createClass
  displayName: 'LoginButtons'

  componentDidMount: ->
    div = document.getElementById('login-container')
    Blaze.renderWithData(Template._loginButtons, {}, div)

  # Don't allow this part of the DOM update or React may complain
  shouldComponentUpdate: ->
    false

  render: ->
    <ul className='nav navbar-nav navbar-right' id='login-container'>
    </ul>

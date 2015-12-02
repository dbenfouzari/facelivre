@LoginDropdown = React.createClass
  displayName: 'LoginDropdown'

  renderCorrectDropdown: ->
    if Meteor.user()
      <LoginDropdownLoggedIn />
    else
      <LoginDropdownLoggedOut />

  render: ->
    <ul className='nav navbar-nav navbar-right'>
      { @renderCorrectDropdown() }
    </ul>

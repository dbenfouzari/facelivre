@LoginDropdownLoggedIn = React.createClass
  displayName: 'LoginDropdown'

  handleLogout: (e) ->
    e.preventDefault()
    Meteor.logout()

  render: ->
    user = new User(Meteor.userId())

    <li className='dropdown' id='login-dropdown-list'>
      <a className='dropdown-toggle' data-toggle='dropdown'>
        { user.full_name }
        <b className='caret'/>
      </a>

      <div className='dropdown-menu'>
        <Link to='/' className='btn btn-default btn-block go-home'>Retour</Link>
        <a className='btn btn-primary btn-block' onClick={ @handleLogout }>
          Déconnexion
        </a>
      </div>
    </li>

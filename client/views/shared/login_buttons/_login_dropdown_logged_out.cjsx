@LoginDropdownLoggedOut = React.createClass
  displayName: 'LoginDropdown'

  handleLogin: (e) ->
    e.preventDefault()
    uname  = @refs.loginEmail.value
    passwd = @refs.loginPassword.value

    Meteor.loginWithPassword uname, passwd

  render: ->
    <li className='dropdown' id='login-dropdown-list'>
      <a className='dropdown-toggle' data-toggle='dropdown'>
        Connexion / Inscription
        <b className='caret'/>
      </a>

      <div className='dropdown-menu'>
        <form onSubmit={ @handleLogin }>
          <input className='form-control' ref='loginEmail' type='email' placeholder="Nom d'utilisateur" />
          <input className='form-control' ref='loginPassword' type='password' placeholder="Mot de passe" />
          <button className='btn btn-primary col-xs-12 col-sm-12' id='login-buttons-password' type='submit'>
            Connexion
          </button>
        </form>
      </div>
    </li>

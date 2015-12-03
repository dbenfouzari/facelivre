@LoginPage = React.createClass
  displayName: "LoginPage"

  getInitialState: ->
    signup: false

  handleSubmit: (e) ->
    e.preventDefault()

    username = $(@refs.login_username).val()
    password = $(@refs.login_password).val()

    Meteor.loginWithPassword username, password

  handleSubmitSignup: (e) ->
    e.preventDefault()

    username = $(@refs.username).val()
    password = $(@refs.password).val()
    email    = $(@refs.email).val()

    Accounts.createUser
      email: email
      password: password
      username: username
      profile:
        first_name: 'Prénom'
        last_name: 'Nom'
        address: {}

  handleSignup: (e) ->
    e.preventDefault()

    $('form')[0].reset()
    @setState signup: !@state.signup

  renderLogin: ->
    <div className='login_wrapper'>
      <header>
        <h1>Login Form</h1>
      </header>

      <form onSubmit={ @handleSubmit } >
        <div className="group">
          <input type="text" ref='login_username' name='username' required />
          <span className="highlight"></span>
          <span className="bar"></span>
          <label>Username or email</label>
        </div>

        <div className="group">
          <input type="password" ref='login_password' name='password' required />
          <span className="highlight"></span>
          <span className="bar"></span>
          <label>Password</label>
        </div>

        <button type='submit' className='btn btn-block'>Log In</button>
        <a ref='signup' onClick={ @handleSignup }>Sign up</a>
      </form>
    </div>

  renderSignup: ->
    <div className='login_wrapper'>
      <header>
        <h1>Signup Form</h1>
      </header>

      <form onSubmit={ @handleSubmitSignup } >
        <div className="group">
          <input type="text" ref='username' name='username' required />
          <span className="highlight"></span>
          <span className="bar"></span>
          <label>Username</label>
        </div>

        <div className="group">
          <input type="email" ref='email' name='email' required />
          <span className="highlight"></span>
          <span className="bar"></span>
          <label>Email</label>
        </div>

        <div className="group">
          <input type="password" ref='password' name='password' required />
          <span className="highlight"></span>
          <span className="bar"></span>
          <label>Password</label>
        </div>

        <button type='submit' className='btn btn-block'>Sign up</button>
        <a ref='login' onClick={ @handleSignup }>Log in</a>
      </form>
    </div>

  render: ->
    if @state.signup
      @renderSignup()
    else
      @renderLogin()

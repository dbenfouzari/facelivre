@LoginPage = React.createClass
  displayName: "LoginPage"

  handleSubmit: (e) ->
    e.preventDefault()

    username = $(@refs.username).val()
    password = $(@refs.password).val()

    Meteor.loginWithPassword username, password

  render: ->
    <div className='login_wrapper'>
      <header>
        <h1>Login Form</h1>
      </header>

      <form onSubmit={ @handleSubmit } >
        <div className="group">
          <input type="text" ref='username' required />
          <span className="highlight"></span>
          <span className="bar"></span>
          <label>Username or email</label>
        </div>

        <div className="group">
          <input type="password" ref='password' required />
          <span className="highlight"></span>
          <span className="bar"></span>
          <label>Password</label>
        </div>

        <button type='submit' className='btn btn-block'>Log In</button>
      </form>
    </div>

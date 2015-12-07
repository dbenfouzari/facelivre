@NavBar = React.createClass
  handleSidebar: ->
    Session.set 'sidebar-toggled', !Session.get('sidebar-toggled')

  render: ->
    <nav className='navbar navbar-default navbar-fixed-top'>
      <div className='container-fluid'>
        <div className='navbar-header'>
          <button className='navbar-toggle collapsed'
                  type='button'
                  onClick={ @handleSidebar }>
            <span className='icon-bar'/>
            <span className='icon-bar'/>
            <span className='icon-bar'/>
          </button>

          <Link to='/' className='navbar-brand'>
            <i className='fa fa-book'></i>
          </Link>
        </div>
        <NavbarForm />
        <NavbarLinks/>
      </div>
    </nav>

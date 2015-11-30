@NavBar = React.createClass
  render: ->
    <nav className='navbar navbar-default navbar-fixed-top'>
      <div className='container'>
        <div className='navbar-header'>
          <button className='navbar-toggle collapsed' type='button'
            data-toggle='collapse' data-target='#navbar-collapsable'
            aria-expended='false'>
            <span className='icon-bar'/>
            <span className='icon-bar'/>
            <span className='icon-bar'/>
          </button>

          <Link to='/' className='navbar-brand'>F</Link>
        </div>

        <div id='navbar-collapsable' className='collapse navbar-collapse'>
          <NavbarLinks/>
        </div>
      </div>
    </nav>

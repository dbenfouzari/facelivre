@NavbarForm = React.createClass
  displayName: "NavbarForm"

  render: ->
    <div className='navbar-search'>
      <form className="navbar-form navbar-left" role="search">
        <div className="form-group">
          <i className='fa fa-search'></i>
          <input type="search" className="form-control"
                 placeholder="Search for people, places, and things" />
        </div>
      </form>
    </div>

@SideBar = React.createClass
  displayName: "SideBar"

  togglePin: (e) ->
    e.preventDefault()
    Session.set 'sidebar-toggled', !Session.get('sidebar-toggled')

  render: ->
    <nav className='sidebar_wrapper'>
      <ul className='sidebar'>
        <SideNavLink to='/feed' className='nav-feed'>
          Feed
        </SideNavLink>
        <SideNavLink to="/#{Meteor.userId()}" className='nav-profile'>
          Profile
        </SideNavLink>
        <SideNavLink to='/friends' className='nav-friends'>
          Friends
        </SideNavLink>
        <SideNavLink to='/messages' className='nav-messages'>
          Messages
        </SideNavLink>
        <li className='pin-sidebar'>
          <a href='#' title='Pin Sidebar' onClick={ @togglePin }>
            <i className='fa fa-thumb-tack'></i>
          </a>
        </li>
      </ul>
    </nav>

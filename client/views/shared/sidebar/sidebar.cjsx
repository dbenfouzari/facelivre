@SideBar = React.createClass
  displayName: "SideBar"

  render: ->
    <nav id='navbar-collapsable' className='sidebar_wrapper'>
      <ul className='sidebar'>
        <SideNavLink to='/feed' className='nav-feed'>
          Feed
        </SideNavLink>
        <SideNavLink to="/#{Meteor.user().username}" className='nav-profile'>
          Profile
        </SideNavLink>
        <SideNavLink to='/friends' className='nav-friends'>
          Friends
        </SideNavLink>
        <SideNavLink to='/messages' className='nav-messages'>
          Messages
        </SideNavLink>
      </ul>
    </nav>

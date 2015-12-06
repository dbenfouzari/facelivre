@SideBar = React.createClass
  displayName: "SideBar"

  render: ->
    <nav id='navbar-collapsable' className='sidebar_wrapper'>
      <ul className='sidebar'>
        <SideNavLink to='/feed' className='nav-feed'>
          <i className='fa fa-newspaper-o'></i>
          Feed
        </SideNavLink>
        <SideNavLink to="/#{Meteor.user().slug}" className='nav-profile'>
          <i className='fa fa-user'></i>
          Profile
        </SideNavLink>
        <SideNavLink to='/friends' className='nav-friends'>
          <i className='fa fa-users'></i>
          Friends
        </SideNavLink>
        <SideNavLink to='/messages' className='nav-messages'>
          <i className='fa fa-comments-o'></i>
          Messages
        </SideNavLink>
      </ul>
    </nav>

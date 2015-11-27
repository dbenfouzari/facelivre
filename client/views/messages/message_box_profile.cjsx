@MessageBoxProfile = React.createClass
  displayName: "MessageBoxProfile"

  render: ->
    user = new User(@props.profile._id)

    return(
      <div id='message-box-profile'>
        <div className='msgbox-profile-header'>
          <figure className='msgbox-profile-cover'
                  style={{backgroundImage: "url(#{user.profile_picture})" }} >
          </figure>
          <figure className='msgbox-profile-profilePic'>
            <img src={ user.profile_picture } />
          </figure>
          <span className='msgbox-profile-name'>
            { user.full_name }
          </span>
        </div>
      </div>
    )

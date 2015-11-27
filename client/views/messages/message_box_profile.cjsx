@MessageBoxProfile = React.createClass
  displayName: "MessageBoxProfile"

  componentDidMount: ->
    # $('#message-box-profile').perfectScrollbar()

  render: ->
    user = new User(@props.profile._id)

    return(
      <div id='message-box-profile' data-mcs-theme='minimal-dark'
            data-mcs-axis='y' className='mCustomScrollbar'>
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

@FriendFront = React.createClass
  displayName: "FriendFront"

  render: ->
    user = new User(@props.friend._id)

    <div className='front'>
      <header style={{ backgroundImage: "url(#{user.cover_picture})" }}>
        <figure>
          <img src={ user.profile_picture } />
        </figure>
      </header>

      <main>
        <span className='friend_name'>
          { user.full_name }
        </span>

        <span className='location'>
          Paris, France
        </span>

        <span className='mail'>
          d.benfouzari@gmail.com
        </span>

        <span className='phone'>
          06.77.78.38.41
        </span>
      </main>

      <footer>
        <a href='#' className='right' onClick={ this.props.onFollow }>
          { this.props.followLink }
        </a>
        <a href='#' className='left'  onClick={ @props.onFlip }>+ infos</a>
      </footer>
    </div>

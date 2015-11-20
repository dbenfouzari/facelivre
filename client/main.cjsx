@Facelivre = React.createClass
  render: ->
    <div>
      <NavBar />
      <FriendsList />
      <div className='container news_feed_container'>
        <div className='row'>
          <div className='col-lg-2'>
          </div>
          <div className='col-lg-7'>
            { @props.children }
          </div>
          <div className='col-lg-3'>
          </div>
        </div>
      </div>
    </div>

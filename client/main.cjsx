@Facelivre = React.createClass
  render: ->
    <div>
      <NavBar />
      <FriendsList />
      <div className='container news_feed_container'>
        <div className='row'>
          { @props.children }
        </div>
      </div>
    </div>

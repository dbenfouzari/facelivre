@Facelivre = React.createClass
  # render: ->
  #   <div>
  #     <NavBar />
  #     <div className='container news_feed_container'>
  #       <div className='row'>
  #         <div className='col-lg-2'>
  #         </div>
  #         <div className='col-lg-7'>
  #           { @props.children }
  #         </div>
  #         <div className='col-lg-3'>
  #         </div>
  #       </div>
  #     </div>
  #     <MessagesWrapper />
  #     <FriendsList />
  #   </div>

  render: ->
    <div>
      <NavBar />
      <div className='container-fluid news_feed_container'>
        { @props.children }
      </div>
      <MessagesWrapper />
      <FriendsList />
    </div>


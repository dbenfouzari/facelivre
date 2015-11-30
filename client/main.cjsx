@Facelivre = React.createClass

  mixins: [ReactMeteorData]

  getMeteorData: ->
    user: Meteor.user()

  renderLogin: ->
    <div>
      <NavBar />
      <LoginPage />
    </div>

  renderNews: ->
    <div>
      <NavBar />
      <div className='container-fluid news_feed_container'>
        { @props.children }
      </div>
      <MessagesWrapper />
      <FriendsList />
    </div>

  render: ->
    if @data.user
      @renderNews()
    else
      @renderLogin()

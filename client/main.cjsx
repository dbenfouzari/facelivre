@Facelivre = React.createClass

  mixins: [ReactMeteorData]

  getMeteorData: ->
    user: Meteor.user()
    toggled: Session.get('sidebar-toggled')

  getToggled: ->
    if @data.toggled is false
      ''
    else
      'toggled'

  renderLogin: ->
    <div>
      <NavBar />
      <LoginPage />
    </div>

  renderNews: ->
    <div>
      <NavBar />
      <div className="container-fluid news_feed_container #{ @getToggled() }">
        <SideBar/>
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

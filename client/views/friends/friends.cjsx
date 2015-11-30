@Friends = React.createClass
  displayName: "Friends"

  mixins: [ReactMeteorData]

  getMeteorData: ->
    friends: new User(Meteor.userId()).friends

  getMasonryOptions: ->
    columnWidth: 285
    itemSelector: '.friend'
    gutter: 30
    isFitWidth: true
    stamp: '.fsf'

  renderFriends: ->
    _.map @data.friends, (friend) ->
      <Friend key={ friend._id } friend={ friend } />

  render: ->
    <Masonry className={'friends'}
             elementType={'ul'}
             options={@getMasonryOptions()} >
      <FriendsSearchForm />
      { @renderFriends() }
    </Masonry>

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
    <div>
      <FriendsSearchForm />

      <h1>Your friends</h1>

      <Masonry className={'friends'}
               elementType={'ul'}
               options={@getMasonryOptions()} >
        { @renderFriends() }
      </Masonry>
    </div>

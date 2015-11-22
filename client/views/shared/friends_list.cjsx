@FriendsList = React.createClass

  mixins: [ReactMeteorData]

  getMeteorData: ->
    current_user_id = Meteor.userId()

    return friends: new User(current_user_id).friends

  renderFriends: ->
    _.map @data.friends, (friend) ->
      <Friend key={ friend._id } friendship={ friend } />

  render: ->
    <div className='friends_list_wrapper'>
      <ul className='friends_list'>
        { @renderFriends() }
      </ul>
    </div>

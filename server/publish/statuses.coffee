Meteor.publish 'allStatuses', ->
  current_user = @userId

  @autorun (computation) ->
    friendships = FriendShipsCollection.find(
      $or: [
        emitter: current_user
      ,
        receiver: current_user
      ]
    ).fetch()

    friends = _.map friendships, (friendship) ->
      if friendship.emitter is current_user
        Meteor.users.findOne(_id: friendship.receiver)._id
      else
        Meteor.users.findOne(_id: friendship.emitter)._id

    friends.push current_user

    StatusCollection.find authorId: $in: friends
  return

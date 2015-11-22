@User = class User
  constructor: (id) ->
    return new Error('ID must be defined') unless id
    @meteor_collection = Meteor.users.findOne({ _id: id })
    throw 'User ID not recognized' unless @meteor_collection

    @id = id
    @friends = @getFriends()

  getFriends: ->
    friends = FriendShipsCollection.find().fetch()
    if friends.length > 0
      return friends
    else
      []

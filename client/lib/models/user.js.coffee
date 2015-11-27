@User = class User
  constructor: (id) ->
    return new Error('ID must be defined') unless id
    @meteor_collection = Meteor.users.findOne({ _id: id })
    throw 'User ID not recognized' unless @meteor_collection

    @id        = id
    @friends   = @getFriends()
    @full_name = @getFullName()
    @profile_picture = @getProfilePicture()

  getFullName: ->
    [
      @meteor_collection.profile.first_name,
      @meteor_collection.profile.last_name
    ].join(' ')

  getFriends: ->
    friends = FriendShipsCollection.find().fetch()
    if friends.length > 0
      return friends
    else
      []

  getProfilePicture: ->
    if @meteor_collection.profile.image
      @meteor_collection.profile.image
    else
      "https://placeholdit.imgix.net/~text?txtsize=50&txt=Picture&w=160&h=160"

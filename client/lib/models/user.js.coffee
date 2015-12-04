@User = class User
  constructor: (id) ->
    return new Error('ID must be defined') unless id
    @meteor_collection = Meteor.users.findOne({ _id: id })
    throw 'User ID not recognized' unless @meteor_collection

    @id        = id
    @friends   = @getFriends()
    @full_name = @getFullName()
    @profile_picture = @getProfilePicture()
    @cover_picture = @getCoverPicture()
    @new_messages = @getNewMessages()

  getFullName: ->
    if @meteor_collection.profile.first_name
      [
        @meteor_collection.profile.first_name,
        @meteor_collection.profile.last_name
      ].join(' ')
    else
      @meteor_collection.username

  getFriends: ->
    friendships = FriendShipsCollection.find().fetch()
    if friendships.length > 0
      users = _.map friendships, (friendship) ->
        emitter  = Meteor.users.findOne({ _id: friendship.emitter })
        receiver = Meteor.users.findOne({ _id: friendship.receiver })

        if friendship.emitter is Meteor.userId()
          Meteor.users.findOne({_id: friendship.receiver})
        else
          Meteor.users.findOne({_id: friendship.emitter})

      users
    else
      []

  getNewMessages: (withFriend = null) ->
    if withFriend
      MessageCollection.find({emitter: withFriend, read: { read: false }}).fetch()
    else
      MessageCollection.find({read: { read: false }}).fetch()

  getProfilePicture: ->
    image = AssetsCollection.findOne
      owner:
        type: 'User'
        id: @id

    if image
      Meteor._relativeToSiteRootUrl('/uploads/' + image.uri)
    else
      "https://placeholdit.imgix.net/~text?txtsize=50&txt=Picture&w=160&h=160"

  getCoverPicture: ->
    if @meteor_collection.profile.cover
      @meteor_collection.profile.cover
    else
      @getProfilePicture()

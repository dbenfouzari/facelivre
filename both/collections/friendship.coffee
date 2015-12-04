@FriendShipsCollection = new Mongo.Collection 'friendships'

Schema = new SimpleSchema
  emitter:
    type: SimpleSchema.RegEx.Id # User ID
    optional: false
    index: true

  receiver:
    type: SimpleSchema.RegEx.Id # User ID
    optional: false
    index: true

  accepted:
    type: Boolean
    optional: false
    autoValue: ->
      return false

  createdAt:
    type: Date
    optional: false
    autoValue: ->
      if this.isInsert
        return new Date()

FriendShipsCollection.attachSchema Schema

FriendShipsCollection.allow
  insert: (userId, doc) ->
    return userId is doc.emitter

  update: -> false
  remove: -> (userId, doc) ->
    return userId is doc.emitter or userId is doc.receiver

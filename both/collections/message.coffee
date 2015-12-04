@MessageCollection = new Mongo.Collection 'messages'

ReadStatusSchema = new SimpleSchema
  read:
    type: Boolean
    optional: false
    autoValue: ->
      if @isInsert
        false

  readAt:
    type: Date
    optional: true
    autoValue: ->
      if @isUpdate
        new Date()

MessageSchema = new SimpleSchema
  emitter:
    type: SimpleSchema.RegEx.Id
    optional: false
    index: true

  receiver:
    type: SimpleSchema.RegEx.Id
    optional: false
    index: true

  message:
    type: String
    optional: false

  read:
    type: ReadStatusSchema
    optional: false

  createdAt:
    type: Date
    optional: false
    autoValue: ->
      if @isInsert
        new Date()

MessageCollection.attachSchema MessageSchema

MessageCollection.allow
  insert: (userId, doc) ->
    # Avoid sending messages with other user ID
    return userId is doc.emitter

  update: -> true

  # Can't remove already sended messages
  remove: -> false

MessageCollection.deny
  # Can't update other fields than "read"
  update: (userId, doc, fields, modifier) ->
    blacklist = ['emitter', 'receiver', 'message', 'createdAt']
    _.intersection(fields, blacklist) > 0

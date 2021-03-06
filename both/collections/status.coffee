@StatusCollection = new Mongo.Collection 'statuses'

StatusSchema = new SimpleSchema
  status:
    type: String
    optional: true

  status_type:
    type: String
    optional: false
    index: true

  authorId:
    type: SimpleSchema.RegEx.Id
    optional: false
    index: true

  likers:
    type: [ SimpleSchema.RegEx.Id ]
    optional: true

  createdAt:
    type: Date
    optional: false
    autoValue: ->
      if @isInsert
        new Date()

  updatedAt:
    type: Date
    optional: false
    autoValue: ->
      new Date()

StatusCollection.attachSchema StatusSchema

StatusCollection.allow
  insert: (userId, doc) ->
    return userId is doc.authorId

  update: -> return true
  remove: (userId, doc) ->
    return userId is doc.authorId

# Deny any attempt to edit the body of others' statuses
StatusCollection.deny
  update: (userId, doc, fields, modifiers) ->
    return _.contains(fields, 'status') && userId != doc.authorId

# Deny any attempt to update createdAt or authorId fields
StatusCollection.deny
  update: (userId, doc, fields, modifiers) ->
    return _.intersection(fields, ['createdAt', 'authorId']).length > 0

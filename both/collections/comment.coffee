@CommentCollection = new Mongo.Collection 'comments'

## Commentable Schema
CommentableSchema = new SimpleSchema
  commentableType:
    type: String
    optional: false

  commentableId:
    type: SimpleSchema.RegEx.Id
    optional: false
    index: true

## Comment Schema
CommentSchema = new SimpleSchema
  commentable:
    type: CommentableSchema
    optional: false

  authorId:
    type: SimpleSchema.RegEx.Id
    optional: false
    index: true

  content:
    type: String
    optional: false

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

CommentCollection.attachSchema CommentSchema

# Define security
CommentCollection.allow
  insert: (userId, doc) ->
    userId is doc.authorId # Current user has to be the owner

  remove: (userId, doc) ->
    userId is doc.authorId # Current user has to be the owner

  update: (userId, doc, fields, modifier) ->
    blacklist = ['createdAt', 'authorId', 'commentable']

    # Current user has to be the owner and
    # Updated fields cannot contain blacklisted fields
    userId is doc.authorId and _.intersection(fields, blacklist).length is 0

@AssetsCollection = new Mongo.Collection 'assets'

## Assets owner schema
AssetsOwner = new SimpleSchema
  type:
    type: String
    optional: false

  id:
    type: SimpleSchema.RegEx.Id
    optional: false

## Assets Schema
AssetsSchema = new SimpleSchema
  date:
    type: Date
    optional: false

  title:
    type: String
    optional: false

  size:
    type: Number
    optional: false

  uri:
    type: String
    optional: false

  owner:
    type: AssetsOwner

AssetsCollection.attachSchema AssetsSchema

# Define security
AssetsCollection.allow
  insert: (userId, doc) ->
    userId is doc.owner.id

  remove: (userId, doc) ->
    userId is doc.owner.id

  update: (userId, doc, fields, modifier) -> true

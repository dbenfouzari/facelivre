Meteor.methods
  createAsset: (blob, title, size, type, owner) ->
    if !(blob || title || size || type)
      throw (new Meteor.Error 400, 'Required parameter missing')
    if typeof title != 'string'
      throw (new Meteor.Error 413, 'Title is not a string')
    if typeof size != 'number'
      throw (new Meteor.Error 413, 'Size is not a number')
    if typeof type != 'string'
      throw (new Meteor.Error 413, 'Type is not a string')
    if !this.userId
      throw (new Meteor.Error 403, 'You have to be logged in to create anything. Sorry Charlie.')

    regex = /(?:\.([^.]+))?$/
    extension = regex.exec(title)[1]
    title = "#{owner.owner_type}/#{Random.hexString(25)}.#{extension}"

    fs = Npm.require 'fs'
    root = 'C:/Projects/Meteor/facelivre/public/'
    folder = '.#uploads/'
    path = root + folder + title
    encoding = 'binary'
    fs.writeFile path, blob, encoding, (error) ->
      if error
        console.log 'error', error

    AssetsCollection.insert
      date: new Date()
      title: _.escape title
      size: size
      type: _.escape type
      uri: title
      owner:
        type: owner.owner_type
        id: owner.owner_id

  removeAsset: (id) ->
    folder = 'C:/Projects/Meteor/facelivre/public/.#uploads/'
    asset = AssetsCollection.findOne(id)
    if !asset
      console.log 'no asset available'
    fs = Npm.require 'fs'
    fs.unlink folder + asset.uri, (error) ->
      if error
        console.warn 'error: ', error
    AssetsCollection.remove asset._id

  removeComments: (ids) ->
    CommentCollection.remove _id: $in: ids

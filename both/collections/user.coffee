Meteor.users.attachSchema Schemas.User
Meteor.users.friendlySlugs 'username'

Meteor.users.allow
  update: (userId, doc) ->
    return userId == doc._id

Meteor.users.deny
  update: (userId, doc, fields, modifier) ->
    return _.intersection(fields, ['createdAt', '_id']).length > 0

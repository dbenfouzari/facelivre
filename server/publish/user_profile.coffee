Meteor.publish 'user_profile', (slug) ->
  target_user  = slug

  user = Meteor.users.findOne slug: target_user

  return [
    Meteor.users.find slug: target_user
    StatusCollection.find authorId: user._id
  ]

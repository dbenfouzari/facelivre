Meteor.publish 'user_profile', (slug) ->

  if slug
    user = Meteor.users.findOne slug: slug

    return [
      Meteor.users.find slug: slug
      StatusCollection.find authorId: user._id
    ]

  else
    []

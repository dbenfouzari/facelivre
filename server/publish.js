Meteor.publish('allUsers', function() {
  return Meteor.users.find({}, {
    status: 1, profile: 1, emails: 1, username: 1, address: 1
  });
});

// Meteor.publish('profileAndPhotos', function(userId) {
//   return [
//     Meteor.users.find({_id: userId}, {status: 1, profile: 1, emails: 1, username: 1, address: 1}),
//     Images.find({
//       $query: {'metadata.owner': userId}
//     })
//   ]
// });
Meteor.publish('friendships', function(user_id) {
  return FriendShipsCollection.find({
    $or: [{
      emitter: this.userId
    }, {
      receiver: this.userId
    }]
  });
});

Meteor.publish('allImages', function() {
  return AssetsCollection.find();
});

Meteor.publish('profiles', function() {
  return ProfileCollection.find();
});

Meteor.publish('emojis', function() {
  return Emojis.find();
});

Meteor.publish('messages', function() {
  return MessageCollection.find({
    $or: [{
      emitter: this.userId
    }, {
      receiver: this.userId
    }]
  });
});

Meteor.publish('comments', function(commentable) {
  return CommentCollection.find({
    commentable: {
      commentableType: commentable.type,
      commentableId: commentable.id
    }
  });
});

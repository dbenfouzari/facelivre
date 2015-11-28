Meteor.publish('allUsers', function() {
  return Meteor.users.find({}, {status: 1, profile: 1, emails: 1, username: 1});
});

Meteor.publish('friendships', function(user_id) {
  return FriendShipsCollection.find({
    $or: [{
      emitter: this.userId
    }, {
      receiver: this.userId
    }]
  });
});

Meteor.publish('news', function() {
  return NewsCollection.find();
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

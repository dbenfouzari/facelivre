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

Meteor.publish('statuses', function() {
  self = this;
  friendships = FriendShipsCollection.find({
    $or: [{
      emitter: this.userId
    }, {
      receiver: this.userId
    }]
  }).fetch();

  friends = friendships.map(function(friendship) {
    if(friendship.emitter === self.userId) {
      return Meteor.users.findOne({_id: friendship.receiver})._id;
    } else {
      return Meteor.users.findOne({_id: friendship.emitter})._id;
    }
  });

  me = Meteor.users.findOne({_id: this.userId})._id;
  friends.push(me);

  statuses = StatusCollection.find({
    authorId: {
      $in: friends
    }
  });

  return statuses;
});

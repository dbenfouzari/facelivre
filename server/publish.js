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

  this.autorun(function(computation) {
    if(self.userId) {
      friendships = FriendShipsCollection.find({
        $or: [{
          emitter: self.userId
        }, {
          receiver: self.userId
        }]
      }).fetch();

      friends = friendships.map(function(friendship) {
        if(friendship.emitter === self.userId) {
          return Meteor.users.findOne({_id: friendship.receiver})._id;
        } else {
          return Meteor.users.findOne({_id: friendship.emitter})._id;
        }
      });

      me = Meteor.users.findOne({_id: self.userId})._id;
      friends.push(me);

      return StatusCollection.find({
        authorId: {
          $in: friends
        }
      });
    } else {
      return [];
    }
  });
});

// Meteor.publish('statuses', function() {
//   self = this;

//   if(this.userId) {
//     friendships = FriendShipsCollection.find({
//       $or: [{
//         emitter: this.userId
//       }, {
//         receiver: this.userId
//       }]
//     }).fetch();

//     friends = friendships.map(function(friendship) {
//       if(friendship.emitter === self.userId) {
//         return Meteor.users.findOne({_id: friendship.receiver})._id;
//       } else {
//         return Meteor.users.findOne({_id: friendship.emitter})._id;
//       }
//     });

//     me = Meteor.users.findOne({_id: this.userId})._id;
//     friends.push(me);

//     return StatusCollection.find({
//       authorId: {
//         $in: friends
//       }
//     });
//   } else {
//     return [];
//   }
// });

Meteor.publish('comments', function(commentable) {
  return CommentCollection.find({
    commentable: {
      commentableType: commentable.type,
      commentableId: commentable.id
    }
  });
});

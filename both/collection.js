NewsCollection = new Mongo.Collection('news');
NewsCollection.attachSchema(Schemas.News);

ProfileCollection = new Mongo.Collection('profiles');
ProfileCollection.attachSchema(Schemas.Profile);

FriendShipsCollection = new Mongo.Collection('friendships');
FriendShipsCollection.attachSchema(Schemas.FriendShip);

MessageCollection = new Mongo.Collection('messages');
MessageCollection.attachSchema(Schemas.Message);

StatusCollection = new Mongo.Collection('statuses');
StatusCollection.attachSchema(Schemas.Status);

CommentCollection = new Mongo.Collection('comments');
CommentCollection.attachSchema(Schemas.Comment);

Meteor.users.attachSchema(Schemas.User);

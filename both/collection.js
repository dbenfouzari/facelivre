NewsCollection = new Mongo.Collection('news');
NewsCollection.attachSchema(Schemas.News);

ProfileCollection = new Mongo.Collection('profiles');
ProfileCollection.attachSchema(Schemas.Profile);

FriendShipsCollection = new Mongo.Collection('friendships');
FriendShipsCollection.attachSchema(Schemas.FriendShip);

Meteor.users.attachSchema(Schemas.User);

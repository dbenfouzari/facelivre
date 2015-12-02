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

AddressCollection = new Mongo.Collection('addresses');
AddressCollection.attachSchema(Schemas.Address);

UserAddressCollection = new Mongo.Collection('users_addresses');
UserAddressCollection.attachSchema(Schemas.UserAddress);

Meteor.users.attachSchema(Schemas.User);
Meteor.users.friendlySlugs('username');

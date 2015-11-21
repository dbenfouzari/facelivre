NewsCollection = new Mongo.Collection('news');
NewsCollection.attachSchema(Schemas.News);

ProfileCollection = new Mongo.Collection('profiles');
ProfileCollection.attachSchema(Schemas.Profile);

Meteor.users.attachSchema(Schemas.User);

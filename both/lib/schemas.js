Schemas = {};

Schemas.News = new SimpleSchema({
  content: {
    type: String,
    optional: false
  },

  author: {
    type: Meteor.user,
    optional: false
  }
});

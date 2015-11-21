Schemas = {};

Schemas.Profile = new SimpleSchema({
  first_name: {
    type: String,
    optional: true
  },

  last_name: {
    type: String,
    optional: true
  },

  birthday: {
    type: Date,
    optional: true
  },

  gender: {
    type: String,
    allowedValues: ['Male', 'Female'],
    optional: true
  },

  image: {
    type: String,
    optional: true
  }
});

Schemas.User = new SimpleSchema({
  username: {
    type: String,
    // For accounts-password, either emails or username is required, but not both. It is OK to make this
    // optional here because the accounts-password package does its own validation.
    // Third-party login packages may not require either. Adjust this schema as necessary for your usage.
    optional: true
  },

  emails: {
    type: Array,
    // For accounts-password, either emails or username is required, but not both. It is OK to make this
    // optional here because the accounts-password package does its own validation.
    // Third-party login packages may not require either. Adjust this schema as necessary for your usage.
    optional: true
  },

  "emails.$": {
    type: Object
  },

  "emails.$.address": {
    type: String,
    regEx: SimpleSchema.RegEx.Email
  },

  "emails.$.verified": {
    type: Boolean
  },

  createdAt: {
    type: Date,
    optional: true
  },

  profile: {
    type: Schemas.Profile,
    optional: true
  },

  services: {
    type: Object,
    optional: true,
    blackbox: true
  }
});

Schemas.News = new SimpleSchema({
  content: {
    type: String,
    optional: false
  },

  author: {
    type: String, // Just the ID...
    optional: false
  }
});

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

Schemas.UserStatusLogin = new SimpleSchema({
  date: {
    type: Date
  }
});

Schemas.UserStatus = new SimpleSchema({
  online: {
    type: Boolean,
    optional: false
  },

  lastLogin: {
    type: Schemas.UserStatusLogin
  },

  idle: {
    type: Boolean,
    optional: true
  },

  lastActivity: {
    type: Date,
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
    optional: false,
    autoValue: function() {
      return new Date();
    }
  },

  profile: {
    type: Schemas.Profile,
    optional: true
  },

  services: {
    type: Object,
    optional: true,
    blackbox: true
  },

  status: {
    type: Schemas.UserStatus,
    optional: true
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
  },

  createdAt: {
    type: Date,
    optional: false,
    autoValue: function() {
      return new Date();
    }
  }
});

Schemas.FriendShip = new SimpleSchema({
  emitter: {
    type: String, // User ID
    optional: false
  },

  receiver: {
    type: String, // User ID
    optional: false
  },

  accepted: {
    type: Boolean,
    optional: false,
    autoValue: function() {
      return false;
    }
  },

  createdAt: {
    type: Date,
    optional: false,
    autoValue: function() {
      return new Date();
    }
  }
});

Schemas.ReadStatus = new SimpleSchema({
  read: {
    type: Boolean,
    optional: false,
    autoValue: function() {
      if(this.isInsert) {
        return false;
      }
    }
  },

  readAt: {
    type: Date,
    optional: true,
    autoValue: function() {
      if(this.isUpdate) {
        return new Date();
      }
    }
  }
});

Schemas.Message = new SimpleSchema({
  emitter: {
    type: SimpleSchema.RegEx.Id,
    optional: false
  },

  receiver: {
    type: SimpleSchema.RegEx.Id,
    optional: false
  },

  message: {
    type: String,
    optional: false
  },

  read: {
    type: Schemas.ReadStatus,
    optional: false
  },

  createdAt: {
    type: Date,
    optional: false,
    autoValue: function() {
      return new Date();
    }
  }
});

Schemas = {};

SimpleSchema.messages({
  needLatLong: '[label] should be of form [longitude, latitude]',
  lonOutOfRange: '[label] longitude should be between -90 and 90',
  latOutOfRange: '[label] latitude should be between -180 and 180'
});

Schemas.LocationSchema = new SimpleSchema({
  type: {
    type: String,
    allowedValues: ['Point']
  },

  coordinates: {
    type: [Number],
    decimal: true,
    minCount: 2,
    maxCount: 2,
    custom: function() {
      if(this.value.length != 2) {
        return 'needLatLong';
      }

      if(this.value[0] < -90 || this.value[0] > 90) {
        return 'lonOutOfRange';
      }

      if(this.value[1] < -180 || this.value[1] > 180) {
        return 'latOutOfRange';
      }
    }
  }
});

Schemas.Address = new SimpleSchema({
  street_number: {
    type: String,
    optional: true
  },

  route: {
    type: String,
    optional: true
  },

  city: {
    type: String,
    optional: true
  },

  postal_code: {
    type: String,
    optional: true
  },

  country: {
    type: String,
    optional: true
  },

  position: {
    type: Schemas.LocationSchema,
    index: '2dsphere',
    optional: true
  }
});

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

  phone: {
    type: String,
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
  },

  cover: {
    type: String,
    optional: true
  },

  address: {
    type: Schemas.Address,
    optional: false
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
    optional: false
  },

  emails: {
    type: Array,
    // For accounts-password, either emails or username is required, but not both. It is OK to make this
    // optional here because the accounts-password package does its own validation.
    // Third-party login packages may not require either. Adjust this schema as necessary for your usage.
    optional: false
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
      if(this.isInsert) {
        return new Date();
      }
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
  },

  slug: {
    type: String,
    optional: true
  }
});

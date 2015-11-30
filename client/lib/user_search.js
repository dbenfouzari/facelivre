var options = {
  keepHistory: 1000 * 60 * 5,
  localSearch: true
};
var fields = ['username', 'profile.first_name', 'profile.last_name'];

UserSearch = new SearchSource('users', fields, options);

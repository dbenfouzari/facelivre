SearchSource.defineSource('users', function(searchText, options) {
  var options = { sort: { isoScore: -1 }, limit: 20};

  if(searchText) {
    var regExp = buildRegExp(searchText);
    var selector = { $or: [
      { username: regExp },
      { 'profile.first_name': regExp },
      { 'profile.last_name': regExp },
    ]};

    return Meteor.users.find(selector, options).fetch();
  } else {
    return [];
  }
});

function buildRegExp(searchText) {
  var words = searchText.trim().split(/[ \-\:]+/);
  var exps = _.map(words, function(word) {
    return "(?=.*" + word + ")";
  });
  var fullExp = exps.join('') + ".+";
  return new RegExp(fullExp, "i");
}

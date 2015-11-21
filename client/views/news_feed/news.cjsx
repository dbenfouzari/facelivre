@News = React.createClass
  getOptions: ->
    author = Meteor.users.findOne(@props.news.author)
    first_name = author.profile.first_name
    last_name = author.profile.last_name

    full_name = [first_name, last_name].join(' ')

    return (
      author: full_name
      image: author.profile.image
      content: @props.news.content
    )

  render: ->
    <NewsFeedBlock author={ @getOptions().author }
                   image={ @getOptions().image }
                   content={ @getOptions().content } />

@News = React.createClass
  getOptions: ->
    author = Meteor.users.findOne(@props.news.authorId)
    first_name = author.profile.first_name
    last_name = author.profile.last_name

    full_name = [first_name, last_name].join(' ')

    return (
      author: full_name
      image: author.profile.image
      status: @props.news.status
    )

  render: ->
    <NewsFeedBlock author={  @getOptions().author }
                   image={   @getOptions().image }
                   status={ @getOptions().status } />

@NewsFeed = React.createClass
  mixins: [ReactMeteorData]

  getMeteorData: ->
    news: NewsCollection.find().fetch()

  renderNews: ->
    _.map @data.news, (news) ->
      <News key={ news._id } news={ news } />

  render: ->
    <div ref='news_feed_wrapper'>
      <StatusForm />
      { @renderNews() }
    </div>

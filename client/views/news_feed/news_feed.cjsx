@NewsFeed = React.createClass
  render: ->
    <div ref='news_feed_wrapper'>
      <StatusForm />
      <NewsFeedBlock />
      <NewsFeedBlock />
      <NewsFeedBlock />
      <NewsFeedBlock />
    </div>

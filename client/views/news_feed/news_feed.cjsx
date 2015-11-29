# @NewsFeed = React.createClass
#   mixins: [ReactMeteorData]

#   getMeteorData: ->
#     news: StatusCollection.find().fetch()

#   renderNews: ->
#     _.map @data.news, (news) ->
#       <News key={ news._id } news={ news } />

#   render: ->
#     <div ref='news_feed_wrapper'>
#       <StatusForm />
#       { @renderNews() }
#     </div>

@NewsFeed = React.createClass
  displayName: "NewsFeed"

  mixins: [ReactMeteorData]

  getMeteorData: ->
    statuses: StatusCollection.find().fetch()

  renderStatuses: ->
    _.map @data.statuses, (status) ->
      <Status key={ status._id } status={ status } />

  # componentDidMount: ->
  #   $('.news_feed_wrapper').masonry
  #     itemSelector: '.status_wrapper'
  #     columnWidth: 420

  # componentDidUpdate: ->
  #   $('.news_feed_wrapper').masonry 'layout'

  render: ->
    <div className='news_feed_wrapper'>
      { @renderStatuses() }
    </div>
# <StatusForm />

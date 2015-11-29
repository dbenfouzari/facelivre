@NewsFeed = React.createClass
  displayName: "NewsFeed"

  mixins: [ReactMeteorData]

  getMeteorData: ->
    statuses: StatusCollection.find().fetch()

  onUpdate: ->
    @setState
      masonry: 'do reload'

  renderStatuses: ->
    self = this

    _.map @data.statuses, (status) ->
      <Status key={ status._id } status={ status } onUpdate={ self.onUpdate } />

  getMasonryOptions: ->
    columnWidth: 420
    itemSelector: '.status_wrapper'
    gutter: 5
    isFitWidth: true

  render: ->
    <Masonry className={'news_feed_wrapper'}
             options={@getMasonryOptions()} >
      { @renderStatuses() }
    </Masonry>


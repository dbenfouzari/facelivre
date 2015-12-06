@NewsFeed = React.createClass
  displayName: "NewsFeed"

  mixins: [ReactMeteorData]

  getMeteorData: ->
    handle = Meteor.subscribe 'allStatuses'

    isLoading: !handle.ready()
    statuses: StatusCollection.find({}, { sort: { createdAt: -1 }}).fetch()

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
    if @data.isLoading
      return <LoadingSpinner />

    else
      return(
        <div>
          <StatusForm />
          <Statuses statuses={ @data.statuses } />
        </div>
      )

  # render: ->
  #   <Masonry className={'news_feed_wrapper'}
  #            options={@getMasonryOptions()} >
  #     { @renderStatuses() }
  #   </Masonry>

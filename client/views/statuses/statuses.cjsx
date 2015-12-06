@Statuses = React.createClass
  displayName: "Statuses"

  mixins: [ReactMeteorData]

  getMeteorData: ->
    handle = Meteor.subscribe 'allStatuses'

    isLoading: !handle.ready()
    statuses: StatusCollection.find({}, { sort: { createdAt: -1 }}).fetch()

  renderStatuses: ->
    _.map @data.statuses, (status) ->
      <StatusV2 key={ status._id } status={ status } />

  render: ->
    if @data.isLoading
      return <LoadingSpinner />

    else
      return(
        <div className='statuses_wrapper'>
          <StatusForm />
          <ul className='statuses'>{ @renderStatuses() }</ul>
        </div>
      )

@Statuses = React.createClass
  displayName: "Statuses"

  renderStatuses: ->
    _.map @props.statuses, (status) ->
      <StatusV2 key={ status._id } status={ status } />

  render: ->
    <div className='statuses_wrapper'>
      <ul className='statuses'>{ @renderStatuses() }</ul>
    </div>

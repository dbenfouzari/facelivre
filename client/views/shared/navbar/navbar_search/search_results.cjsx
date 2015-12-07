@SearchResults = React.createClass
  displayName: "SearchResults"

  getInitialState: ->
    shown: false

  componentWillReceiveProps: (nextProps) ->
    arrays_equal = JSON.stringify(@props.results) == JSON.stringify(nextProps.results)
    if nextProps.results.length > 0 and not arrays_equal
      @setState shown: true

    else
      @setState shown: false

  getShownClass: ->
    if @state.shown then '' else 'hidden'

  componentDidMount: ->
    self = this

    $(document).click ->
      self.setState shown: false

  renderResults: ->
    _.map @props.results, (result) ->
      <SearchResult key={ result._id } result={ result } />

  render: ->
    <ul className="search_results #{ @getShownClass() }">
      { @renderResults() }
    </ul>

@NavbarForm = React.createClass
  displayName: 'NavbarForm'

  mixins: [ReactMeteorData]

  getMeteorData: ->
    users: UserSearch.getData()

  throttled: _.throttle (e) ->
      search_text = $(@refs.search).val()
      UserSearch.search search_text
    , 500, leading: false

  handleSubmit: (e) ->
    e.preventDefault()
    @throttled(e)

  componentDidMount: ->
    self = this
    $self = $(ReactDOM.findDOMNode(@))
    $input = $(@refs.search)
    $search_results = $self.find('ul.search_results')

    $self.keydown (e) ->
      $focuses = $search_results.find('li a:focus')
      if e.which is 40 # Bottom arrow
        if $focuses.length > 0
          $focuses.parent().next().find('a').focus()

        else
          $search_results.find('li:first a').focus()

      else if e.which is 38 # Up arrow
        if $focuses
          $focuses.parent().prev().find('a').focus()

      else if e.which is 27 # Escape
        $(self.refs.search).val ''
        self.handleSubmit(e)

      if e.which is 40 or e.which is 38
        e.preventDefault()

  render: ->
    <div className='navbar-search'>
      <form className='navbar-form navbar-left'
            role='search'
            onSubmit={ @handleSubmit } >

        <div className='form-group'>
          <i className='fa fa-search'></i>
          <input type='search' ref='search' className='form-control'
                 placeholder='Search for people, places, and things'
                 onKeyUp={ @handleSubmit } />
        </div>
        <SearchResults results={ @data.users } />
      </form>
    </div>

@FriendsSearchForm = React.createClass
  displayName: "FriendsSearchForm"

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

  getMasonryOptions: ->
    columnWidth: 285
    itemSelector: '.friend'
    gutter: 30
    isFitWidth: true

  renderUsers: ->
    _.map @data.users, (user) ->
      <Friend key={ user._id } friend={ user } />

  render: ->
    <div className='fsf'>
      <form onSubmit={ @handleSubmit } >
        <input type='search'
               ref='search'
               onKeyUp={ @handleSubmit }
               placeholder='Search for friend...' />
      </form>
      <Masonry className='found_users' options={@getMasonryOptions()}>
        { @renderUsers() }
      </Masonry>
    </div>

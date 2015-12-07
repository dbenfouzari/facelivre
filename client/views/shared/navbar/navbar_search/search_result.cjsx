@SearchResult = React.createClass
  displayName: "SearchResult"

  render: ->
    user = new User(@props.result._id)

    <li className='result'>
      <Link to="/#{ @props.result.slug }">
        <div className='user_picture'>
          <img src={ user.profile_picture } />
        </div>
        <span>{ user.full_name }</span>
      </Link>
    </li>

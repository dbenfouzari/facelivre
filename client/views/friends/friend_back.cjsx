@FriendBack = React.createClass
  displayName: "FriendBack"

  render: ->
    <div className='back'>
      Coucou

      <footer>
        <a href='#' className='right' onClick={ @props.onFollow }>Follow</a>
        <a href='#' className='left'  onClick={ @props.onFlip }>-</a>
      </footer>
    </div>

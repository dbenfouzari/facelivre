@Overlay = React.createClass
  displayName: "Overlay"

  handleClick: (e) ->
    Session.set 'selected', null
    $('.friends_list > li.active').removeClass 'active'

  render: ->
    <div className='page_overlay' onClick={ @handleClick } style={{display: @props.display}}></div>

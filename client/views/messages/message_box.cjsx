@MessageBox = React.createClass
  displayName: "MessageBox"

  render: ->
    <div className='msgbox-container'>
      <Profile profile={ @props.with } />
      <MessageBoxMessages with={    @props.with } />
    </div>

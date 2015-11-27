@MessageBox = React.createClass
  displayName: "MessageBox"

  render: ->
    <div className='msgbox-container'>
      <MessageBoxProfile  profile={ @props.with } />
      <MessageBoxMessages with={    @props.with } />
    </div>

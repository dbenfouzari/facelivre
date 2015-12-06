@LoadingSpinner = React.createClass
  displayName: "LoadingSpinner"

  render: ->
    <div className='loading-spinner'>
      <div className='loading-cube loading-cube-1'></div>
      <div className='loading-cube loading-cube-2'></div>
      <div className='loading-cube loading-cube-4'></div>
      <div className='loading-cube loading-cube-3'></div>
    </div>

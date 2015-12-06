@StatusForm = React.createClass
  displayName: "StatusForm"

  getInitialState: ->
    picture_selected: false

  handleSubmit: (e) ->
    $input = $(@refs.status)
    picture = $(@refs.status_picture)[0].files[0]
    text = $input.val().trim()

    if text isnt '' or picture isnt 'undefined'
      StatusCollection.insert
        status: text
        authorId: Meteor.userId()
      , (error, result) ->
        unless error
          if typeof picture isnt 'undefined'
            new AssetUpload picture,
              owner_type: 'Status'
              owner_id: result

    $input.val ''
    $(@refs.status_picture).val ''
    @setState picture_selected: false

    e.preventDefault()

  handleSelectPicture: (e) ->
    $(@refs.status_picture).trigger 'click'

    e.preventDefault()

  handleRemovePicture: (e) ->
    $(@refs.status_picture).val ''
    @setState picture_selected: false

  handleSubmittedPicture: (e) ->
    reader = new FileReader
    self = this

    @setState picture_selected: true

    reader.onload = (e) ->
      $(self.refs.selected_picture).attr 'src', e.target.result

    reader.readAsDataURL e.target.files[0]

  renderSelectedPicture: ->
    <div className='picture' onClick={ @handleRemovePicture } >
      <img ref='selected_picture' />
    </div>

  renderPictureUploader: ->
    if @state.picture_selected
      @renderSelectedPicture()
    else
      <div>
        <a className='add_picture' onClick={ @handleSelectPicture } >
          <i className='fa fa-camera'></i>
        </a>
      </div>

  render: ->
    <form id='status_form' onSubmit={ @handleSubmit } >
      <div className='profile_pic'>
        <img src='https://s3.amazonaws.com/uifaces/faces/twitter/vladarbatov/128.jpg' />
      </div>

      <div className='input_container'>
        <input ref='status' type='text' placeholder="What's on your mind ?"/>

        <div ref='picture_selector'>
          <input type='file' ref='status_picture' accept='image/*' onChange={ @handleSubmittedPicture } />
          { @renderPictureUploader() }
        </div>
      </div>
    </form>

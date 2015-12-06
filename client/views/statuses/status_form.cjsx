@StatusForm = React.createClass
  displayName: "StatusForm"

  getInitialState: ->
    picture_selected: false

  handleSubmit: (e) ->
    $input = $(@refs.status)
    picture = $(@refs.status_picture)[0].files[0]
    text = $input.val().trim()

    if text isnt ''
      type = 'Text'
    else if typeof(picture) isnt 'undefined'
      type = 'Image'

    if text isnt '' or typeof(picture) isnt 'undefined'
      StatusCollection.insert
        status: text
        status_type: type
        authorId: Meteor.userId()
      , (error, result) ->
        if error
          console.log error
        else
          if typeof picture isnt 'undefined'
            new AssetUpload picture,
              owner_type: 'Status'
              owner_id: result

    $input.val ''
    $(@refs.status_picture).val ''
    @setState picture_selected: false
    autosize.update $input

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

  componentDidMount: ->
    self = this

    autosize($(@refs.status))

    $(@refs.status)
      .keydown (e) ->
        if e.keyCode is 13 and !e.shiftKey
          e.preventDefault()

          self.handleSubmit(e)

  render: ->
    user = new User(Meteor.userId())

    <form id='status_form' onSubmit={ @handleSubmit } >
      <div className='profile_pic'>
        <img src={ user.profile_picture } />
      </div>

      <div className='input_container'>
        <textarea rows='1' ref='status' type='text' placeholder="What's on your mind ?"/>

        <div ref='picture_selector'>
          <input type='file' ref='status_picture' accept='image/*' onChange={ @handleSubmittedPicture } />
          { @renderPictureUploader() }
        </div>
      </div>
    </form>

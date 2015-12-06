@StatusForm = React.createClass
  displayName: "StatusForm"

  handleSubmit: (e) ->
    $input = $(@refs.status)
    text = $input.val().trim()

    if text isnt ''
      StatusCollection.insert
        status: text
        authorId: Meteor.userId()

      # Then empty the field ! :)
      $input.val ''

    e.preventDefault()

  render: ->
    <form id='status_form' onSubmit={ @handleSubmit } >
      <div className='profile_pic'>
        <img src='https://s3.amazonaws.com/uifaces/faces/twitter/vladarbatov/128.jpg' />
      </div>

      <div className='input_container'>
        <input ref='status' type='text' placeholder="What's on your mind ?"/>
      </div>
    </form>

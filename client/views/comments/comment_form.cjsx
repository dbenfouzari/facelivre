@CommentForm = React.createClass
  displayName: "CommentForm"

  componentDidMount: ->
    self = this

    autosize($(@refs.comment))

    $(@refs.comment)
      .keydown (e) ->
        if e.keyCode is 13 and !e.shiftKey
          e.preventDefault()

          self.handleSubmit(e)

  handleSubmit: (e) ->
    e.preventDefault()

    unless $(@refs.comment).val() is ''
      CommentCollection.insert
        commentable:
          commentableType: @props.commentable.type
          commentableId:   @props.commentable.id

        authorId: Meteor.userId()
        content: $(@refs.comment).val()

      $(@refs.comment).val ''
      autosize.update $(@refs.comment)

  render: ->
    <form ref='comment_form' onSubmit={ @handleSubmit }>
      <span>
        <textarea ref='comment' placeholder="Add what you think">
        </textarea>
      </span>
    </form>

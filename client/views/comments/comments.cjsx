@Comments = React.createClass
  displayName: "Comments"

  mixins: [ReactMeteorData]

  getMeteorData: ->
    Meteor.subscribe 'comments',
      type: @props.commentable.type
      id:   @props.commentable.id

    comments: CommentCollection.find(
      commentable:
        commentableType: @props.commentable.type
        commentableId:   @props.commentable.id
      ).fetch()

  renderComments: ->
    _.map @data.comments, (comment) ->
      <Comment key={ comment._id } comment={ comment } />

  render: ->
    <ul className='comments'>{ @renderComments() }</ul>

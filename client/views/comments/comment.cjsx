@Comment = React.createClass
  displayName: "Comment"

  mixins: [ReactMeteorData]

  getMeteorData: ->
    author: Meteor.users.findOne({ _id: @props.comment.authorId })

  getDefaultProps: ->
    comment:
      authorId: null
      content: "Lorem ipsum Cillum cillum aliqua qui eiusmod in fugiat elit incididunt fugiat reprehenderit."
      createdAt: new Date()

  getCreatedAt: ->
    moment(@props.comment.createdAt).fromNow()

  componentDidMount: ->
    $(@refs.paragraph).html(Emojis.parse($(@refs.paragraph).text()))

  render: ->
    user = new User(@data.author._id)

    <li className='comment'>
      <section className='comment_infos'>
        <div className='author_image'>
          <img src={ user.profile_picture } />
        </div>

        <span className='author_name'>{ user.full_name }</span>
        <span className='created_at'>{ @getCreatedAt() }</span>
      </section>

      <p ref='paragraph'>
        { @props.comment.content }
      </p>
    </li>

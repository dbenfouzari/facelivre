@StatusV2 = React.createClass
  displayName: "StatusV2"

  mixins: [ReactMeteorData]

  getMeteorData: ->
    author: Meteor.users.findOne _id: @props.status.authorId
    attachment: AssetsCollection.findOne
      owner:
        type: 'Status'
        id: @props.status._id

    comments: CommentCollection.find(
      commentable:
        commentableType: 'Status'
        commentableId: @props.status._id
    ).fetch()

    likers: Meteor.users.find(
      _id:
        $in: @props.status.likers || []
    ).fetch()

  handleRemove: (e) ->
    e.preventDefault()

    attachment = @data.attachment
    comments   = @data.comments

    if attachment
      AssetsCollection.remove _id: attachment._id

    if comments.length > 0
      Meteor.call 'removeComments', _.map(comments, (comment) -> comment._id)

    StatusCollection.remove _id: @props.status._id

  handleEdit: (e) ->
    e.preventDefault()

  doILike: ->
    _.contains(@props.status.likers, Meteor.userId())

  getLikesLabel: ->
    if @props.status.likers
      likes_count = @props.status.likers.length
      likers_users = @data.likers

      if likes_count > 0
        phrase = if likes_count is 1
          user = new User(likers_users[0]._id).full_name
          "#{user} aime"

        else
          users = _.map likers_users, (liker) ->
            user = new User(liker._id)
            user.full_name

          names = if users.length is 2
            users.join(' et ')

          else
            last_name = users.pop()

            names = users.join(', ')
            names = names + " et " + last_name

          "#{names} aiment"

        <span className='likes_count'
              title={ phrase }>
          { likes_count }
        </span>

  handleLike: (e) ->
    e.preventDefault()
    if _.contains(@props.status.likers, Meteor.userId())
      StatusCollection.update
        _id: @props.status._id
      , $pull:
        likers: Meteor.userId()

    else
      StatusCollection.update
        _id: @props.status._id
      , $push:
        likers: Meteor.userId()

  getCommentsLabel: ->
    comments_count = @data.comments.length

    if comments_count > 0
      phrase = if comments_count is 1
        "1 personne a commenté"
      else
        "#{comments_count} personnes ont commenté"

      return (
        <span className='comments_count'
              title={ phrase }>
          { comments_count }
        </span>
      )

  handleShowComments: (e) ->
    e.preventDefault()

    $(@refs.btn_comments).toggleClass 'active'
    $(@refs.section_comments).toggleClass 'active'

  renderAttachment: ->
    if @data.attachment
      <img src={ Meteor._relativeToSiteRootUrl('/uploads/' + @data.attachment.uri) } />

  componentDidMount: ->
    $(@refs.paragraph).html(Emojis.parse($(@refs.paragraph).text()))

  getCommentable: ->
    type: 'Status'
    id: @props.status._id

  render: ->
    author = new User(@data.author._id)

    <li className='status_container'>
      <div className='author_image'>
        <img src={ author.profile_picture } />
      </div>

      <div className='status'>
        <header>
          { if @props.status.authorId is Meteor.userId()
            <div>
              <a href='#' ref='remove_status' onClick={ @handleRemove } >
                <i className='fa fa-trash'></i>
              </a>
              <a href='#' ref='edit_status' onClick={ @handleEdit } >
                <i className='fa fa-pencil'></i>
              </a>
            </div>
           }
          <span className='author_name'>{ author.full_name }</span>

          <abbr title={ moment(@props.status.createdAt).format('LLLL') }
                className='time_ago'>
            { moment(@props.status.createdAt).fromNow() }
          </abbr>
        </header>

        <section className='content'>
          { @renderAttachment() }
          <p ref='paragraph'>
            { @props.status.status }
          </p>
        </section>

        <section className='bottom'>
          <ul className='actions'>
            <li>
              <a href='#' className={ @doILike() } onClick={ @handleLike } >
                <i className='fa fa-heart'></i>
                { @getLikesLabel() }
                Like
              </a>
            </li>
            <li>
              <a href='#' ref='btn_comments' onClick={ @handleShowComments } >
                <i className='fa fa-comments-o'></i>
                { @getCommentsLabel() }
                Comment
              </a>
            </li>
            <li>
              <a href='#'>
                <i className='fa fa-share-alt'></i>
                Share
              </a>
            </li>
          </ul>
        </section>

        <section className='comments' ref='section_comments'>
          <Comments commentable={ @getCommentable() } />
          <CommentForm commentable={ @getCommentable() } />
        </section>
      </div>
    </li>

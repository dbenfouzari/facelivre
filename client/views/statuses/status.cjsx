@Status = React.createClass
  displayName: "Status"

  mixins: [ReactMeteorData]

  getDefaultProps: ->
    status:
      authorId: null
      status: 'Lorem ipsum Consequat minim dolor aliquip eu deserunt ea nisi
              fugiat sed nulla irure tempor id incididunt velit.'
      createdAt: new Date()
      updatedAt: new Date()

  getMeteorData: ->
    author: Meteor.users.findOne({_id: @props.status.authorId})

    comments: CommentCollection.find(
      commentable:
        commentableType: 'Status'
        commentableId: @props.status._id
    ).fetch()

    likers: Meteor.users.find(
      _id:
        $in: @props.status.likers || []
    ).fetch()

  componentDidMount: ->
    $(@refs.paragraph).html(Emojis.parse($(@refs.paragraph).text()))

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

  doILike: ->
    _.contains(@props.status.likers, Meteor.userId())

  renderTimeAgo: ->
    moment(@props.status.createdAt).fromNow()

  handleShowComments: (e) ->
    e.preventDefault()

    $(@refs.btn_comment).toggleClass 'active'
    $(@refs.section_comments).toggleClass 'active'
    $(@refs.section_comments).find('textarea').focus()

    @props.onUpdate()

  getCommentable: ->
    type: 'Status'
    id: @props.status._id

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

  render: ->
    user = new User(@props.status.authorId)

    <div className='status_wrapper'>
      <section className='status_header'
               style={{ backgroundImage: "url(#{@data.author.profile.cover})"}}>
        <div className='status_author_image_wrapper'>
          <img className='status_author_image'
               src={ @data.author.profile.image }
          />
        </div>

        <span className='author_name'>{ user.full_name }</span>

        <div className='status_infos'>
          <span className='status_timeago'>{ @renderTimeAgo() }</span>
        </div>
      </section>

      <section className='status_content'>
        <p ref='paragraph'>{ @props.status.status }</p>
      </section>

      <section className='status_actions'>
        <a href='#' onClick={ @handleLike } className={ @doILike() }>
          { @getLikesLabel() }
          Like
        </a>
        <a href='#' onClick={ @handleShowComments } ref='btn_comment'>
          { @getCommentsLabel() }
          Comment
        </a>
        <a href='#'>Share</a>
      </section>

      <section className='comments' ref='section_comments'>
        <Comments commentable={ @getCommentable() } />
        <CommentForm onUpdate= { @props.onUpdate }
                     commentable={ @getCommentable() } />
      </section>
    </div>

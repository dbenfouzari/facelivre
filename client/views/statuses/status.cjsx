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
        <a href='#' onClick={ @handleLike } className={ @doILike() }>Like</a>
        <a href='#'>Comment</a>
        <a href='#'>Share</a>
      </section>
    </div>

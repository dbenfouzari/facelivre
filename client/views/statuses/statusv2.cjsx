@StatusV2 = React.createClass
  displayName: "StatusV2"

  mixins: [ReactMeteorData]

  getMeteorData: ->
    author: Meteor.users.findOne _id: @props.status.authorId
    attachment: AssetsCollection.findOne
      owner:
        type: 'Status'
        id: @props.status._id

  doILike: ->
    _.contains(@props.status.likers, Meteor.userId())

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

  renderAttachment: ->
    if @data.attachment
      <img src={ Meteor._relativeToSiteRootUrl('/uploads/' + @data.attachment.uri) } />

  componentDidMount: ->
    $(@refs.paragraph).html(Emojis.parse($(@refs.paragraph).text()))

  render: ->
    author = new User(@data.author._id)

    <li className='status_container'>
      <div className='author_image'>
        <img src={ author.profile_picture } />
      </div>

      <div className='status'>
        <header>
          <span className='author_name'>{ author.full_name }</span>

          <abbr title={ moment(@props.status.createdAt).format('LLLL') }
                className='time_ago'>
            { moment(@props.status.createdAt).fromNow() }
          </abbr>
        </header>

        <div className='content'>
          { @renderAttachment() }
          <p ref='paragraph'>
            { @props.status.status }
          </p>
        </div>

        <div className='bottom'>
          <ul className='actions'>
            <li>
              <a href='#' className={ @doILike() } onClick={ @handleLike } >
                <i className='fa fa-heart'></i>
                Like
              </a>
            </li>
            <li>
              <a href='#'>
                <i className='fa fa-comments-o'></i>
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
        </div>
      </div>
    </li>

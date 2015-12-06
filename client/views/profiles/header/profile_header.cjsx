@ProfileHeader = React.createClass
  displayName: 'ProfileHeader'

  mixins: [ReactMeteorData]

  contextTypes:
    user: React.PropTypes.object.isRequired

  childContextTypes:
    address: React.PropTypes.object

  getChildContext: ->
    address: @context.user.profile.address

  handleImageUpload: ->
    $(@refs.profile_pic_file).click()

  getMeteorData: ->
    user = new User(@context.user._id)

    image: user.profile_picture

  componentDidMount: ->
    self = this
    $(@refs.profile_pic_file).change (e) ->
      existingPic = AssetsCollection.findOne(
        owner:
          type: 'User'
          id: self.context.user._id)

      if existingPic
        Meteor.call 'removeAsset', existingPic._id

      new AssetUpload e.target.files[0],
        owner_type: 'User'
        owner_id: self.context.user._id

  render: ->
    user = new User(@context.user._id)

    <header>
      <input type='file' ref='profile_pic_file' accept='image/*' />
      <div className='profile_picture_wrapper'>
        <img src={ @data.image } />
        { if @context.user._id is Meteor.userId()
          <span className='edit' onClick={ @handleImageUpload } >
            <i className='fa fa-pencil'></i>
          </span>
        }
      </div>

      <ProfileHeaderMap />

      <div className='friends_sample'>
        <div className='friend_sample'
             style={{ backgroundImage: "url('https://s3.amazonaws.com/uifaces/faces/twitter/csswizardry/128.jpg')" }}>
        </div>
        <div className='friend_sample'
             style={{ backgroundImage: "url('https://s3.amazonaws.com/uifaces/faces/twitter/adellecharles/128.jpg')" }}>
        </div>
        <div className='friend_sample'
             style={{ backgroundImage: "url('https://s3.amazonaws.com/uifaces/faces/twitter/tomaslau/128.jpg')" }}>
        </div>
        <div className='friend_sample'
             style={{ backgroundImage: "url('https://s3.amazonaws.com/uifaces/faces/twitter/vladarbatov/128.jpg')" }}>
        </div>
        <div className='friend_sample'
             style={{ backgroundImage: "url('https://s3.amazonaws.com/uifaces/faces/twitter/nuraika/128.jpg')" }}>
        </div>
        <div className='friend_sample'
             style={{ backgroundImage: "url('https://s3.amazonaws.com/uifaces/faces/twitter/madysondesigns/128.jpg')" }}>
        </div>
        <div className='friend_sample'
             style={{ backgroundImage: "url('https://s3.amazonaws.com/uifaces/faces/twitter/danbenoni/128.jpg')" }}>
        </div>
        <div className='friend_sample'
             style={{ backgroundImage: "url('https://s3.amazonaws.com/uifaces/faces/twitter/uxceo/128.jpg')" }}>
        </div>
        <div className='friend_sample'>
          <div>
            <span className='number'>{ user.friends.length }</span>
            <span>Friends</span>
          </div>
        </div>
      </div>

      <div className='profile_infos_container'>
        <div className='profile_infos'>
          <Editable allowedId={ @context.user._id }
                    name='profile.first_name'
                    collection={ Meteor.users }
                    id={ @context.user._id } >
            <h1 className='profile_username'>{ @context.user.profile.first_name }</h1>
          </Editable>
          <Editable allowedId={ @context.user._id }
                    name='profile.last_name'
                    collection={ Meteor.users }
                    id={ @context.user._id } >
            <h1 className='profile_username'>{ @context.user.profile.last_name }</h1>
          </Editable>
          <br/>
          <span className='birthday'>
            <i className='fa fa-gift'></i>

            <Editable allowedId={ @context.user._id }
                      name='profile.birthday'
                      collection={ Meteor.users }
                      id={ @context.user._id }
                      type='Date' >
              { moment(@context.user.profile.birthday).format('DD MMMM YYYY')}
            </Editable>
          </span>

          <span className='phone_number'>
            <i className='fa fa-phone'></i>

            <Editable allowedId={ @context.user._id }
                      name='profile.phone'
                      collection={ Meteor.users }
                      id={ @context.user._id }
                      type='Phone' >
              { @context.user.profile.phone || '00 00 00 00 00' }
            </Editable>
          </span>
        </div>
      </div>
    </header>

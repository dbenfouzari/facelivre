@Profile = React.createClass
  mixins: [ReactMeteorData]

  getDefaultProps: ->
    params: {}
    profile:
      slug: null

  getMeteorData: ->
    id = @props.profile.slug or @props.params.user_slug

    user: Meteor.users.findOne
      slug: id

  renderContent: ->
    user = new User(@data.user._id)

    <div className='profile'>
      <header>
        <div className='profile_picture_wrapper'>
          <img src={ user.profile_picture } />
        </div>

        <div className='profile_map'>
          <img src="http://maps.googleapis.com/maps/api/staticmap?center=60+Rue+Saint+Jacques+59200+Tourcoing+France&zoom=13&size=400x180&key=AIzaSyCp9hc_oaRsmVV7UDA1utGlf_pq125SVho"/>
          <div className='profile_address'>
            <div>Tourcoing, <br/>59200 France</div>
          </div>
        </div>

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
            <Editable allowedId={ @data.user._id }
                      name='profile.first_name'
                      collection={ Meteor.users }
                      id={ @data.user._id } >
              <h1 className='profile_username'>{ @data.user.profile.first_name }</h1>
            </Editable>
            <Editable allowedId={ @data.user._id }
                      name='profile.last_name'
                      collection={ Meteor.users }
                      id={ @data.user._id } >
              <h1 className='profile_username'>{ @data.user.profile.last_name }</h1>
            </Editable>
            <br/>
            <span className='birthday'>
              <i className='fa fa-gift'></i>

              <Editable allowedId={ @data.user._id }
                        name='profile.birthday'
                        collection={ Meteor.users }
                        id={ @data.user._id }
                        type='Date' >
                { moment(@data.user.profile.birthday).format('DD MMMM YYYY')}
              </Editable>
            </span>

            <span className='phone_number'>
              <i className='fa fa-phone'></i>

              <Editable allowedId={ @data.user._id }
                        name='profile.phone'
                        collection={ Meteor.users }
                        id={ @data.user._id }
                        type='Phone' >
                { @data.user.profile.phone || '00 00 00 00 00' }
              </Editable>
            </span>
          </div>
        </div>

      </header>
    </div>

  render: ->
    if @data.user
      @renderContent()
    else
      <p>Loading...</p>

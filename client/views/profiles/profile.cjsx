@Profile = React.createClass
  mixins: [ReactMeteorData]

  getMeteorData: ->
    id = if Session.get('selected') then Session.get('selected') else @props.params.id

    user: Meteor.users.findOne
      _id: id

  getMapDims: ->
    width = $('.profile_map').width()
    height = $('.profile_picture_wrapper').height()

    [width, height].join('x')

  componentDidMount: ->
    map_dims = @getMapDims()
    link = "http://maps.googleapis.com/maps/api/staticmap?center=60+Rue+Saint+Jacques+59200+Tourcoing+France&zoom=13&size=#{map_dims}&key=AIzaSyCp9hc_oaRsmVV7UDA1utGlf_pq125SVho"
    img = $("<img src='#{link}'/>")

    $('.profile_map').prepend img

  render: ->
    user = new User(@data.user._id)

    <div data-mcs-theme='minimal-dark'
         data-mcs-axis='y'
         className='mCustomScrollbar profile'>
      <div className='profile-header'>
        <figure className='profile-cover'
                style={{backgroundImage: "url(#{user.cover_picture})" }} >
        </figure>
        <figure className='profile-profilePic'>
          <img src={ user.profile_picture } />
        </figure>
        <span className='profile-name'>
          { user.full_name }
        </span>
      </div>
    </div>

    <div className='profile'>
      <header>

        <div className='profile_picture_wrapper'>
          <img src={ user.profile_picture } />
        </div>

        <div className='profile_map'>
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
            <h1 className='profile_username'>Donovan Benfouzari</h1>
            <span className='birthday'>
              <i className='fa fa-gift'></i>11 November 1991
            </span>

            <span className='phone_number'>
              <i className='fa fa-phone'></i>06 77 78 38 41
            </span>
          </div>
        </div>

      </header>
    </div>

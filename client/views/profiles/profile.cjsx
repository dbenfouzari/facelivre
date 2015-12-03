@Profile = React.createClass

  childContextTypes:
    user: React.PropTypes.object

  getChildContext: ->
    user: @data.user

  mixins: [ReactMeteorData]

  getDefaultProps: ->
    params: {}
    profile:
      slug: null

  getMeteorData: ->
    id = @props.profile.slug or @props.params.user_slug

    user: Meteor.users.findOne
      slug: id

  renderMap: ->
    user = new User(@data.user._id)
    if user.address
      latlon = [
        user.address.position.coordinates[1],
        user.address.position.coordinates[0]
      ].join(',')

      return(
        <div className='profile_map'>
          <img src="http://maps.googleapis.com/maps/api/staticmap?center=#{latlon}&zoom=13&size=400x180&key=AIzaSyCp9hc_oaRsmVV7UDA1utGlf_pq125SVho"/>

          <div className='profile_address'>
            <div>
              <Editable allowedId={ @data.user._id }
                        name=''
                        collection={ AddressCollection }
                        id={ user.address._id }
                        type='Address' >
                { user.address.to_s if user.address }
              </Editable>
            </div>
          </div>
        </div>
      )

    else

      return(
        <div className='profile_map'>
          <img src='http://dummyimage.com/400x180/e9e5dc/ffffff.jpg&text=No+address'/>

          { if @data.user._id is Meteor.userId()
            <Editable allowedId={ @data.user._id }
                      name=''
                      collection={ AddressCollection }
                      type='Address' >
              Set yours
            </Editable>
          }
        </div>
      )

  renderContent: ->
    user = new User(@data.user._id)

    <div className='profile'>
      <ProfileHeader />
    </div>

  render: ->
    if @data.user
      @renderContent()
    else
      <p>Loading...</p>

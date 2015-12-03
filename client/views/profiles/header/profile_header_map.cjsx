@ProfileHeaderMap = React.createClass
  displayName: 'ProfileHeaderMap'

  contextTypes:
    address: React.PropTypes.object.isRequired
    user: React.PropTypes.object.isRequired

  getAddressCoordinates: ->
    if @context.address
      [
        @context.address.position.coordinates[1],
        @context.address.position.coordinates[0]
      ].join(',')

  renderMap: ->
    if @context.address and @context.address.position
      base_api_url = 'http://maps.googleapis.com/maps/api/staticmap?'
      api_key = 'AIzaSyCp9hc_oaRsmVV7UDA1utGlf_pq125SVho'
      params =
        center: @getAddressCoordinates()
        zoom:   13
        size:   '400x180'
        key:    api_key

      array_string_params = _.map params, (value, key) ->
        "#{key}=#{value}"

      url = base_api_url + array_string_params.join('&')

    else
      base_api_url = "http://dummyimage.com/"
      params =
        size:       '400x180'
        background: 'E9E5D9'
        foreground: 'FFFFFF'
      extension = 'jpg'
      text      = 'No address'

      array_string_params = _.map params, (value, key) ->
        "#{value}"

      url = "#{base_api_url}/#{array_string_params.join('/')}.#{extension}&text=#{text}"

    <img src={ url }/>


  displayAddress: (isFilled) ->
    if isFilled
      address = @context.address
      "#{address.street_number} #{address.route}, #{address.postal_code} #{address.city}"
    else
      'Set your address'

  renderAddress: ->
    klass = 'profile_address'
    isFilled = false

    if @context.address.position
      address = @displayAddress(true)
      <ProfileHeaderMapAddress address={ address } />

    else
      address = @displayAddress(false)
      if Meteor.userId() is @context.user._id
        <ProfileHeaderMapAddress address={ address } />

  render: ->
    <div className='profile_map'>
      { @renderMap() }
      { @renderAddress() }
    </div>

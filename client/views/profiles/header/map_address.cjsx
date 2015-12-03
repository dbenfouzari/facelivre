@ProfileHeaderMapAddress = React.createClass
  displayName: 'ProfileHeaderMapAddress'

  contextTypes:
    user: React.PropTypes.object.isRequired

  getDefaultProps: ->
    address: ''

  render: ->
    <div className='profile_address'>
      <div>
        <Editable allowedId={ @context.user._id }
                  name='profile.address'
                  collection={ Meteor.users }
                  id={ @context.user._id }
                  type='Address' >
          { @props.address }
        </Editable>
      </div>
    </div>

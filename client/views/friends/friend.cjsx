@Friend = React.createClass
  displayName: "Friend"

  mixins: [ReactMeteorData]

  getMeteorData: ->
    friendship: FriendShipsCollection.findOne
      $or: [
        emitter: Meteor.userId()
        receiver: @props.friend._id
      ,
        emitter: @props.friend._id
        receiver: Meteor.userId()
      ]

  handleFollow: ->
    if @data.friendship
      # Unfollow
      FriendShipsCollection.remove _id: @data.friendship._id
    else
      # Follow
      FriendShipsCollection.insert
        emitter: Meteor.userId()
        receiver: @props.friend._id

  triggerFlip: ->
    $el = $(ReactDOM.findDOMNode(@))
    $el.toggleClass 'hovered'

  render: ->

    <li className='friend'>
      <div className='card'>
        <FriendFront friend={ @props.friend } onFollow={ @handleFollow } onFlip={ @triggerFlip }/>
        <FriendBack onFollow={ @handleFollow } onFlip={ @triggerFlip }/>
      </div>
    </li>

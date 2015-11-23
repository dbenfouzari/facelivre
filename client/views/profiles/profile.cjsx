@Profile = React.createClass
  mixins: [ReactMeteorData]

  getMeteorData: ->
    profile: Meteor.users.findOne({ _id: @props.params.id })

  render: ->
    <header>
      <h1>Hello world</h1>
    </header>
    <h1>Hello { @data.profile.username } !</h1>

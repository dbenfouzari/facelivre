@Status = React.createClass
  displayName: "Status"

  getDefaultProps: ->
    status:
      author: null
      status: 'Lorem ipsum Consequat minim dolor aliquip eu deserunt ea nisi
              fugiat sed nulla irure tempor id incididunt velit.'
      createdAt: new Date()
      updatedAt: new Date()

  render: ->
    <h1>{ @props.status.status }</h1>

@Messages = React.createClass
  displayName: "Messages"

  destroyScrollBar: ->
    $(ReactDOM.findDOMNode(@)).mCustomScrollbar 'destroy'

  scrollToBottom: ->
    $node = $(ReactDOM.findDOMNode(@))
    $node.scrollTo $node.children().last(), 500,
      interrupt: true

  componentDidMount: ->
    $node = $(ReactDOM.findDOMNode(@))

    @scrollToBottom()

  createScrollBar: ->
    node = ReactDOM.findDOMNode @

    $(node).mCustomScrollbar
      theme: 'light'
      scrollInertia: 200
      scrollButtons:
        enable:true
      advanced:
        autoScrollOnFocus: false
        updateOnContentResize: true

  componentDidUpdate: ->
    $node = $(ReactDOM.findDOMNode(@))
    @scrollToBottom()

  renderMessages: ->
    _.map @props.messages, (message) ->
      <Message key={ message._id } message={ message } />

  render: ->
    <ul className='msgbox-messages' data-mcs-axis='y'
        data-mcs-theme='minimal-dark'>
      { this.renderMessages() }
    </ul>

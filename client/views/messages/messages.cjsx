@Messages = React.createClass
  displayName: "Messages"

  destroyScrollBar: ->
    $(ReactDOM.findDOMNode(@)).mCustomScrollbar 'destroy'

  componentDidMount: ->
    $node = $(ReactDOM.findDOMNode(@))
    setTimeout @createScrollBar, 800
    setTimeout ->
      $node.mCustomScrollbar('scrollTo', 'bottom')
    , 500

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
    @destroyScrollBar()
    setTimeout @createScrollBar, 100
    setTimeout ->
      $node.mCustomScrollbar('scrollTo', 'bottom', {scrollInertia: 0})
    , 100

  componentWillUnmount: ->
    @destroyScrollBar()

  componentWillUpdate: ->
    @destroyScrollBar()

  renderMessages: ->
    _.map @props.messages, (message) ->
      <Message key={ message._id } message={ message } />

  render: ->
    <ul className='msgbox-messages' data-mcs-axis='y'
        data-mcs-theme='minimal-dark'>
      { this.renderMessages() }
    </ul>

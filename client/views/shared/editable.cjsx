@Editable = React.createClass
  displayName: 'Editable'

  getInitialState: ->
    editing: false
    previousText: ''

  getDefaultProps: ->
    type: 'String'

  humanizeField: ->
    field = @props.name
    field.replace(/_|\.|-/g, ' ')

  formatShownToFormatted: (string) ->
    moment(string, 'DD MMM YYYY').format('YYYY-MM-DD')

  formatFormattedToDate: (string) ->
    new Date moment(string, 'YYYY-MM-DD')

  handleClick: (e) ->
    self = this

    if $(@refs.editable).hasClass 'editable'
      unless @state.editing
        $el = $(@refs.editable)
        previousText = if $el.children().length > 0
          $el.children().text()
        else
          $el.text()

        if @props.type is 'Date'
          previousText = @formatShownToFormatted(previousText)
          $input = $("<input class='editable-input' value='#{previousText}' type='date'>")

        else if @props.type is 'Phone'
          $input = $("<input class='editable-input' value='#{previousText}' type='tel'>")

        else
          $input = $("<input class='editable-input' value='#{previousText}'/>")

        $container = $("<div class='editable-container'>
          <h3 class='editable-title'>Enter #{@humanizeField(@props.name)}</h3>
        </div>")
        $content = $("<div class='editable-content'></div>")
        $arrow = $("<div class=arrow></div>")
        $form = $("<form class='editable-form'></form>")

        $buttons = $('<div></div>')
        # $input = $("<input class='editable-input' value='#{previousText}'/>")
        $submit = $("<button type='submit' class='btn btn-primary editable-submit'>Go</button>")

        $container.append $arrow
        $buttons.append $input
        $buttons.append $submit
        $form.append $buttons
        $content.append $form
        $container.append $content
        $el.append $container

        setTimeout ->
          $container.css "opacity", 1
        , 10

        $container.click (e) ->
          e.stopPropagation()

        $form.submit (e) ->
          e.preventDefault()
          value = $input.val()

          if self.props.type is 'Date'
            value = self.formatFormattedToDate(value)

          if value != previousText
            obj = {}
            obj["#{self.props.name}"] = value

            self.props.collection.update({_id: self.props.id}, {$set: obj})
          self.removeContainer(self)

        $(document).click ->
          self.removeContainer(self)

        self.setState editing: true

      else
        self.removeContainer(self)

  removeContainer: (obj) ->
    if obj.isMounted()
      $container = $(ReactDOM.findDOMNode(obj)).find('.editable-container')
      $container.css "opacity", 0

      setTimeout ->
        $container.remove()
        if obj.isMounted()
          obj.setState editing: false
      , 200

  getClassName: ->
    if @props.allowedId is Meteor.userId()
      'editable'

  render: ->
    <span ref='editable' className={ @getClassName() } onClick={ @handleClick } >
      { @props.children }
    </span>

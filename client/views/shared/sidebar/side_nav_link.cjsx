@SideNavLink = React.createClass
  displayName: "SideNavLink"
  contextTypes:
    location: React.PropTypes.object
    history: React.PropTypes.object

  render: ->
    history = this.context.history
    isActive = history.isActive(this.props.to, this.props.params, this.props.query)

    return (
      <li className={if isActive then 'active' else null}>
        <Link {...this.props}>{this.props.children}</Link>
      </li>
    )

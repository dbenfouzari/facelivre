@SideNavLink = React.createClass
  displayName: "SideNavLink"

  mixins: [History]

  render: ->
    isActive = this.history.isActive(this.props.to, this.props.query, false)

    return (
      <li className={if isActive then 'active' else null}>
        <Link {...this.props}>{this.props.children}</Link>
      </li>
    )

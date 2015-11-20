Meteor.startup(function() {
  ReactRouterSSR.Run((<Routes/>), { rootElement: 'facelivre' })
})

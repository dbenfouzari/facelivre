const { Route, IndexRoute } = ReactRouter;
const history = ReactRouter.history.useQueries(ReactRouter.history.createHistory)()

Meteor.startup(function() {
  ReactRouterSSR.Run((
    <Route path='/' component={ Facelivre } >
      <IndexRoute component={ NewsFeed } />
      <Route path='/:id' component={ Profile } />
    </Route>
  ), {
    rootElement: 'facelivre'
  })
})

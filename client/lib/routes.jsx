const { Route, IndexRoute } = ReactRouter;
const history = ReactRouter.history.useQueries(ReactRouter.history.createHistory)()

Meteor.startup(function() {
  ReactRouterSSR.Run((
    <Route path='/' component={ Facelivre } >
      <IndexRoute component={ NewsFeed } />
      <Route path='/feed' component={ NewsFeed } />
      <Route path='/friends' component={ Friends } />
      <Route path='/messages' component={ MessagesHandler }>
        <Route path=':user_slug' component={ MessagesHandler } />
      </Route>
      <Route path='/:user_slug' component={ Profile } />
    </Route>
  ), {
    rootElement: 'facelivre'
  })
});

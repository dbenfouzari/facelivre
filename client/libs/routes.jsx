const { Route, IndexRoute } = ReactRouter;
const history = ReactRouter.history.useQueries(ReactRouter.history.createHistory)();

export class Routes extends React.Component {
  render() {
    return (
      <Route path='/' component={ Facelivre } >
        <Route path='/products' component={ Products }/>
      </Route>
    )
  }
}

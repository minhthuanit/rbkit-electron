React = require 'react'
ReactRouter = require 'react-router'
Router = ReactRouter.Router
Route = ReactRouter.Route
App = require('./javascripts/components/app.js')

routes = (
  <Router>
    <Route path="/" component={App}>
    </Route>
  </Router>
)

document.addEventListener "DOMContentLoaded", () ->
  React.render(<Router>{routes}</Router>, document.body)

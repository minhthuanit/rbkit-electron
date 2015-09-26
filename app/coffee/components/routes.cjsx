React = require 'react'
ReactRouter = require 'react-router'
Router = ReactRouter.Router
Route = ReactRouter.Route
App = require('./javascripts/components/app.js')
Connect = require('./javascripts/components/connect.js')
Dashboard = require('./javascripts/components/dashboard.js')

routes = (
  <Router>
    <Route path="/" component={App}>
      <Route path="dashboard" component={Dashboard} />
    </Route>
  </Router>
)

document.addEventListener "DOMContentLoaded", () ->
  React.render(<Router>{routes}</Router>, document.body)

React = require 'react'
Router = require 'react-router'
Route = Router.Route
App = require('./javascripts/components/app.js')

routes = (
  <Route handler={App}>
  </Route>
)

document.addEventListener "DOMContentLoaded", () ->
  Router.run routes, Router.HashLocation, (Root) ->
    React.render(<Root/>, document.body)

React = require('react')
Router = require 'react-router'
ConnectButton = require './connect_button.js'
RouteHandler = Router.RouteHandler
Navbar = require 'react-bootstrap/lib/Navbar'
Nav = require 'react-bootstrap/lib/Nav'
NavItem = require 'react-bootstrap/lib/NavItem'

module.exports = React.createClass
  render: ->
    <div>
      <Navbar brand="Rbkit">
        <Nav>
          <NavItem eventKey={1} href="#"><ConnectButton/></NavItem>
        </Nav>
      </Navbar>

      <RouteHandler/>
    </div>

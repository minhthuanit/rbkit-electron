React = require('react')
Navbar = require 'react-bootstrap/lib/Navbar'
Nav = require 'react-bootstrap/lib/Nav'
NavItem = require 'react-bootstrap/lib/NavItem'
Glyphicon = require 'react-bootstrap/lib/Glyphicon'
Tooltip = require './tooltip.js'

module.exports = React.createClass
  render: ->
    <div>
      <Navbar brand="Rbkit" toggleNavKey={0}>
        <Nav right eventKey={0}>
            <NavItem href="#">
              <Tooltip placement="bottom" content="Click to disconnect from server">
                <Glyphicon glyph="off"/>
              </Tooltip>
            </NavItem>
        </Nav>
      </Navbar>

      <div className="container-fluid">
        <div className="row">
          {this.props.children}
        </div>
      </div>
    </div>

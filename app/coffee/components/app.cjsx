React = require('react')
Navbar = require 'react-bootstrap/lib/Navbar'
Nav = require 'react-bootstrap/lib/Nav'
NavItem = require 'react-bootstrap/lib/NavItem'
Glyphicon = require 'react-bootstrap/lib/Glyphicon'
Tooltip = require './tooltip.js'
Connect = require './connect.js'
Link = require('react-router').Link

module.exports = React.createClass
  render: ->
    <div>
      <nav className="navbar navbar-default">
        <div className="container-fluid">
          <div className="navbar-header">
            <a className="navbar-brand" href="#">
              <span><img alt="Rbkit" className="rbkit-nav-logo" src="images/rbkit-48.png"/></span>
              Rbkit
            </a>
          </div>

          <div className="collapse navbar-collapse" id="bs-example-navbar-collapse-1">
            <ul className="nav navbar-nav navbar-right">
              <li>
                <a href="#">
                  <Tooltip placement="bottom" content="Click to disconnect from server">
                    <Glyphicon glyph="off"/>
                  </Tooltip>
                </a>
              </li>
            </ul>
          </div>
        </div>
      </nav>

      <div className="container-fluid">
        <div className="row">
          {this.props.children || <Connect/>}
        </div>
      </div>
    </div>

React = require('react')
Jumbotron = require('react-bootstrap/lib/Jumbotron')
Button = require('react-bootstrap/lib/Button')
Input = require('react-bootstrap/lib/Input')
Link = require('react-router').Link

module.exports = React.createClass
  render: ->
    <div className="connect-container center-block">
      <h1>Hello, world!</h1>
      <p></p>
      <form>
        <Input type="text" placeholder="IP of server" value="127.0.0.1"/>
        <div className="text-right">
          <Link to="/dashboard">
              <Button bsStyle="primary">
                Connect
            </Button>
          </Link>
        </div>
      </form>
    </div>


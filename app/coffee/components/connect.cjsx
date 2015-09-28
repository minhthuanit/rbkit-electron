React = require('react')
Jumbotron = require('react-bootstrap/lib/Jumbotron')
Button = require('react-bootstrap/lib/Button')
Input = require('react-bootstrap/lib/Input')
Link = require('react-router').Link
ConnectionActions = require('../flux/actions/connection_actions')
ConnectionStore = require('../flux/stores/connection_store')
Reflux = require('reflux')
History = require('react-router').History

module.exports = React.createClass
  mixins: [ Reflux.listenTo(ConnectionStore, "onConnectionUpdate"), History]

  getInitialState: ->
    {}

  onConnect: ->
    ConnectionActions.connect(@refs.ip.getValue(), @refs.pubPort.getValue(), @refs.reqPort.getValue())

  onConnectionUpdate: (connection) ->
    @setState({status: connection.status})
    if connection.status == "connected"
      @history.pushState(null, '/dashboard')

  render: ->
    defaultIp = '127.0.0.1'
    defaultPubPort = process.env['RBKIT_PUB_PORT'] || '5555'
    defaultReqPort = process.env['RBKIT_REQ_PORT'] || '5556'

    <div className="connect-container center-block">
      <h1>Hello, world!</h1>
      <form>
        <Input type="text" placeholder="IP of server" ref="ip" defaultValue={defaultIp} help="IP of server"/>
        <Input type="text" placeholder="9999" ref="pubPort" defaultValue={defaultPubPort} help="Port on which server streams events"/>
        <Input type="text" placeholder="9998" ref="reqPort" defaultValue={defaultReqPort} help="Port on which server listens for commands"/>
        <div className="text-right">
          <Button bsStyle="primary" onClick={this.onConnect}>
            Connect
          </Button>
        </div>
      </form>
    </div>


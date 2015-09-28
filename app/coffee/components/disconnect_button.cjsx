React = require('react')
Glyphicon = require 'react-bootstrap/lib/Glyphicon'
Tooltip = require './tooltip.js'
Link = require('react-router').Link
ConnectionActions = require('../flux/actions/connection_actions')
ConnectionStore = require('../flux/stores/connection_store')
Reflux = require('reflux')
History = require('react-router').History

module.exports = React.createClass
  mixins: [
    Reflux.listenTo(ConnectionStore, "onStatusChange")
    History
  ]

  getInitialState: ->
    { state: 'disconnected' }

  onStatusChange: (connection) ->
    @setState({status: connection.status})
    if connection.status == 'disconnected'
      @history.pushState(null, "/")

  onDisconnect: ->
    ConnectionActions.disconnect()

  onComponentDidMount: ->
    ConnectionActions.sendMessage('handshake')


  render: ->
    if @state.status == "connected"
      <Link to="/">
        <Tooltip placement="bottom" content="Click to disconnect from server">
          <Glyphicon glyph="off" onClick={@onDisconnect}/>
        </Tooltip>
      </Link>
    else
      false

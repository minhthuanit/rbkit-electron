Reflux = require('reflux')
MessageFields = require('../../message_fields')
ConnectionActions = require('../actions/connection_actions')
EventTypes = require('../../event_types')
MessageFields = require('../../message_fields')
event_parser = require('../../events/event_parser')

zmq = require 'zmq'
msgpack = require 'msgpack'

ConectionStore = Reflux.createStore
  listenables: [ConnectionActions]

  getInitialState: ->
    {status: 'disconnected'}

  onConnect: (ip, sub_port, req_port) ->
    @sub_socket = zmq.socket('sub')
    @req_socket = zmq.socket('req')

    @req_socket.on 'message', (message) =>
      if message != "ok"
        unpacked_message = msgpack.unpack message
        if unpacked_message[MessageFields['event_type']] == EventTypes['handshake']
          @trigger({status: 'connected'})

    @sub_socket.on 'message', (message) =>
      unpacked_message = msgpack.unpack message
      if unpacked_message[MessageFields['event_type']] == EventTypes['event_collection']
        events = unpacked_message[MessageFields['payload']]
        event_parser.parse(event) for event in events

    @sub_socket.connect("tcp://#{ip}:#{sub_port}")
    @sub_socket.subscribe ''
    @req_socket.connect("tcp://#{ip}:#{req_port}")
    ConnectionActions.sendMessage('handshake')

  onDisconnect: ->
    @req_socket.close()
    @sub_socket.close()
    @trigger({status: 'disconnected'})

  onSendMessage: (message) ->
    @req_socket.send(message)

module.exports = ConectionStore

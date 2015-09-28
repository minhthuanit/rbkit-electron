Reflux = require('reflux')
ConnectionActions = require('../actions/connection_actions')
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
      if message == "ok"
        console.log(message)
      else
        unpacked_message = msgpack.unpack message
        console.log(unpacked_message)
        if unpacked_message[0] == 8 #TODO: unpacked_messages should be cast using classes
          @trigger({status: 'connected'})

        #responses.push(unpacked_message)

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

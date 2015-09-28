zmq = require 'zmq'
msgpack = require 'msgpack'

module.exports = class Connection
  constructor: (ip, sub_port, req_port, sub_callback) ->
    @connected = false
    @sub_socket = zmq.socket('sub')
    @req_socket = zmq.socket('req')
    @sub_callback = sub_callback
    #@req_callback = (message) ->

    @req_socket.on 'message', (message) ->
      if message == "ok"
        console.log(message)
        @req_callback(message)
      else
        unpacked_message = msgpack.unpack message
        console.log(unpacked_message)
        @connected = true
        @req_callback(unpacked_message)

    @sub_socket.on 'message', (message) ->
      unpacked_message = msgpack.unpack message
      console.log(unpacked_message)
      @sub_callback(unpacked_message)

  open: ->
    @sub_socket.connect("tcp://#{ip}:#{sub_port}")
    @sub_socket.subscribe ''
    @req_socket.connect("tcp://#{ip}:#{req_port}")

  close: ->
    @connected = false
    @req_socket.close()
    @sub_socket.close()

  sendCommand: (command, callback) ->
    @req_callback = callback
    @req_socket.send(command)

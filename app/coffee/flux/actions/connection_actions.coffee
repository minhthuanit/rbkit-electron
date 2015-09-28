Reflux = require('reflux')

ConnectionActions = Reflux.createActions [
  "connect",
  "disconnect",
  "sendMessage"
]

module.exports = ConnectionActions

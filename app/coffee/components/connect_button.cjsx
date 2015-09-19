React = require('react')
ReactToggle = require 'react-toggle'

module.exports = React.createClass
  getInitialState: ->
    { connected: false }

  clickHandler: ->
    @setState({connected: !@state.connected})

  render: ->
    <div>
      <ReactToggle
        defaultChecked={@state.connected}
        onChange={@clickHandler}
      />
    </div>

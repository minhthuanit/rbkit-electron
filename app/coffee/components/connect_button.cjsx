ConnectButton = React.createClass
  getInitialState: ->
    { connected: false }

  clickHandler: ->
    @setState({connected: !@state.connected})

  render: ->
    text = if @state.connected then 'Disconnect' else 'Connect'
    <a className="pure-menu-link" onClick={@clickHandler}>{text}</a>

document.addEventListener("DOMContentLoaded", () ->
  React.render(<ConnectButton/>, document.getElementById('rbkit-connect-button'))
)

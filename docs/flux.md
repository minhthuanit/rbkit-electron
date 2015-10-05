Flux in Rbkit-Electron
======================

Rbkit-Electron uses the Flux architecture for uni-directional data flow in its
React app. We are using [Reflux](https://github.com/reflux/refluxjs) library
for flux.

Here's the basic flow oversimplified:

1. Components trigger actions
2. Stores listen to actions and trigger updates to data
3. Components listen to store changes and update their state

### Example

Here's a view that triggers an action:

```coffee
<Button onClick={ConnectionActions.disconnect}/>
```

The corresponding action is defined inside an action class like so:

```coffee
ConnectionActions = Reflux.createActions [
  "disconnect"
]
```

For this action to have effects, a store should listen to this action:

```coffee
ConectionStore = Reflux.createStore
  listenables: [ConnectionActions]

  onDisconnect: ->
    @trigger({status: 'disconnected'})
```

This store update is reflected in the UI when another component's state is
updated when the store triggers updates:

```coffee
StatusIndicator = React.createClass
  mixins: [
    Reflux.listenTo(ConnectionStore, "onStatusChange")
  ]

  getInitialState: ->
    { state: 'disconnected' }

  onStatusChange: (connection) ->
    @setState({status: connection.status})

  render: ->
    if @state.status == "connected"
      <span>Connected</span>
    else
      <span>Not connected</span>
```

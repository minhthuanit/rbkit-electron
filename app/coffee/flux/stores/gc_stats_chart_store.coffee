Reflux = require('reflux')
GCStatChartActions = require('../actions/gc_stats_chart_actions')
MessageFields = require('../../message_fields')

GCStatChartStore = Reflux.createStore
  listenables: [GCStatChartActions]

  onNewStat: (event) ->
    @trigger(event[MessageFields['payload']])

module.exports = GCStatChartStore

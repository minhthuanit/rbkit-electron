EventTypes = require('../event_types')
MessageFields = require('../message_fields')
GCStatChartActions = require('../flux/actions/gc_stats_chart_actions')

class EventParser
  parse: (event) ->
    switch event[MessageFields['event_type']]
      when EventTypes['gc_stats']
        GCStatChartActions.newStat(event)

module.exports = new EventParser


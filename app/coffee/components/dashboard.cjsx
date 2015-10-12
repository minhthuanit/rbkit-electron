React = require('react')
Reflux = require('reflux')
Highcharts = require('react-highcharts')
GCStatChartStore = require('../flux/stores/gc_stats_chart_store')

module.exports = React.createClass
  mixins: [
    Reflux.listenTo(GCStatChartStore, "addStat")
  ]

  addStat: (stat) ->
    chart = @refs.chart.getChart()
    chart.series[0].addPoint(stat['total_memsize'])

  render: ->
    chartConfig = {
      chart:
        width: 800
        type: 'area'
        className: 'gc-stats-chart-container'
      xAxis:
        type: 'datetime'
        #categories: ['total_memsize']
      yAxis:
        title:
          text: null
      series: [
        {
          name: 'total_memsize'
          data: []
        }
      ]
    }

    <div>
      <div className="row chart-container text-center">
        <Highcharts config={chartConfig} className="line-chart" ref="chart"/>
      </div>
    </div>

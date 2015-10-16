React = require('react')
Reflux = require('reflux')
Highcharts = require('react-highcharts')
GCStatChartStore = require('../flux/stores/gc_stats_chart_store')

module.exports = React.createClass
  mixins: [
    Reflux.listenTo(GCStatChartStore, "addStat")
  ]

  gcCounts:
    minor: null
    major: null
  minorGcPlotlines: []
  majorGcPlotlines: []
  initialTime: new Date().getTime()

  addStat: (stat) ->
    deltaTime = (new Date().getTime() - @initialTime) / 1000
    newX = deltaTime
    chart = @refs.chart.getChart()
    chart.series[0].addPoint([newX, stat['total_memsize']])
    chart.series[1].addPoint([newX, stat['total_heap_size']])
    chart.series[2].addPoint([newX, stat['malloc_increase_bytes']])
    chart.series[3].addPoint([newX, stat['malloc_increase_bytes_limit']])
    chart.series[4].addPoint([newX, stat['old_objects']])
    chart.series[5].addPoint([newX, stat['old_objects_limit']])
    chart.series[6].addPoint([newX, stat['remembered_wb_unprotected_objects']])
    chart.series[7].addPoint([newX, stat['remembered_wb_unprotected_objects_limit']])

    if @gcCounts.minor != stat['minor_gc_count']
      @updateMinorGC(newX, stat['minor_gc_count']) if @gcCounts.minor
      @gcCounts.minor = stat['minor_gc_count']

    if @gcCounts.major != stat['major_gc_count']
      @updateMajorGC(newX, stat['major_gc_count']) if @gcCounts.major
      @gcCounts.major = stat['major_gc_count']

  updateMinorGC: (x, minorGcCount) ->
    chart = @refs.chart.getChart()
    plotLine = {
      value: x
      color: '#EC7E5A'
      width: 1
      label:
        x: -12
        text: "Minor GC #{minorGcCount}"
    }

    @minorGcPlotlines.push(plotLine)
    chart.xAxis[0].addPlotLine(plotLine)

  updateMajorGC: (x, majorGcCount) ->
    chart = @refs.chart.getChart()
    plotLine = {
      value: x
      color: 'red'
      width: 2
      label:
        x: 10
        text: "Major GC #{majorGcCount}"
    }

    @majorGcPlotlines.push(plotLine)
    chart.xAxis[0].addPlotLine(plotLine)

  render: ->
    chartConfig = {
      chart:
        width: 800
        type: 'area'
        className: 'gc-stats-chart-container'
      xAxis:
        labels:
          format: '{value}s'
      yAxis:
        title:
          text: null
      plotOptions:
        area:
          marker:
            enabled: false
      series: [
        {
          name: 'total_memsize'
          data: []
        },
        {
          name: 'total_heap_size'
          data: []
        },
        {
          name: 'malloc_increase_bytes'
          data: []
        },
        {
          name: 'malloc_increase_bytes_limit'
          data: []
        },
        {
          name: 'old_objects'
          data: []
        },
        {
          name: 'old_objects_limit'
          data: []
        },
        {
          name: 'remembered_wb_unprotected_objects'
          data: []
        },
        {
          name: 'remembered_wb_unprotected_objects_limit'
          data: []
        }
      ]
    }

    <div>
      <div className="row chart-container text-center">
        <Highcharts config={chartConfig} className="line-chart" ref="chart"/>
      </div>
    </div>

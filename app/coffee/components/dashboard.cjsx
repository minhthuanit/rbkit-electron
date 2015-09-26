React = require('react')
LineChart = require('react-chartjs').Line
DummyChartData = require('../dummy_chart_data')

module.exports = React.createClass
  render: ->
    <div>
      <div className="row chart-container text-center">
        <LineChart data={DummyChartData.lineChartData} width="600" height="150" className="line-chart"/>
      </div>
      <div className="row chart-container text-center">
        <LineChart data={DummyChartData.lineChartData} width="600" height="150" className="line-chart"/>
      </div>
    </div>

import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class LineChart extends StatefulWidget {
  final String title;
  final String dataType;
  final String title2;
  const LineChart({super.key, required this.title, required this.dataType, required this.title2});

  @override
  State<LineChart> createState() => _LineChartState();
}

class _LineChartState extends State<LineChart> {
  List<_ChartData>? chartData;

  @override
  void initState() {
    chartData = <_ChartData>[
      _ChartData("15:10", 21, 28),
      _ChartData("15:20", 24, 44),
      _ChartData("15:30", 36, 48),
      _ChartData("15:40", 38, 50),
      _ChartData("15:50", 54, 66),
      _ChartData("16.00", 57, 78),
      _ChartData("16.10", 70, 84)
    ];
    super.initState();
  }

  @override
  void dispose() {
    chartData!.clear();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return _buildDefaultLineChart();
  }

  SfCartesianChart _buildDefaultLineChart() {
    return SfCartesianChart(
      plotAreaBorderWidth: 0,
      title: ChartTitle(text: widget.title),
      legend:
          Legend(isVisible: true, overflowMode: LegendItemOverflowMode.wrap),
      primaryXAxis: const CategoryAxis(
          edgeLabelPlacement: EdgeLabelPlacement.shift,
          majorGridLines: MajorGridLines(width: 0)),
      primaryYAxis: NumericAxis(
          labelFormat: '{value}${widget.dataType}',
          axisLine: AxisLine(width: 0),
          majorTickLines: MajorTickLines(color: Colors.transparent)),
      series: _getDefaultLineSeries(),
      tooltipBehavior: TooltipBehavior(enable: true),
    );
  }

  /// The method returns line series to chart.
  List<LineSeries<_ChartData, String>> _getDefaultLineSeries() {
    return <LineSeries<_ChartData, String>>[
      LineSeries<_ChartData, String>(
          dataSource: chartData,
          xValueMapper: (_ChartData sales, _) => sales.x,
          yValueMapper: (_ChartData sales, _) => sales.y,
          name: widget.title2,
          markerSettings: const MarkerSettings(isVisible: true)),
      // LineSeries<_ChartData, num>(
      //     dataSource: chartData,
      //     name: 'England',
      //     xValueMapper: (_ChartData sales, _) => sales.x,
      //     yValueMapper: (_ChartData sales, _) => sales.y2,
      //     markerSettings: const MarkerSettings(isVisible: true))
    ];
  }
}

class _ChartData {
  _ChartData(this.x, this.y, this.y2);
  final String x;
  final double y;
  final double y2;
}

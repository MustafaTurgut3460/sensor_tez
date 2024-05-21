import 'package:flutter/material.dart';
import 'package:sensor_tez/components/line_chart.dart';

class GraphsPage extends StatefulWidget {
  const GraphsPage({super.key});

  @override
  State<GraphsPage> createState() => _GraphsPageState();
}

class _GraphsPageState extends State<GraphsPage> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              padding: EdgeInsets.all(16),
              width: MediaQuery.of(context).size.width-16,
              height: MediaQuery.of(context).size.width,
              child: LineChart(title: "Nem Grafiği", dataType: "%", title2: "Nem Oranı",),
            ),
        
            Container(
              padding: EdgeInsets.all(16),
              width: MediaQuery.of(context).size.width-16,
              height: MediaQuery.of(context).size.width,
              child: LineChart(title: "Sıcaklık Grafiği", dataType: " C", title2: "Sıcaklık Miktarı",),
            ),
        
            Container(
              padding: EdgeInsets.all(16),
              width: MediaQuery.of(context).size.width-16,
              height: MediaQuery.of(context).size.width,
              child: LineChart(title: "Işık Grafiği", dataType: " lüx", title2: "Işık Miktarı",),
            ),

            Container(
              padding: EdgeInsets.all(16),
              width: MediaQuery.of(context).size.width-16,
              height: MediaQuery.of(context).size.width,
              child: LineChart(title: "Hava Kalitesi Grafiği", dataType: " ppm", title2: "Hava Kalitesi",),
            ),
          ],
        ),
      ),
    );
  }
}

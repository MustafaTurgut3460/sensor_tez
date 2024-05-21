import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_gauges/gauges.dart';
import 'package:tailwind_colors/tailwind_colors.dart';

class LightComponent extends StatefulWidget {
  final dynamic data;
  const LightComponent({super.key, required this.data});

  @override
  State<LightComponent> createState() => _LightComponentState();
}

class _LightComponentState extends State<LightComponent> {
  @override
  Widget build(BuildContext context) {
    return _buildDistanceTrackerExample();
  }

  SfRadialGauge _buildDistanceTrackerExample() {
    return SfRadialGauge(
      enableLoadingAnimation: true,
      axes: <RadialAxis>[
        RadialAxis(
            showLabels: false,
            showTicks: false,
            radiusFactor: 0.8,
            maximum: 1000,
            axisLineStyle: const AxisLineStyle(
                cornerStyle: CornerStyle.startCurve, thickness: 5),
            annotations: <GaugeAnnotation>[
              GaugeAnnotation(
                  angle: 90,
                  widget: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      Text(widget.data.toStringAsFixed(1),
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontStyle: FontStyle.italic,
                              fontSize: 20)),
                      Padding(
                        padding: EdgeInsets.fromLTRB(0, 2, 0, 0),
                        child: Text(
                          'lümen',
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontStyle: FontStyle.italic,
                              fontSize: 10),
                        ),
                      )
                    ],
                  )),
              GaugeAnnotation(
                angle: 124,
                positionFactor: 1.1,
                widget: Text('0', style: TextStyle(fontSize: 14)),
              ),
              GaugeAnnotation(
                angle: 54,
                positionFactor: 1.1,
                widget: Text('1000', style: TextStyle(fontSize: 14)),
              ),
              GaugeAnnotation(
                angle: 90,
                positionFactor: 1.3,
                widget: Text(
                  'Işık: ${widget.data.toStringAsFixed(1)} Lümen',
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 18,
                  ),
                ),
              ),
            ],
            pointers: <GaugePointer>[
              RangePointer(
                value: double.parse(widget.data.toString()),
                width: 18,
                pointerOffset: -6,
                cornerStyle: CornerStyle.bothCurve,
                color: Color.fromARGB(255, 69, 124, 243),
                gradient: SweepGradient(colors: <Color>[
                  Color.fromARGB(255, 118, 182, 255),
                  Color.fromARGB(255, 245, 242, 78)
                ], stops: <double>[
                  0.35,
                  0.65
                ]),
              ),
              MarkerPointer(
                value: double.parse(widget.data.toString()),
                color: Colors.white,
                markerType: MarkerType.circle,
              ),
            ]),
      ],
    );
  }
}

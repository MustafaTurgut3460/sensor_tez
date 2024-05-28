import 'dart:async';

import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_gauges/gauges.dart';
import 'package:tailwind_colors/tailwind_colors.dart';

class AirComponent extends StatefulWidget {
  final dynamic data;
  const AirComponent({super.key, required this.data});

  @override
  State<AirComponent> createState() => _AirComponentState();
}

class _AirComponentState extends State<AirComponent> {
  late Timer _timer;
  // int _value = 0;

  @override
  Widget build(BuildContext context) {
    return _buildWidgetPointerExample(context);
  }

  @override
  void initState() {
    super.initState();
    // _startTimer();
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  // void _startTimer() {
  //   if (mounted) {
  //     _timer = Timer.periodic(const Duration(milliseconds: 20), (Timer timer) {
  //       _incrementPointerValue();
  //     });
  //   }
  // }

  // void _incrementPointerValue() {
  //   setState(() {
  //     if (_value == int.parse(widget.data)) {
  //       _timer.cancel();
  //     } else {
  //       _value++;
  //     }
  //   });
  // }

  SfRadialGauge _buildWidgetPointerExample(BuildContext context) {
    return SfRadialGauge(
      axes: <RadialAxis>[
        RadialAxis(
          interval: 10,
          labelOffset: 0.2,
          tickOffset: 0.125,
          minorTicksPerInterval: 0,
          labelsPosition: ElementsPosition.outside,
          offsetUnit: GaugeSizeUnit.factor,
          showAxisLine: false,
          showLastLabel: true,
          radiusFactor: 0.8,
          maximum: 90,
          pointers: <GaugePointer>[
            WidgetPointer(
                offset: -5,
                value: widget.data,
                child: Container(
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(40),
                      boxShadow: <BoxShadow>[
                        BoxShadow(
                          color: Colors.grey,
                          blurRadius: 4.0,
                        ),
                      ],
                      border: Border.all(
                        color: Colors.white.withOpacity(0.1),
                      )),
                  height: 32,
                  width: 32,
                  child: Center(
                    child: Row(
                      children: <Widget>[
                        const Padding(padding: EdgeInsets.fromLTRB(2, 0, 0, 0)),
                        Container(
                            width: 10,
                            height: 15,
                            decoration: BoxDecoration(
                              image: DecorationImage(
                                image: ExactAssetImage(
                                    'assets/icons/temperature_indicator_light.png'),
                                fit: BoxFit.fill,
                              ),
                            )),
                        Center(
                          child: Text(
                            '${widget.data.toStringAsFixed(0)}',
                            style: TextStyle(
                              color: const Color.fromRGBO(126, 126, 126, 1),
                              fontWeight: FontWeight.bold,
                              fontSize: 12,
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                ))
          ],
          annotations: <GaugeAnnotation>[
              // GaugeAnnotation(
              //     angle: 90,
              //     positionFactor: 0.35,
              //     widget: Text('Temp.°C',
              //         style:
              //             TextStyle(color: Color(0xFFF8B195), fontSize: 16))),
              GaugeAnnotation(
                angle: 90,
                positionFactor: 1.2,
                widget: Text(
                  '${widget.data.toStringAsFixed(1)} C',
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 18,
                  ),
                ),
              )
            ],
          ranges: <GaugeRange>[
            GaugeRange(
              startValue: 0,
              endValue: 30,
              color: const Color.fromRGBO(74, 177, 70, 1),
            ),
            GaugeRange(
              startValue: 30,
              endValue: 60,
              color: const Color.fromRGBO(251, 190, 32, 1),
            ),
            GaugeRange(
              startValue: 60,
              endValue: 90,
              color: const Color.fromRGBO(237, 34, 35, 1),
            )
          ],
        )
      ],
    );
  }
}

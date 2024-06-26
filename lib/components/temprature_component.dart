import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_gauges/gauges.dart';
import 'package:tailwind_colors/tailwind_colors.dart';

class TempratureComponent extends StatefulWidget {
  final bool isCardView;
  final dynamic data;
  const TempratureComponent({super.key, required this.isCardView, required this.data});

  @override
  State<TempratureComponent> createState() => _TempratureComponentState();
}

class _TempratureComponentState extends State<TempratureComponent> {
  @override
  Widget build(BuildContext context) {
    return _buildTemperatureMonitorExample();
  }

  SfRadialGauge _buildTemperatureMonitorExample() {
    return SfRadialGauge(
      animationDuration: 2500,
      enableLoadingAnimation: true,
      axes: <RadialAxis>[
        RadialAxis(
            minimum: 0,
            maximum: 1200,
            interval: widget.isCardView ? 200 : 100,
            minorTicksPerInterval: 9,
            showAxisLine: false,
            radiusFactor: 0.9,
            labelOffset: 8,
            ranges: <GaugeRange>[
              GaugeRange(
                  startValue: 0,
                  endValue: 200,
                  startWidth: 0.265,
                  sizeUnit: GaugeSizeUnit.factor,
                  endWidth: 0.265,
                  color: const Color.fromRGBO(123, 199, 34, 0.75)),
              GaugeRange(
                  startValue: 200,
                  endValue: 800,
                  startWidth: 0.265,
                  sizeUnit: GaugeSizeUnit.factor,
                  endWidth: 0.265,
                  color: const Color.fromRGBO(238, 193, 34, 0.75)),
              GaugeRange(
                  startValue: 800,
                  endValue: 1200,
                  startWidth: 0.265,
                  sizeUnit: GaugeSizeUnit.factor,
                  endWidth: 0.265,
                  color: const Color.fromRGBO(238, 79, 34, 0.65)),
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
                  'Hava Kalitesi: ${widget.data.toString()} ppm',
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 16,
                  ),
                ),
              )
            ],
            pointers: <GaugePointer>[
              NeedlePointer(
                value: double.parse(widget.data.toString()),
                needleStartWidth: 1,
                needleEndWidth: 8,
                animationType: AnimationType.easeOutBack,
                enableAnimation: true,
                animationDuration: 1200,
                knobStyle: KnobStyle(
                    knobRadius: 0.09,
                    borderColor: Color(0xFFF8B195),
                    color: Colors.white,
                    borderWidth: 0.05),
                tailStyle:
                    TailStyle(color: Color(0xFFF8B195), width: 8, length: 0.2),
                needleColor: Color(0xFFF8B195),
              )
            ],
            axisLabelStyle: GaugeTextStyle(fontSize: 12),
            majorTickStyle: const MajorTickStyle(
                length: 0.25, lengthUnit: GaugeSizeUnit.factor),
            minorTickStyle: const MinorTickStyle(
                length: 0.13, lengthUnit: GaugeSizeUnit.factor, thickness: 1))
      ],
    );
  }
}

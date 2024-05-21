import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_gauges/gauges.dart';
import 'package:tailwind_colors/tailwind_colors.dart';

class NemComponent extends StatefulWidget {
  final dynamic data;
  const NemComponent({super.key, required this.data});

  @override
  State<NemComponent> createState() => _NemComponentState();
}

class _NemComponentState extends State<NemComponent> {
  @override
  Widget build(BuildContext context) {
    return _buildRangeThicknessExampleGauge();
  }

  SfRadialGauge _buildRangeThicknessExampleGauge() {
    return SfRadialGauge(
      axes: <RadialAxis>[
        RadialAxis(
          showAxisLine: false,
          ticksPosition: ElementsPosition.outside,
          labelsPosition: ElementsPosition.outside,
          radiusFactor: 0.9,
          canRotateLabels: true,
          showLastLabel: true,
          majorTickStyle: const MajorTickStyle(
            length: 0.1,
            lengthUnit: GaugeSizeUnit.factor,
          ),
          minorTickStyle: const MinorTickStyle(
            length: 0.04,
            lengthUnit: GaugeSizeUnit.factor,
          ),
          minorTicksPerInterval: 5,
          interval: 10,
          axisLabelStyle: const GaugeTextStyle(),
          useRangeColorForAxis: true,
          pointers: <GaugePointer>[
            NeedlePointer(
                enableAnimation: true,
                value: double.parse(widget.data.toStringAsFixed(2)),
                tailStyle: TailStyle(length: 0.2, width: 3),
                needleEndWidth: 3,
                needleLength: 0.6,
                knobStyle: KnobStyle())
          ],
          ranges: <GaugeRange>[
            GaugeRange(
                startValue: 40,
                endValue: 100,
                startWidth: 0.05,
                gradient: const SweepGradient(
                    colors: <Color>[Color(0xFF289AB1), Color(0xFF43E695)],
                    stops: <double>[0.25, 0.75]),
                color: const Color(0xFF289AB1),
                rangeOffset: 0.08,
                endWidth: 0.2,
                sizeUnit: GaugeSizeUnit.factor)
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
                'Nem: %${widget.data.toStringAsFixed(1)}',
                style: TextStyle(
                  fontWeight: FontWeight.w500,
                  fontSize: 18,
                ),
              ),
            )
          ],
        ),
      ],
    );
  }
}

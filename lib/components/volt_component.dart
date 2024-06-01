import 'dart:async';

import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_gauges/gauges.dart';
import 'package:tailwind_colors/tailwind_colors.dart';

class VoltComponent extends StatefulWidget {
  final dynamic data;
  const VoltComponent({super.key, required this.data});

  @override
  State<VoltComponent> createState() => _VoltComponentState();
}

class _VoltComponentState extends State<VoltComponent> {

  @override
  Widget build(BuildContext context) {
    return _buildRadialNonLinearLabel();
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  SfRadialGauge _buildRadialNonLinearLabel() {
    return SfRadialGauge(
      enableLoadingAnimation: true,
      key: null,
      animationDuration: 2500,
      axes: <RadialAxis>[
        RadialAxis(
          axisLineStyle: const AxisLineStyle(
            thicknessUnit: GaugeSizeUnit.factor, thickness: 0.15
          ),
          radiusFactor: 0.9,
          showTicks: false,
          showLastLabel: true,
          maximum: 3000,
          axisLabelStyle: const GaugeTextStyle(),
          onCreateAxisRenderer: handleCreateAxisRenderer,
          annotations: <GaugeAnnotation>[
            GaugeAnnotation(
              angle: 90,
              positionFactor: 1.2,
              widget: Text(
                'Güç: ${widget.data.toStringAsFixed(1)} mW',
                style: TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: 18,
                ),
              ),
            )
          ],
          pointers: <GaugePointer>[
            NeedlePointer(
              enableAnimation: true,
              gradient: const LinearGradient(colors: <Color>[
                Color.fromRGBO(203, 126, 223, 0),
                Color(0xFFCB7EDF)
              ], stops: <double>[
                0.25,
                0.75
              ], begin: Alignment.bottomCenter, end: Alignment.topCenter),
              animationType: AnimationType.easeOutBack,
              value: double.parse(widget.data.toString()),
              animationDuration: 1300,
              needleStartWidth: 4,
              needleEndWidth: 8,
              needleLength: 0.8,
              knobStyle: const KnobStyle(
                knobRadius: 0,
              )
            ),
            RangePointer(
              value: double.parse(widget.data.toString()),
              width: 0.15,
              sizeUnit: GaugeSizeUnit.factor,
              color: _pointerColor,
              animationDuration: 1300,
              animationType: AnimationType.easeOutBack,
              gradient: const SweepGradient(
                colors: <Color>[Color(0xFF9E40DC), Color(0xFFE63B86)],
                stops: <double>[0.25, 0.75]
              ),
              enableAnimation: true
            )
          ]
        ),
      ],
    );
  }

  GaugeAxisRenderer handleCreateAxisRenderer() {
    final _CustomAxisRenderer customAxisRenderer = _CustomAxisRenderer();
    return customAxisRenderer;
  }

  final Color _pointerColor = const Color(0xFF494CA2);
}

class _CustomAxisRenderer extends RadialAxisRenderer {
  _CustomAxisRenderer() : super();

  @override
  List<CircularAxisLabel> generateVisibleLabels() {
    final List<CircularAxisLabel> visibleLabels = <CircularAxisLabel>[];
    for (num i = 0; i <= 6; i++) {  // 7 label intervals for the range of 0 to 3000 with steps of 500
      final double labelValue = i * 500;
      final CircularAxisLabel label = CircularAxisLabel(
          axis.axisLabelStyle, labelValue.toInt().toString(), i, false);
      label.value = labelValue;
      visibleLabels.add(label);
    }

    return visibleLabels;
  }

  @override
  double valueToFactor(double value) {
    return value / 3000;  // Normalize the value over the range of 0 to 3000
  }
}

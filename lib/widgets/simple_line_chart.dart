import 'package:flutter/material.dart';

import '../models/sensor_reading.dart';

class SimpleLineChart extends StatelessWidget {
  final List<SensorReading> data;
  final bool isSpo2;

  const SimpleLineChart({
    Key? key,
    required this.data,
    this.isSpo2 = true,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      size: Size(double.infinity, 200),
      painter: _LineChartPainter(
          data, isSpo2, Theme.of(context).colorScheme.primary),
    );
  }
}

class _LineChartPainter extends CustomPainter {
  final List<SensorReading> data;
  final bool isSpo2;
  final Color lineColor;
  _LineChartPainter(this.data, this.isSpo2, this.lineColor);

  @override
  void paint(Canvas canvas, Size size) {
    if (data.isEmpty) return;
    final paint = Paint()
      ..color = lineColor
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2;

    final stepX = size.width / (data.length - 1);
    final maxY = isSpo2 ? 100.0 : 200.0;
    final scaleY = size.height / maxY;

    final path = Path();
    for (var i = 0; i < data.length; i++) {
      final value = isSpo2 ? data[i].spo2.toDouble() : data[i].bpm.toDouble();
      final x = stepX * i;
      final y = size.height - (value * scaleY);
      if (i == 0)
        path.moveTo(x, y);
      else
        path.lineTo(x, y);
    }

    // Basit X ekseni
    final axisPaint = Paint()
      ..color = Colors.grey
      ..strokeWidth = 1;
    canvas.drawLine(
        Offset(0, size.height), Offset(size.width, size.height), axisPaint);

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant _LineChartPainter old) => old.data != data;
}

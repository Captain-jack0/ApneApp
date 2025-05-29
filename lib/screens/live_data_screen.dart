import 'package:flutter/material.dart';

import '../models/sensor_reading.dart';
import '../services/websocket_services.dart';
import '../widgets/simple_line_chart.dart';

class LiveDataScreen extends StatefulWidget {
  const LiveDataScreen({Key? key}) : super(key: key);

  @override
  _LiveDataScreenState createState() => _LiveDataScreenState();
}

class _LiveDataScreenState extends State<LiveDataScreen> {
  final List<SensorReading> readings = [];
  late final WebSocketService wsService;

  @override
  void initState() {
    super.initState();
    wsService = WebSocketService(onData: (reading) {
      setState(() {
        readings.insert(0, reading);
        if (readings.length > 50) readings.removeLast();
      });
    });
  }

  @override
  void dispose() {
    wsService.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // Son 20 okumayı al ve ters çevir
    final recent = readings.take(20).toList().reversed.toList();
    // En son okuma
    final latest = readings.isNotEmpty ? readings.first : null;
    // Zamanı HH:MM:SS formatında al
    final timestamp = latest != null
        ? latest.time.toLocal().toIso8601String().substring(11, 19)
        : '';

    return Scaffold(
      appBar: AppBar(title: const Text('Canlı Veriler')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (latest != null) ...[
              Text(
                'Anlık: SPO₂ ${latest.spo2}%   BPM ${latest.bpm}   ($timestamp)',
                style: Theme.of(context).textTheme.titleMedium,
              ),
              const SizedBox(height: 16),
            ],
            const Text(
              'SPO₂ Zaman Serisi',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            SimpleLineChart(data: recent, isSpo2: true),
            const SizedBox(height: 24),
            const Text(
              'BPM Zaman Serisi',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            SimpleLineChart(data: recent, isSpo2: false),
          ],
        ),
      ),
    );
  }
}

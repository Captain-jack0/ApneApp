import 'dart:async';

import 'package:flutter/material.dart';

import '../models/sensor_data.dart';
import '../services/sensor_api.dart';

class HistoryLiveScreen extends StatefulWidget {
  const HistoryLiveScreen({Key? key}) : super(key: key);

  @override
  _HistoryLiveScreenState createState() => _HistoryLiveScreenState();
}

class _HistoryLiveScreenState extends State<HistoryLiveScreen> {
  final SensorApi _api = SensorApi();
  SensorData? _currentData;
  bool _isLoading = true;
  String? _error;
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    _loadLatestData();
    _timer =
        Timer.periodic(const Duration(seconds: 1), (_) => _loadLatestData());
  }

  Future<void> _loadLatestData() async {
    if (mounted) setState(() => _isLoading = true);
    try {
      final data = await _api.fetchLatest();
      debugPrint('Veri alındı: spo2=${data.spo2}, bpm=${data.bpm}');
      if (mounted) {
        setState(() {
          _currentData = data;
          _error = null;
          _isLoading = false;
        });
      }
    } catch (e) {
      debugPrint('Veri çekme hatası: $e');
      if (mounted) {
        setState(() {
          _error = e.toString();
          _isLoading = false;
        });
      }
    }
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Canlı Veri Akışı')),
      body: Center(
        child: _isLoading
            ? const CircularProgressIndicator()
            : _error != null
                ? Padding(
                    padding: const EdgeInsets.all(16),
                    child: Text(
                      'Hata:\n$_error',
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                          fontSize: 18, color: Colors.redAccent),
                    ),
                  )
                : _currentData != null
                    ? Card(
                        margin: const EdgeInsets.all(24),
                        elevation: 4,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                              vertical: 32, horizontal: 16),
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Text(
                                '${_currentData!.spo2}%',
                                style: const TextStyle(
                                    fontSize: 48, fontWeight: FontWeight.bold),
                              ),
                              const SizedBox(height: 8),
                              Text(
                                'BPM: ${_currentData!.bpm}',
                                style: const TextStyle(fontSize: 24),
                              ),
                              const SizedBox(height: 16),
                              Text(
                                _currentData!.timestamp.toLocal().toString(),
                                style: const TextStyle(
                                    fontSize: 14, color: Colors.grey),
                              ),
                            ],
                          ),
                        ),
                      )
                    : const Text('Veri bulunamadı'),
      ),
    );
  }
}

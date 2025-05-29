class SensorReading {
  final DateTime time;
  final int spo2;
  final int bpm;
  SensorReading({required this.time, required this.spo2, required this.bpm});
  factory SensorReading.fromJson(Map<String, dynamic> json) {
    return SensorReading(
      time: DateTime.parse(json['timestamp'] as String),
      spo2: json['SPO2'] as int,
      bpm: json['BPM'] as int,
    );
  }
}

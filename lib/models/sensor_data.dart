class SensorData {
  final DateTime timestamp;
  final int spo2;
  final int bpm;

  SensorData({
    required this.timestamp,
    required this.spo2,
    required this.bpm,
  });

  /// JSON verisinden SensorData objesi oluşturur
  factory SensorData.fromJson(Map<String, dynamic> json) {
    // Eğer payload içinde geliyorsa orayı, yoksa JSON’un kendisini kullan
    final data = json['payload'] as Map<String, dynamic>? ?? json;
    final ts = data['timestamp'] as String?;
    if (ts == null) {
      throw Exception('JSON içinde timestamp bulunamadı: \$json');
    }
    // Eğer tarih stringi boşluk içeriyorsa ISO formatına çevir
    final normalized = ts.contains(' ') ? ts.replaceFirst(' ', 'T') : ts;
    return SensorData(
      timestamp: DateTime.parse(normalized),
      spo2: data['SPO2'] as int,
      bpm: data['BPM'] as int,
    );
  }
}

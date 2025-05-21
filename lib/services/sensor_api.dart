import 'dart:convert';

import 'package:http/http.dart' as http;

import '../models/sensor_data.dart';

class SensorApi {
  // Android emülatör için 10.0.2.2, gerçek cihazda LAN IP kullanın
  static const _baseUrl = 'http://192.168.1.59:3000';

  /// Geçmiş verileri çeker (varsayılan en son 1 kayıt)
  Future<List<SensorData>> fetchHistory({int limit = 1}) async {
    final uri = Uri.parse('$_baseUrl/history?limit=$limit');
    final res = await http.get(uri);
    if (res.statusCode != 200) {
      throw Exception('API isteği başarısız: \${res.statusCode}');
    }
    final List<dynamic> body = jsonDecode(res.body) as List<dynamic>;
    return body
        .map((e) => SensorData.fromJson(e as Map<String, dynamic>))
        .toList();
  }

  /// Sadece en son kaydı çeker
  Future<SensorData> fetchLatest() async {
    final list = await fetchHistory(limit: 1);
    if (list.isEmpty) {
      throw Exception('Veri bulunamadı');
    }
    return list.first;
  }
}

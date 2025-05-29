import 'dart:convert';

import 'package:web_socket_channel/io.dart';

import '../models/sensor_reading.dart';

class WebSocketService {
  late final IOWebSocketChannel _channel;
  final void Function(SensorReading) onData;

  WebSocketService({required this.onData}) {
    final host = '139.59.128.31';
    final url = Uri.parse('ws://$host:3000/ws');
    print('⏳ WebSocket’e bağlanılıyor: $url');

    _channel = IOWebSocketChannel.connect(url);

    _channel.stream.listen(
      (msg) {
        try {
          print('Mesaj alındı: $msg');
          final jsonMap = jsonDecode(msg as String) as Map<String, dynamic>;
          final reading = SensorReading.fromJson(jsonMap);
          onData(reading); // <<< burayı ekledik
        } catch (e, st) {
          print(' JSON parse hatası: $e\n$st');
        }
      },
      onError: (err) => print(' WebSocket error: $err'),
      onDone: () => print(' WebSocket bağlantısı koptu'),
      cancelOnError: false,
    );
  }

  void dispose() {
    print(' WebSocket kapatılıyor');
    _channel.sink.close();
  }
}

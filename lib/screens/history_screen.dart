import 'package:flutter/material.dart';

import 'detail_screen.dart';

class HistoryScreen extends StatelessWidget {
  const HistoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final List<Map<String, String>> historyData = [
      {
        "date": "2024-04-25",
        "status": "Sağlıklı",
        "details": "Nabız: 72 bpm, Oksijen: %98"
      },
      {
        "date": "2024-04-24",
        "status": "Apne Tespit Edildi",
        "details": "Düşük nabız ve düzensiz ritim."
      },
    ];

    return Scaffold(
      appBar: AppBar(
        title: const Text("Analiz Geçmişi"),
        backgroundColor: Colors.blue[700],
        centerTitle: true,
      ),
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFFE3F2FD), Colors.white],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        padding: const EdgeInsets.all(16.0),
        child: ListView.builder(
          itemCount: historyData.length,
          itemBuilder: (context, index) {
            final item = historyData[index];
            return Card(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20)),
              elevation: 4,
              margin: const EdgeInsets.only(bottom: 16),
              child: ListTile(
                leading: Icon(
                  item['status'] == "Sağlıklı"
                      ? Icons.check_circle
                      : Icons.warning,
                  color:
                      item['status'] == "Sağlıklı" ? Colors.green : Colors.red,
                ),
                title: Text(item['date'] ?? ""),
                subtitle: Text(item['status'] ?? ""),
                trailing: const Icon(Icons.arrow_forward_ios),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => DetailScreen(
                        title: "${item['status']} (${item['date']})",
                        description: item['details'] ?? "",
                      ),
                    ),
                  );
                },
              ),
            );
          },
        ),
      ),
    );
  }
}

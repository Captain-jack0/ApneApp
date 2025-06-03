import 'package:flutter/material.dart';
import 'detail_screen.dart';

class HistoryScreen extends StatelessWidget {
  final String profileName;

  const HistoryScreen({super.key, required this.profileName});

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
        "details": "Düşük SPO2 ve düzensiz ritim."
      },
    ];

    return Scaffold(
      body: Stack(
        children: [
          // 🌌 Gradient arka plan
          Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [Color(0xFF0D47A1), Color(0xFF1976D2)],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
              ),
            ),
          ),
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // 🔙 Geri tuşu + başlık
                  Row(
                    children: [
                      IconButton(
                        icon: const Icon(Icons.arrow_back_ios,
                            color: Colors.white),
                        onPressed: () => Navigator.of(context).pop(),
                      ),
                      const SizedBox(width: 8),
                      Text(
                        "$profileName  Analiz Geçmişi",
                        style: const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),

                  Expanded(
                    child: ListView.builder(
                      itemCount: historyData.length,
                      itemBuilder: (context, index) {
                        final item = historyData[index];
                        final isHealthy = item['status'] == "Sağlıklı";

                        return Card(
                          color: Colors.white.withOpacity(0.1),
                          shadowColor: Colors.black54,
                          elevation: 5,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20),
                            side: BorderSide(
                              color: isHealthy
                                  ? Colors.greenAccent
                                  : Colors.redAccent,
                              width: 1.2,
                            ),
                          ),
                          margin: const EdgeInsets.only(bottom: 16),
                          child: ListTile(
                            contentPadding: const EdgeInsets.symmetric(
                                horizontal: 16, vertical: 12),
                            leading: Icon(
                              isHealthy
                                  ? Icons.check_circle_rounded
                                  : Icons.warning_amber_rounded,
                              size: 32,
                              color: isHealthy ? Colors.green : Colors.red,
                            ),
                            title: Text(
                              item['date'] ?? "",
                              style: const TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                            subtitle: Text(
                              item['status'] ?? "",
                              style: TextStyle(
                                fontSize: 16,
                                color: isHealthy
                                    ? Colors.greenAccent
                                    : Colors.redAccent,
                              ),
                            ),
                            trailing: const Icon(
                              Icons.arrow_forward_ios,
                              color: Colors.white70,
                              size: 18,
                            ),
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (_) => DetailScreen(
                                    title:
                                        "${item['status']} (${item['date']})",
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
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

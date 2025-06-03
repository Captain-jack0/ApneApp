import 'package:flutter/material.dart';
import 'detail_screen.dart';
import 'start_analysis_screen.dart'; // ✅ Yeniden analiz için gerekli

class ResultScreen extends StatelessWidget {
  final String status; // "positive" veya "negative"
  final String message;

  const ResultScreen({
    super.key,
    required this.status,
    required this.message,
  });

  @override
  Widget build(BuildContext context) {
    final bool isHealthy = status.toLowerCase() == "negative";

    return Scaffold(
      body: Stack(
        children: [
          // 🌌 Gece temalı gradient arka plan
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
              padding: const EdgeInsets.all(24.0),
              child: Column(
                children: [
                  // 🔙 Geri tuşu
                  Align(
                    alignment: Alignment.topLeft,
                    child: IconButton(
                      icon:
                          const Icon(Icons.arrow_back_ios, color: Colors.white),
                      onPressed: () => Navigator.pop(context),
                    ),
                  ),

                  const SizedBox(height: 40),

                  // 🧠 Duruma göre ikon
                  Icon(
                    isHealthy
                        ? Icons.check_circle_rounded
                        : Icons.warning_amber_rounded,
                    size: 80,
                    color: isHealthy ? Colors.greenAccent : Colors.redAccent,
                  ),

                  const SizedBox(height: 30),

                  // Başlık
                  Text(
                    isHealthy ? "Sağlıklı" : "Apne Riski",
                    style: TextStyle(
                      fontSize: 26,
                      fontWeight: FontWeight.bold,
                      color: isHealthy ? Colors.greenAccent : Colors.redAccent,
                    ),
                  ),

                  const SizedBox(height: 20),

                  // Açıklama
                  Text(
                    message,
                    style: const TextStyle(
                      fontSize: 18,
                      color: Colors.white70,
                    ),
                    textAlign: TextAlign.center,
                  ),

                  const Spacer(),

                  // 🔁 Yeniden Analiz ve 📄 Detay Butonları
                  Row(
                    children: [
                      // 🔁 Yeniden Analiz
                      Expanded(
                        child: ElevatedButton.icon(
                          onPressed: () {
                            Navigator.of(context).pushReplacement(
                              MaterialPageRoute(
                                builder: (_) => const StartAnalysisScreen(),
                              ),
                            );
                          },
                          icon: const Icon(Icons.replay),
                          label: const Text("Yeniden Analiz",
                              style: TextStyle(fontSize: 16)),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.white24,
                            foregroundColor: Colors.white,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(30),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(width: 12),

                      // 📄 Detayları Gör
                      Expanded(
                        child: ElevatedButton.icon(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (_) => DetailScreen(
                                  title: isHealthy
                                      ? "Sağlıklı Sonuç"
                                      : "Apne Detayı",
                                  description: message,
                                ),
                              ),
                            );
                          },
                          icon: const Icon(Icons.info_outline),
                          label: const Text("Detayları Gör",
                              style: TextStyle(fontSize: 16)),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.white,
                            foregroundColor: Colors.blueAccent,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(30),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 20),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

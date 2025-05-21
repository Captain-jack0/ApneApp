import 'package:flutter/material.dart';

import 'detail_screen.dart';

class ResultScreen extends StatelessWidget {
  final String status;
  final String message;

  const ResultScreen({super.key, required this.status, required this.message});

  @override
  Widget build(BuildContext context) {
    final bool isPositive = status == "positive";

    return Scaffold(
      appBar: AppBar(
        title: const Text("Analiz Sonucu"),
        centerTitle: true,
        backgroundColor: Colors.blue[700],
      ),
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFFE3F2FD), Colors.white],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(24.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  isPositive ? Icons.warning_amber_rounded : Icons.check_circle,
                  size: 100,
                  color: isPositive ? Colors.red : Colors.green,
                ),
                const SizedBox(height: 20),
                Text(
                  isPositive ? "Hastalık Tespit Edildi" : "Sağlıklı",
                  style: TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                    color: isPositive ? Colors.red : Colors.green,
                  ),
                ),
                const SizedBox(height: 20),
                Text(
                  message,
                  textAlign: TextAlign.center,
                  style: const TextStyle(fontSize: 18, color: Colors.black87),
                ),
                const SizedBox(height: 40),
                ElevatedButton(
                  onPressed: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => const DetailScreen(
                          title: "Analiz Detayı",
                          description:
                              "Nabız: 72 bpm\nOksijen: %98\nSinyal: Temiz",
                        ),
                      ),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blue,
                    padding: const EdgeInsets.symmetric(
                        horizontal: 40, vertical: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                  ),
                  child: const Text("Detayları Gör",
                      style: TextStyle(fontSize: 18, color: Colors.white)),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

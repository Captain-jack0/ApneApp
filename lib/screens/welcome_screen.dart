import 'package:flutter/material.dart';
import 'start_analysis_screen.dart';
import 'history_screen.dart';
import 'live_data_screen.dart';
import 'profile_screen.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // 🌌 Arka plan gradient
          Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [Color(0xFF0D47A1), Color(0xFF1976D2)],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
              ),
            ),
          ),

          // 🌙 Ay ve yıldız süsleme
          Positioned(
            top: 20,
            left: 20,
            child: Row(
              children: const [
                Icon(Icons.nightlight_round, color: Colors.white70, size: 30),
                SizedBox(width: 8),
                Icon(Icons.star, color: Colors.white54, size: 18),
                Icon(Icons.star, color: Colors.white38, size: 14),
              ],
            ),
          ),

          // ☁️ Bulut
          Positioned(
            top: 50,
            right: 30,
            child: Opacity(
              opacity: 0.2,
              child: Icon(Icons.cloud, size: 60, color: Colors.white),
            ),
          ),

          // 📱 Ana içerik
          SafeArea(
            child: Center(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24.0),
                child: Column(
                  children: [
                    const Spacer(flex: 2),

                    const Icon(
                      Icons.favorite_rounded,
                      size: 80,
                      color: Colors.redAccent,
                    ),
                    const SizedBox(height: 20),

                    const Text(
                      "ApneSense",
                      style: TextStyle(
                        fontSize: 40,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                        letterSpacing: 1.2,
                      ),
                    ),
                    const SizedBox(height: 10),

                    const Text(
                      "Uyurken verilerinizi analiz edin ve apne riskini kontrol altında tutun.",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 18,
                        color: Colors.white70,
                      ),
                    ),

                    const Spacer(flex: 3),

                    // 🚀 Analize Başla
                    _buildButton(
                      label: "Analize Başla",
                      color: Colors.greenAccent,
                      onTap: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                              builder: (_) => const StartAnalysisScreen()),
                        );
                      },
                    ),

                    const SizedBox(height: 16),

                    // 📂 Analiz Geçmişi
                    _buildButton(
                      label: "Analiz Geçmişi",
                      color: const Color(0xFF26A69A),
                      onTap: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) =>
                                const HistoryScreen(profileName: "Emre"),
                          ),
                        );
                      },
                    ),

                    const SizedBox(height: 16),

                    // 🧠 Canlı Analiz
                    _buildButton(
                      label: "Canlı Analiz",
                      color: const Color(0xFF26A69A),
                      onTap: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(builder: (_) => LiveDataScreen()),
                        );
                      },
                    ),

                    const SizedBox(height: 16),

                    // 👤 Profil
                    _buildButton(
                      label: "Profil",
                      color: const Color(0xFF7E57C2),
                      onTap: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                              builder: (_) => const ProfileScreen()),
                        );
                      },
                    ),

                    const Spacer(flex: 2),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildButton({
    required String label,
    required Color color,
    required VoidCallback onTap,
  }) {
    return SizedBox(
      width: double.infinity,
      height: 55,
      child: ElevatedButton(
        onPressed: onTap,
        style: ElevatedButton.styleFrom(
          backgroundColor: color,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30),
          ),
          elevation: 5,
        ),
        child: Text(
          label,
          style: const TextStyle(fontSize: 18, color: Colors.black87),
        ),
      ),
    );
  }
}

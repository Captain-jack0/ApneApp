import 'package:flutter/material.dart';
import 'package:health_app/screens/live_data_screen.dart';

import 'history_screen.dart';
import 'profile_screen.dart';
import 'result_screen.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFFE3F2FD), Color(0xFFFFFFFF)],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: SafeArea(
          child: Center(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24.0),
              child: Column(
                children: [
                  const Spacer(flex: 2),

                  // 🫀 Sağlık İkonu
                  const Icon(
                    Icons.favorite_rounded,
                    size: 80,
                    color: Colors.redAccent,
                  ),

                  const SizedBox(height: 20),

                  // Başlık
                  const Text(
                    "ApneEkip",
                    style: TextStyle(
                      fontSize: 40,
                      fontWeight: FontWeight.bold,
                      color: Colors.blueAccent,
                      letterSpacing: 1.2,
                    ),
                  ),

                  const SizedBox(height: 10),

                  const Text(
                    "Uyurken verilerinizi analiz edin ve apne riskini kontrol altında tutun.",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 18,
                      color: Colors.black87,
                    ),
                  ),

                  const Spacer(flex: 3),
                  //ANALİZE BAŞLAMA
                  _buildButton(
                    label: "Analize Başla",
                    color: const Color(0xFF0277BD),
                    onTap: () {
                      Navigator.of(context).push(_createRouteToResult());
                    },
                  ),

                  const SizedBox(height: 16),

                  // ANALİZ GEÇMİŞİ
                  _buildButton(
                    label: "Analiz Geçmişi",
                    color: const Color(0xFF26A69A),
                    onTap: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                            builder: (context) => const HistoryScreen()),
                      );
                    },
                  ),

                  const SizedBox(height: 16),

                  // Canlı Analiz
                  _buildButton(
                    label: "Canlı Analiz",
                    color: const Color(0xFF26A69A),
                    onTap: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                            builder: (context) => LiveDataScreen()),
                      );
                    },
                  ),

                  const SizedBox(height: 16),

                  // PROFİL
                  _buildButton(
                    label: "Profil",
                    color: const Color(0xFF7E57C2),
                    onTap: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                            builder: (context) => const ProfileScreen()),
                      );
                    },
                  ),

                  const Spacer(flex: 2),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildButton(
      {required String label,
      required Color color,
      required VoidCallback onTap}) {
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
          style: const TextStyle(fontSize: 18, color: Colors.white),
        ),
      ),
    );
  }

  Route _createRouteToResult() {
    return PageRouteBuilder(
      pageBuilder: (context, animation, secondaryAnimation) =>
          const ResultScreen(
        status: "negative",
        message: "Herhangi bir apneye rastlanmadı. Sağlıklısınız.",
      ),
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        return FadeTransition(
          opacity: animation,
          child: child,
        );
      },
    );
  }
}

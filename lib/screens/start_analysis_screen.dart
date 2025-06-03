import 'package:flutter/material.dart';
import 'result_screen.dart';

class StartAnalysisScreen extends StatefulWidget {
  const StartAnalysisScreen({super.key});

  @override
  State<StartAnalysisScreen> createState() => _StartAnalysisScreenState();
}

class _StartAnalysisScreenState extends State<StartAnalysisScreen> {
  bool isLoading = false;

  void _startAnalysis() async {
    setState(() => isLoading = true);

    // 🔄 Simüle edilmiş analiz süreci
    await Future.delayed(const Duration(seconds: 3));

    // 🧠 Model sonucu: sahte değer (sen burada gerçek analiz sonucu bağlarsın)
    const String resultStatus = "negative";
    const String resultMessage =
        "Herhangi bir apneye rastlanmadı. Sağlıklısınız.";

    // ⏩ Sonuç ekranına yönlendir
    if (!mounted) return;
    Navigator.of(context).pushReplacement(
      MaterialPageRoute(
        builder: (_) => const ResultScreen(
          status: resultStatus,
          message: resultMessage,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // 🌌 Gece temalı arka plan
          Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [Color(0xFF0D47A1), Color(0xFF1976D2)],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
              ),
            ),
          ),

          // 📄 İçerik
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

                  const Icon(Icons.monitor_heart,
                      size: 80, color: Colors.white),
                  const SizedBox(height: 30),

                  const Text(
                    "Analize Başla",
                    style: TextStyle(
                      fontSize: 26,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                      letterSpacing: 1.2,
                    ),
                    textAlign: TextAlign.center,
                  ),

                  const SizedBox(height: 16),

                  const Text(
                    "Uyku sırasında alınan veriler analiz edilecek.\nBaşlamak için butona tıklayın.",
                    style: TextStyle(fontSize: 16, color: Colors.white70),
                    textAlign: TextAlign.center,
                  ),

                  const Spacer(),

                  isLoading
                      ? const CircularProgressIndicator(color: Colors.white)
                      : SizedBox(
                          width: double.infinity,
                          height: 55,
                          child: ElevatedButton.icon(
                            onPressed: _startAnalysis,
                            icon: const Icon(Icons.play_arrow),
                            label: const Text("Analizi Başlat",
                                style: TextStyle(fontSize: 18)),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.greenAccent,
                              foregroundColor: Colors.black87,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(30),
                              ),
                            ),
                          ),
                        ),

                  const SizedBox(height: 40),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

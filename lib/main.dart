import 'package:flutter/material.dart';

import 'screens/splash_screen.dart';

void main() {
  runApp(const HealthApp());
}

class HealthApp extends StatelessWidget {
  const HealthApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'ApneEkipApp',
      theme: ThemeData(
        //primarySwatch: Colors.blue,
        primarySwatch: Colors.red,
        useMaterial3: true,
      ),
      home: const SplashScreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}

import 'package:flutter/material.dart';
import 'history_screen.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  List<Map<String, String>> profiles = [
    {"name": "Emre Kayhan", "age": "23", "gender": "Erkek"},
    {"name": "Sefa Bayram", "age": "25", "gender": "Erkek"},
  ];

  String? activeProfile;

  void _addProfile() {
    String name = "";
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text("Yeni Profil Ekle"),
        content: TextField(
          decoration: const InputDecoration(labelText: "İsim"),
          onChanged: (val) => name = val,
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text("İptal"),
          ),
          TextButton(
            onPressed: () {
              if (name.trim().isNotEmpty) {
                setState(() {
                  profiles.add(
                      {"name": name.trim(), "age": "30", "gender": "Erkek"});
                });
              }
              Navigator.pop(context);
            },
            child: const Text("Ekle"),
          ),
        ],
      ),
    );
  }

  void _openHistoryForProfile(String profileName) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (_) => HistoryScreen(profileName: profileName),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Profiller"),
        backgroundColor: Colors.blue[700],
      ),
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFF0D47A1), Color(0xFF1976D2)],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            // Profil Listesi
            Expanded(
              child: ListView.builder(
                itemCount: profiles.length,
                itemBuilder: (context, index) {
                  final profile = profiles[index];
                  final isActive = activeProfile == profile['name'];

                  return Card(
                    color: isActive
                        ? Colors.greenAccent.withOpacity(0.3)
                        : Colors.white.withOpacity(0.1),
                    child: ListTile(
                      title: Text(
                        profile['name'] ?? "",
                        style: const TextStyle(color: Colors.white),
                      ),
                      subtitle: Text(
                        "Yaş: ${profile['age']}, Cinsiyet: ${profile['gender']}",
                        style: const TextStyle(color: Colors.white70),
                      ),
                      trailing: isActive
                          ? const Icon(Icons.check_circle,
                              color: Colors.greenAccent)
                          : null,
                      onTap: () {
                        setState(() {
                          activeProfile = profile['name'];
                        });
                        _openHistoryForProfile(profile['name']!);
                      },
                    ),
                  );
                },
              ),
            ),

            const SizedBox(height: 16),

            // Yeni Profil Ekle Butonu
            SizedBox(
              width: double.infinity,
              height: 50,
              child: ElevatedButton.icon(
                onPressed: _addProfile,
                icon: const Icon(Icons.person_add),
                label: const Text("Yeni Profil Ekle"),
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
      ),
    );
  }
}

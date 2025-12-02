// lib/screens/home_screen.dart
import 'package:flutter/material.dart';
import 'package:lab2flutter/components/wifi_list_tile.dart';
// Додаємо імпорт для ProfileScreen
import 'package:lab2flutter/screens/profile_screen.dart';

class HomeScreen extends StatelessWidget {
  static const routeName = '/home';
  const HomeScreen({super.key});

  final List<Map<String, dynamic>> _wifiNetworks = const [
    {'ssid': 'EOM', 'strength': 0.9},
    {'ssid': 'EOM-Staff', 'strength': 0.75},
    {'ssid': '512kab', 'strength': 0.4},
    {'ssid': 'nulp', 'strength': 0.2},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Wi-Fi Мережі (5-й поверх)'),
        actions: [
          IconButton(
            icon: const Icon(Icons.person), // Іконка профілю
            onPressed: () {
              // Навігація на екран профілю
              Navigator.pushNamed(context, ProfileScreen.routeName);
            },
          ),
        ],
      ),
      body: ListView.builder(
        itemCount: _wifiNetworks.length,
        itemBuilder: (context, index) {
          final network = _wifiNetworks[index];
          return WifiListTile(
            ssid: network['ssid'] as String,
            strength: network['strength'] as double,
          );
        },
      ),
    );
  }
}

// lib/components/wifi_list_tile.dart
import 'package:flutter/material.dart';

class WifiListTile extends StatelessWidget {
  const WifiListTile({
    required this.ssid,
    required this.strength,
    super.key,
  });

  final String ssid;
  final double strength;

  IconData getWifiIcon(double strength) {
    if (strength > 0.75) return Icons.wifi;
    if (strength > 0.4) return Icons.wifi_2_bar;
    return Icons.wifi_1_bar;
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
      child: ListTile(
        leading: Icon(
          getWifiIcon(strength),
          // Колір тепер береться з теми
        ),
        title: Text(
          ssid,
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
        subtitle: Text(
          '${(strength * 100).toInt()}% сигнал',
          style: TextStyle(color: Colors.grey[400]),
        ),
        trailing: Icon(
          Icons.arrow_forward_ios_rounded,
          size: 16,
          color: Colors.grey[400],
        ),
        onTap: () {
          // Логіка підключення
        },
      ),
    );
  }
}

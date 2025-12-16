import 'package:flutter/material.dart';

class WifiListTile extends StatelessWidget {
  const WifiListTile({
    required this.ssid,
    required this.strength,
    required this.isSecured,
    super.key,
  });

  final String ssid;
  final double strength;
  final bool isSecured;

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
        ),
        title: Text(
          ssid,
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
        subtitle: Text(
          '${(strength * 100).toInt()}% сигнал',
          style: TextStyle(color: Colors.grey[400]),
        ),
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            if (isSecured)
              Icon(
                Icons.lock_outline,
                size: 16,
                color: Colors.grey[400],
              ),
            const SizedBox(width: 8),
            Icon(
              Icons.arrow_forward_ios_rounded,
              size: 16,
              color: Colors.grey[400],
            ),
          ],
        ),
      ),
    );
  }
}

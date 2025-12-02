import 'dart:convert';

class WifiNetwork {
  final String id;
  final String ssid;
  final double strength;
  final bool isSecured;

  WifiNetwork({
    required this.id,
    required this.ssid,
    required this.strength,
    required this.isSecured,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'ssid': ssid,
      'strength': strength,
      'isSecured': isSecured,
    };
  }

  factory WifiNetwork.fromMap(Map<String, dynamic> map) {
    return WifiNetwork(
      id: (map['id'] ?? '') as String,
      ssid: (map['ssid'] ?? '') as String,
      strength: (map['strength']?.toDouble() ?? 0.0) as double,
      isSecured: (map['isSecured'] ?? false) as bool,
    );
  }

  String toJson() => json.encode(toMap());

  factory WifiNetwork.fromJson(String source) =>
      WifiNetwork.fromMap(json.decode(source) as Map<String, dynamic>);
}

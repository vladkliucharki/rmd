import 'package:lab2flutter/domain/models/wifi_network.dart';
import 'package:lab2flutter/domain/repositories/wifi_repository_interface.dart';
import 'package:shared_preferences/shared_preferences.dart';

class WifiRepositoryImpl implements IWifiRepository {
  static const String _wifiKey = 'wifi_networks';

  @override
  Future<List<WifiNetwork>> getNetworks() async {
    final prefs = await SharedPreferences.getInstance();
    final List<String>? listString = prefs.getStringList(_wifiKey);
    
    if (listString == null || listString.isEmpty) {
      return [
        WifiNetwork(id: '1', ssid: 'IT-Academy-5F', 
        strength: 0.9, isSecured: true),
        WifiNetwork(id: '2', ssid: 'Guest_Free',
         strength: 0.5, isSecured: false),
      ];
    }

    return listString.map(WifiNetwork.fromJson).toList();
  }

  Future<void> _saveList(List<WifiNetwork> networks) async {
    final prefs = await SharedPreferences.getInstance();
    final listString = networks.map((n) => n.toJson()).toList();
    await prefs.setStringList(_wifiKey, listString);
  }

  @override
  Future<void> addNetwork(WifiNetwork network) async {
    final networks = await getNetworks();
    networks.add(network);
    await _saveList(networks);
  }

  @override
  Future<void> deleteNetwork(String id) async {
    final networks = await getNetworks();
    networks.removeWhere((item) => item.id == id);
    await _saveList(networks);
  }
  
  @override
  Future<void> updateNetwork(WifiNetwork network) async {
    final networks = await getNetworks();
    final index = networks.indexWhere((item) => item.id == network.id);
    if (index != -1) {
      networks[index] = network;
      await _saveList(networks);
    }
  }
}

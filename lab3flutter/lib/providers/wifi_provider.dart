import 'package:flutter/material.dart';
import 'package:lab2flutter/data/repositories/wifi_repository_impl.dart';
import 'package:lab2flutter/domain/models/wifi_network.dart';

class WifiProvider extends ChangeNotifier {
  final _repo = WifiRepositoryImpl();
  
  List<WifiNetwork> _networks = [];
  List<WifiNetwork> get networks => _networks;

  Future<void> loadNetworks() async {
    _networks = await _repo.getNetworks();
    notifyListeners(); // Кажемо UI перемалюватися
  }

  Future<void> addNetwork(String ssid) async {
    final newNet = WifiNetwork(
      id: DateTime.now().toString(),
      ssid: ssid,
      strength: 0.9,
      isSecured: true,
    );
    await _repo.addNetwork(newNet);
    await loadNetworks(); // Перезавантажуємо список
  }

  Future<void> deleteNetwork(String id) async {
    await _repo.deleteNetwork(id);
    await loadNetworks();
  }
}

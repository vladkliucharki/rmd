import 'package:lab2flutter/domain/models/wifi_network.dart';

abstract class IWifiRepository {
  Future<List<WifiNetwork>> getNetworks();
  Future<void> addNetwork(WifiNetwork network);
  Future<void> deleteNetwork(String id);
  Future<void> updateNetwork(WifiNetwork network);
}

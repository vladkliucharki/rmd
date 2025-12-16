import 'package:flutter/material.dart';
import 'package:lab2flutter/components/wifi_list_tile.dart';
import 'package:lab2flutter/providers/wifi_provider.dart';
import 'package:lab2flutter/screens/profile_screen.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatelessWidget {
  static const routeName = '/home';
  const HomeScreen({super.key});

  void _showAddDialog(BuildContext context) {
    final controller = TextEditingController();
    showDialog<void>( 
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('Нова мережа'),
        content: TextField(
          controller: controller,
          decoration: const InputDecoration(hintText: 'SSID'),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx),
            child: const Text('Відміна'),
          ),
          ElevatedButton(
            onPressed: () {
              if (controller.text.isNotEmpty) {
                context.read<WifiProvider>().addNetwork(controller.text);
                Navigator.pop(ctx);
              }
            },
            child: const Text('Додати'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Wi-Fi Мережі'),
        actions: [
          IconButton(
            icon: const Icon(Icons.person),
            onPressed: () {
              Navigator.pushNamed(context, ProfileScreen.routeName);
            },
          ),
        ],
      ),
      body: Consumer<WifiProvider>(
        builder: (context, wifiProvider, child) {
          final networks = wifiProvider.networks;
          if (networks.isEmpty) {
            return const Center(child: Text('Список мереж порожній'));
          }

          return ListView.builder(
            itemCount: networks.length,
            itemBuilder: (context, index) {
              final network = networks[index];
              return Dismissible(
                key: Key(network.id),
                background: const ColoredBox( 
                  color: Colors.red,
                  child: Align(
                    alignment: Alignment.centerRight,
                    child: Padding(
                      padding: EdgeInsets.only(right: 16),
                      child: Icon(Icons.delete, color: Colors.white),
                    ),
                  ),
                ),
                onDismissed: (_) {
                  context.read<WifiProvider>().deleteNetwork(network.id);
                },
                child: WifiListTile(
                  ssid: network.ssid,
                  strength: network.strength,
                  isSecured: network.isSecured,
                ),
              );
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _showAddDialog(context),
        backgroundColor: Theme.of(context).primaryColor,
        child: const Icon(Icons.add, color: Colors.black),
      ),
    );
  }
}

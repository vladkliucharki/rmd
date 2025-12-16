import 'package:flutter/material.dart';
import 'package:lab2flutter/components/primary_button.dart';
import 'package:lab2flutter/providers/auth_provider.dart';
import 'package:lab2flutter/screens/home_screen.dart';
import 'package:lab2flutter/screens/login_screen.dart';
import 'package:provider/provider.dart';

class ProfileScreen extends StatelessWidget {
  static const routeName = '/profile';
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final user = context.watch<AuthProvider>().user;
    final screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(title: const Text('Профіль')),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: screenWidth * 0.1,
            vertical: 24,
          ),
          child: Column(
            children: <Widget>[
              const SizedBox(height: 20),
              CircleAvatar(
                radius: 60,
                backgroundColor: Theme.of(context).primaryColor,
                child: const Icon(
                  Icons.person_sharp,
                  size: 80,
                  color: Colors.black,
                ),
              ),
              const SizedBox(height: 40),
              Card(
                child: ListTile(
                  leading: Icon(
                    Icons.person_outline,
                    color: Theme.of(context).primaryColor,
                  ),
                  title: Text(
                    user?.name ?? 'Unknown',
                    style: const TextStyle(fontSize: 18),
                  ),
                  subtitle: const Text('Ім\'я'),
                ),
              ),
              const SizedBox(height: 10),
              Card(
                child: ListTile(
                  leading: Icon(
                    Icons.email_outlined,
                    color: Theme.of(context).primaryColor,
                  ),
                  title: Text(
                    user?.email ?? 'Unknown',
                    style: const TextStyle(fontSize: 18),
                  ),
                  subtitle: const Text('Email'),
                ),
              ),
              const SizedBox(height: 40),
              PrimaryButton(
                text: 'На Головну (Wi-Fi)',
                onPressed: () {
                  Navigator.pushNamed(context, HomeScreen.routeName);
                },
              ),
              const SizedBox(height: 10),
              TextButton(
                onPressed: () {
                  context.read<AuthProvider>().logout();
                  Navigator.pushNamedAndRemoveUntil(
                    context,
                    LoginScreen.routeName,
                    (_) => false,
                  );
                },
                child: Text(
                  'Вийти з акаунту',
                  style: TextStyle(color: Colors.grey[400]),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

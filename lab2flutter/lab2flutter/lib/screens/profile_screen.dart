// lib/screens/profile_screen.dart
import 'package:flutter/material.dart';
import 'package:lab2flutter/components/primary_button.dart';
import 'package:lab2flutter/screens/home_screen.dart';
import 'package:lab2flutter/screens/login_screen.dart';

class ProfileScreen extends StatelessWidget {
  static const routeName = '/profile';
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(title: const Text('Профіль Користувача')),
      
      // ⭐ 1. Обгортаємо все в SingleChildScrollView
      body: SingleChildScrollView(
        child: Padding(
          // Додамо і вертикальний відступ, щоб контент не прилипав
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
                  title: const Text(
                    'Ім\'я: Олександр',
                    style: TextStyle(fontSize: 18),
                  ),
                ),
              ),
              const SizedBox(height: 10),
              Card(
                child: ListTile(
                  leading: Icon(
                    Icons.email_outlined,
                    color: Theme.of(context).primaryColor,
                  ),
                  title: const Text(
                    'Email: alex@it-academy.com',
                    style: TextStyle(fontSize: 18),
                  ),
                ),
              ),
              
              // ⭐ 2. Замінюємо Spacer на фіксований відступ
              // const Spacer(), // <-- ВИДАЛЕНО
              const SizedBox(height: 40), // <-- ДОДАНО

              PrimaryButton(
                text: 'На Головну (Wi-Fi)',
                onPressed: () {
                  Navigator.pushNamed(context, HomeScreen.routeName);
                },
              ),
              const SizedBox(height: 10),
              TextButton(
                onPressed: () {
                  Navigator.pushNamedAndRemoveUntil(
                    context,
                    LoginScreen.routeName,
                    (route) => false,
                  );
                },
                child: Text(
                  'Вийти з акаунту',
                  style: TextStyle(color: Colors.grey[400]),
                ),
              ),
              // Додамо трохи місця в кінці для скролу
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }
}
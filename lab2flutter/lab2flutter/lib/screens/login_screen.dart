// lib/screens/login_screen.dart
import 'package:flutter/material.dart';
import 'package:lab2flutter/components/custom_input_field.dart';
import 'package:lab2flutter/components/primary_button.dart';
import 'package:lab2flutter/screens/home_screen.dart';
import 'package:lab2flutter/screens/registration_screen.dart';

class LoginScreen extends StatelessWidget {
  static const routeName = '/login';
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // AppBar тепер не потрібен, тема застосується автоматично
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Column(
          children: <Widget>[
            const SizedBox(height: 80),
            // ⭐ НОВИЙ КОД: Велика іконка-логотип
            Icon(
              Icons.wifi_lock_rounded,
              size: 100,
              color: Theme.of(context).primaryColor,
            ),
            const SizedBox(height: 10),
            Text(
              'Wi-Fi Access',
              style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                    color: Theme.of(context).primaryColor,
                  ),
            ),
            const SizedBox(height: 40),
            const CustomInputField(labelText: 'Email'),
            const CustomInputField(
                labelText: 'Пароль', isPassword: true),
            const SizedBox(height: 30),
            PrimaryButton(
              text: 'Увійти',
              onPressed: () {
                Navigator.pushReplacementNamed(context, HomeScreen.routeName);
              },
            ),
            TextButton(
              onPressed: () {
                Navigator.pushNamed(context, RegistrationScreen.routeName);
              },
              // ⭐ НОВИЙ КОД: Стилізуємо TextButton
              child: Text(
                'Немає акаунту? Реєстрація',
                style: TextStyle(color: Colors.grey[400]),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

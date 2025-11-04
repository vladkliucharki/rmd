// lib/screens/registration_screen.dart
import 'package:flutter/material.dart';
import 'package:lab2flutter/components/custom_input_field.dart';
import 'package:lab2flutter/components/primary_button.dart';

class RegistrationScreen extends StatelessWidget {
  static const routeName = '/register';
  const RegistrationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Реєстрація')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Column(
          children: <Widget>[
            const SizedBox(height: 30),
            const CustomInputField(labelText: 'Ім\'я'),
            const CustomInputField(labelText: 'Email'),
            const CustomInputField(
                labelText: 'Пароль', isPassword: true),
            const CustomInputField(
                labelText: 'Повторити пароль', isPassword: true),
            const SizedBox(height: 30),
            PrimaryButton(
              text: 'Зареєструватися',
              onPressed: () {
                Navigator.pop(context);
              },
            ),
            TextButton(
              onPressed: () {
                Navigator.pop(context); // Повернення на Login
              },
              child: const Text('Вже є акаунт? Увійти'),
            ),
          ],
        ),
      ),
    );
  }
}

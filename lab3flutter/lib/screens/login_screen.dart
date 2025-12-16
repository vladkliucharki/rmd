import 'package:flutter/material.dart';
import 'package:lab2flutter/components/custom_input_field.dart';
import 'package:lab2flutter/components/primary_button.dart';
import 'package:lab2flutter/providers/auth_provider.dart';
import 'package:lab2flutter/screens/home_screen.dart';
import 'package:lab2flutter/screens/registration_screen.dart';
import 'package:provider/provider.dart';

class LoginScreen extends StatefulWidget {
  static const routeName = '/login';
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  void _login() async {
    if (_formKey.currentState!.validate()) {
      final success = await context.read<AuthProvider>().login(
            _emailController.text,
            _passwordController.text,
          );

      if (!mounted) return;

      if (success) {
        Navigator.pushReplacementNamed(context, HomeScreen.routeName);
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Невірний email або пароль'),
            backgroundColor: Colors.red,
          ),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final isLoading = context.watch<AuthProvider>().isLoading;

    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24),
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
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
                CustomInputField(
                  labelText: 'Email',
                  controller: _emailController,
                  validator: (value) {
                    if (value == null || !value.contains('@')) {
                      return 'Введіть коректний email';
                    }
                    return null;
                  },
                ),
                CustomInputField(
                  labelText: 'Пароль',
                  isPassword: true,
                  controller: _passwordController,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Введіть пароль';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 30),
                if (isLoading)
                  const CircularProgressIndicator()
                else
                  PrimaryButton(text: 'Увійти', onPressed: _login),
                TextButton(
                  onPressed: () {
                    Navigator.pushNamed(context, RegistrationScreen.routeName);
                  },
                  child: Text(
                    'Немає акаунту? Реєстрація',
                    style: TextStyle(color: Colors.grey[400]),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

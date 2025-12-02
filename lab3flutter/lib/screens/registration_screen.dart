import 'package:flutter/material.dart';
import 'package:lab2flutter/components/custom_input_field.dart';
import 'package:lab2flutter/components/primary_button.dart';
import 'package:lab2flutter/domain/models/user_model.dart';
import 'package:lab2flutter/providers/auth_provider.dart';
import 'package:provider/provider.dart';

class RegistrationScreen extends StatefulWidget {
  static const routeName = '/register';
  const RegistrationScreen({super.key});

  @override
  State<RegistrationScreen> createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmController = TextEditingController();

  void _register() async {
    if (_formKey.currentState!.validate()) {
      if (_passwordController.text != _confirmController.text) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Паролі не співпадають')),
        );
        return;
      }

      final newUser = User(
        name: _nameController.text,
        email: _emailController.text,
        password: _passwordController.text,
      );

      final success = await context.read<AuthProvider>().register(newUser);

      if (!mounted) return;

      if (success) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Реєстрація успішна!')),
        );
        Navigator.pop(context);
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Цей email вже зайнятий!'),
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
      appBar: AppBar(title: const Text('Реєстрація')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Form(
          key: _formKey,
          child: Column(
            children: <Widget>[
              const SizedBox(height: 30),
              CustomInputField(
                labelText: 'Ім\'я',
                controller: _nameController,
                validator: (v) => v!.isEmpty ? 'Введіть ім\'я' : null,
              ),
              CustomInputField(
                labelText: 'Email',
                controller: _emailController,
                validator: (v) => !v!.contains('@') ? 'Введіть email' : null,
              ),
              CustomInputField(
                labelText: 'Пароль',
                isPassword: true,
                controller: _passwordController,
                validator: (v) => v!.length < 6 ? 'Мін. 6 символів' : null,
              ),
              CustomInputField(
                labelText: 'Повторити пароль',
                isPassword: true,
                controller: _confirmController,
              ),
              const SizedBox(height: 30),
              if (isLoading)
                const CircularProgressIndicator()
              else
                PrimaryButton(
                  text: 'Зареєструватися',
                  onPressed: _register,
                ),
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: const Text('Вже є акаунт? Увійти'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

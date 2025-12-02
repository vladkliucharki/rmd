// lib/components/custom_input_field.dart
import 'package:flutter/material.dart';

class CustomInputField extends StatelessWidget {
  const CustomInputField({
    required this.labelText,
    this.isPassword = false,
    super.key,
  });

  final String labelText;
  final bool isPassword;

  IconData _getIconForLabel(String label) {
    if (label.toLowerCase().contains('email')) {
      return Icons.email_outlined;
    }
    if (label.toLowerCase().contains('пароль')) {
      return Icons.lock_outline;
    }
    if (label.toLowerCase().contains('ім\'я')) {
      return Icons.person_outline;
    }
    return Icons.text_fields; // Іконка за замовчуванням
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: TextField(
        obscureText: isPassword,
        decoration: InputDecoration(
          labelText: labelText,
          // ⭐ НОВИЙ КОД: Додаємо іконку на початок
          prefixIcon: Icon(
            _getIconForLabel(labelText),
            color: Colors.grey[400],
          ),
          border: const OutlineInputBorder(),
        ),
      ),
    );
  }
}

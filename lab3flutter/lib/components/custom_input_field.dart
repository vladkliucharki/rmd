import 'package:flutter/material.dart';

class CustomInputField extends StatelessWidget {
  const CustomInputField({
    required this.labelText,
    this.isPassword = false,
    this.controller,
    this.validator,
    super.key,
  });

  final String labelText;
  final bool isPassword;
  final TextEditingController? controller;
  final String? Function(String?)? validator;

  IconData _getIconForLabel(String label) {
    if (label.toLowerCase().contains('email')) return Icons.email_outlined;
    if (label.toLowerCase().contains('пароль')) return Icons.lock_outline;
    if (label.toLowerCase().contains('ім\'я')) return Icons.person_outline;
    return Icons.text_fields;
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: TextFormField(
        controller: controller,
        validator: validator,
        obscureText: isPassword,
        decoration: InputDecoration(
          labelText: labelText,
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

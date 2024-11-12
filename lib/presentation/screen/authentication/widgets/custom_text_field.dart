import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  final String hintText;
  final TextEditingController controller;
  final bool? obscureText;
  final VoidCallback? onPressedHidePass;
  final ValueChanged<String> onChanged;
  final IconData? icon;
  final String? errorText;
  final bool showIcon;

  const CustomTextField({
    super.key,
    required this.hintText,
    required this.controller,
    this.obscureText,
    this.showIcon = false,
    this.icon,
    this.onPressedHidePass,
    this.errorText,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      obscureText: obscureText ?? false,
      onChanged: onChanged,
      decoration: InputDecoration(
        hintText: hintText,
        hintStyle: const TextStyle(
          color: Color(0xFFB0B0B0),
        ),
        prefixIcon: icon != null
            ? Icon(icon, size: 26, color: const Color(0xFF0058C6))
            : null,
        suffixIcon: showIcon
            ? IconButton(
                onPressed: onPressedHidePass,
                icon: Icon(
                  obscureText ?? false
                      ? Icons.visibility
                      : Icons.visibility_off,
                  color: Theme.of(context).primaryColorDark,
                ),
              )
            : null,
        border: const OutlineInputBorder(
          borderSide: BorderSide(color: Colors.grey),
          borderRadius: BorderRadius.all(Radius.circular(8)),
        ),
        errorText: errorText,
      ),
    );
  }
}

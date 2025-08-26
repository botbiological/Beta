import 'package:flutter/material.dart';

class CustomSearchField extends StatelessWidget {
  final TextEditingController controller;
  final ValueChanged<String>? onChanged;
  final String hintText;
  final Color bgColor;
  final Color textColor;
  final Color hintColor;
  final Color iconColor;

  const CustomSearchField({
    super.key,
    required this.controller,
    this.onChanged,
    this.hintText = "Search here...",
    this.bgColor = const Color(0xFF1E1E1E), // dark bg
    this.textColor = Colors.white,
    this.hintColor = const Color(0x80FFFFFF), // white with opacity
    this.iconColor = Colors.white,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: bgColor,
        borderRadius: BorderRadius.circular(30), // rounded edges
      ),
      child: TextField(
        controller: controller,
        onChanged: onChanged,
        style: TextStyle(color: textColor),
        decoration: InputDecoration(
          prefixIcon: Icon(Icons.search, color: iconColor),
          hintText: hintText,
          hintStyle: TextStyle(color: hintColor),
          border: InputBorder.none,
          contentPadding: const EdgeInsets.symmetric(vertical: 14),
        ),
      ),
    );
  }
}

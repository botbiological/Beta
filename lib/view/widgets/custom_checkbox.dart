import 'package:flutter/material.dart';

class CustomCheckbox extends StatelessWidget {
  final bool value;
  final ValueChanged<bool> onChanged;
  final double size;
  final Color checkColor;
  final Color activeColor;

  const CustomCheckbox({
    super.key,
    required this.value,
    required this.onChanged,
    this.size = 24,
    this.checkColor = Colors.white,
    this.activeColor = Colors.red, // when checked, fill red
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => onChanged(!value),
      borderRadius: BorderRadius.circular(6),
      child: Container(
        width: size,
        height: size,
        decoration: BoxDecoration(
          color: value ? activeColor : Colors.transparent,
          borderRadius: BorderRadius.circular(6),
          border: Border.all(
            color: Colors.red, // 🔴 always red border
            width: 2,
          ),
        ),
        child: value
            ? Icon(Icons.check, size: size * 0.7, color: checkColor)
            : null,
      ),
    );
  }
}

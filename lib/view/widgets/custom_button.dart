import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provide/utils/routes/responsive.dart';
class CustomButton extends StatelessWidget {
  final String text;
  final Color bgColor;
  final Color textColor;
  final Color borderColor;
  final double borderRadius;
  final VoidCallback? onPressed; // ✅ make it nullable

  const CustomButton({
    super.key,
    required this.text,
    required this.bgColor,
    required this.textColor,
    required this.borderColor,
    required this.borderRadius,
    this.onPressed, // ✅ keep nullable
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed, // ✅ Flutter disables automatically if null
      style: ElevatedButton.styleFrom(
        backgroundColor: bgColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(borderRadius),
          side: BorderSide(color: borderColor),
        ),
      ),
      child: Text(
        text,
        style: TextStyle(color: textColor),
      ),
    );
  }
}

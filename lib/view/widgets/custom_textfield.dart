import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provide/utils/routes/responsive.dart';
import 'package:provide/utils/routes/utils.dart';

class CustomTextField extends StatelessWidget {
  final TextEditingController controller;
  final FocusNode focusNode;
  final FocusNode? nextFocusNode;
  final String hintText;
  final String iconPath;
  final TextInputType keyboardType;
  final bool obscureText;

  const CustomTextField({
    super.key,
    required this.controller,
    required this.focusNode,
    this.nextFocusNode,
    required this.hintText,
    required this.iconPath,
    this.keyboardType = TextInputType.text,
    this.obscureText = false,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      style: TextStyle(color: Colors.white),
      controller: controller,
      focusNode: focusNode,

      keyboardType: keyboardType,
      obscureText: obscureText,

      decoration: InputDecoration(
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(Responsive.w(12)),
          borderSide: BorderSide(),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(Responsive.w(12)),
          borderSide: BorderSide(color: Colors.red),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.grey),
          borderRadius: BorderRadius.circular(Responsive.w(12)),
        ),
        prefixIcon: Padding(
          padding: EdgeInsets.all(Responsive.w(3)),
          child: SvgPicture.asset(iconPath),
        ),
        filled: true,
        fillColor: Color(0x26000000),
        hintText: hintText,

        hintStyle: GoogleFonts.dmSans(
          color: Colors.white,
          fontWeight: FontWeight.normal,
          fontSize: Responsive.sp(12),
        ),
      ),
      onFieldSubmitted: (value) {
        if (nextFocusNode != null) {
          Utils.fieldFoucsChange(context, focusNode, nextFocusNode!);
        }
      },
    );
  }
}

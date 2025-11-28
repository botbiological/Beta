import 'package:flutter/material.dart';
import 'package:provide/res/components/app_color.dart';
import 'package:provide/utils/routes/responsive.dart';

class TextWidget extends StatelessWidget {
  final String text;
  final double fontSize;
  final Color color;
  final FontWeight fontWeight;
  final double letterSpacing;
  final TextAlign textAlign;
  final int maxLines;
  final TextOverflow overflow;
  final double height;

  const TextWidget({
    super.key,
    required this.text,
    this.fontSize = 14,
    this.color = AppColor.textColor,
    this.fontWeight = FontWeight.w600,
    this.letterSpacing = -0.30,
    this.textAlign = TextAlign.start,
    this.maxLines = 1,
    this.overflow = TextOverflow.ellipsis,
    this.height = 1.0,
  });

  @override
  Widget build(BuildContext context) {
    Responsive.init(context);
    
    return Text(
      text,
      textAlign: textAlign,
      maxLines: maxLines,
      overflow: overflow,
      style: TextStyle(
        color: color,
        fontSize: Responsive.textScaleFactor * fontSize,
        fontWeight: fontWeight,
        letterSpacing: letterSpacing,
        height: height,
      ),
    );
  }
}
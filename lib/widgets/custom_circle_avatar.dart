import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provide/res/components/app_color.dart';

class CustomTinyCircleAvatar extends StatelessWidget {
  final String? imageUrl;
  final String? fallbackText;
  final IconData? fallbackIcon;
  final bool isAsset;
  final Color bgColor;
  final Color textColor;
  final Color borderColor;
  final Color baseColor;
  final double size;
  final EdgeInsets? iconPadding;
  final VoidCallback? onTap; // 👈 added

  const CustomTinyCircleAvatar({
    super.key,
    this.imageUrl,
    this.baseColor = AppColor.textColor,
    this.fallbackText,
    this.fallbackIcon,
    this.isAsset = false,
    this.bgColor = const Color(0x33000000),
    this.textColor = Colors.white,
    this.borderColor = Colors.transparent,
    this.size = 40,
    this.iconPadding,
    this.onTap, // 👈 added
  });

  @override
  Widget build(BuildContext context) {
    final hasImage = (imageUrl != null && imageUrl!.trim().isNotEmpty);

    return GestureDetector(
      onTap: onTap, // 👈 triggers navigation
      child: Container(
        width: size,
        height: size,
        decoration: BoxDecoration(
          color: baseColor,
          shape: BoxShape.circle,
          border: Border.all(color: borderColor, width: 1),
        ),
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: hasImage ? _buildImage() : _buildFallback(),
        ),
      ),
    );
  }

  Widget _buildImage() {
    return isAsset
        ? SvgPicture.asset(imageUrl!, fit: BoxFit.cover)
        : Image.network(
            imageUrl!,
            fit: BoxFit.cover,
            errorBuilder: (_, __, ___) => _buildFallback(),
          );
  }

  Widget _buildFallback() {
    return Container(
      color: bgColor,
      alignment: Alignment.center,
      child: fallbackText != null && fallbackText!.isNotEmpty
          ? FittedBox(
              fit: BoxFit.scaleDown,
              child: Text(
                _initials(fallbackText!),
                style: TextStyle(
                  fontSize: size * 0.4,
                  fontWeight: FontWeight.w700,
                  color: textColor,
                ),
              ),
            )
          : Padding(
              padding: iconPadding ?? EdgeInsets.zero,
              child: Icon(
                fallbackIcon ?? Icons.person,
                size: size * 0.5,
                color: textColor,
              ),
            ),
    );
  }

  String _initials(String s) {
    final parts = s.trim().split(RegExp(r'\s+'));
    if (parts.isEmpty) return "";
    String first = parts.first.isNotEmpty ? parts.first[0] : "";
    String last = parts.length > 1 && parts.last.isNotEmpty
        ? parts.last[0]
        : "";
    return (first + last).toUpperCase();
  }
}

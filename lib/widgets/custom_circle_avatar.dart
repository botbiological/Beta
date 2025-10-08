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
          padding: isAsset == true ? EdgeInsets.all(8) : EdgeInsets.all(0),
          child: hasImage ? _buildImage() : _buildFallback(),
        ),
      ),
    );
  }

  Widget _buildImage() {
    if (isAsset) {
      // Check if the asset is an SVG file
      if (imageUrl!.toLowerCase().endsWith('.svg')) {
        return SvgPicture.asset(
          imageUrl!,
          fit: BoxFit.cover,
          // Add error handling for corrupted SVG files
          placeholderBuilder: (context) => _buildFallback(),
        );
      } else {
        // Handle PNG, JPG, and other image formats
        return Image.asset(
          imageUrl!,
          fit: BoxFit.cover,
          errorBuilder: (_, __, ___) => _buildFallback(),
        );
      }
    } else {
      return Image.asset(
        imageUrl!,
        fit: BoxFit.cover,
        errorBuilder: (_, __, ___) => _buildFallback(),
      );
    }
  }

  Widget _buildFallback() {
    return Padding(
      padding: iconPadding ?? EdgeInsets.zero, // 👈 apply padding here
      child: Container(
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
            : IconPaddingWrapper(
                padding: iconPadding ?? EdgeInsets.zero,
                icon: fallbackIcon ?? Icons.person,
                iconSize: size * 0.5,
                iconColor: textColor,
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

class IconPaddingWrapper extends StatelessWidget {
  final EdgeInsets padding;
  final IconData icon;
  final double iconSize;
  final Color iconColor;

  const IconPaddingWrapper({
    super.key,
    required this.padding,
    required this.icon,
    required this.iconSize,
    required this.iconColor,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: padding,
      child: Icon(icon, size: iconSize, color: iconColor),
    );
  }
}

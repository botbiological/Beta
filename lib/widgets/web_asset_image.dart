import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class WebAssetImage extends StatelessWidget {
  final String assetPath;
  final BoxFit fit;
  final double? width;
  final double? height;
  final BorderRadiusGeometry? borderRadius;

  const WebAssetImage({
    super.key,
    required this.assetPath,
    this.fit = BoxFit.cover,
    this.width,
    this.height,
    this.borderRadius,
  });

  @override
  Widget build(BuildContext context) {
    final String normalizedPath = assetPath.startsWith('assets/')
        ? assetPath
        : 'assets/$assetPath';
    final String encodedPath = normalizedPath
        .split('/')
        .map((segment) => Uri.encodeComponent(segment))
        .join('/');
    Widget image = kIsWeb
        ? Image.network(
            'assets/$encodedPath',
            fit: fit,
            width: width,
            height: height,
          )
        : Image.asset(
            normalizedPath,
            fit: fit,
            width: width,
            height: height,
          );
    if (borderRadius != null) {
      image = ClipRRect(borderRadius: borderRadius!, child: image);
    }
    return image;
  }
}

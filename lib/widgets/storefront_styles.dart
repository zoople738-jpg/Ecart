import 'package:flutter/material.dart';

class StorefrontColors {
  static const ink = Color(0xFF1C302B);
  static const green = Color(0xFF2E6B55);
  static const coral = Color(0xFFD76B50);
  static const paper = Color(0xFFF4F5F0);
  static const photo = Color(0xFFE9EDE7);
  static const muted = Color(0xFF718078);
  static const line = Color(0xFFE2E7E1);
}

class ProductPhoto extends StatelessWidget {
  final String imageUrl;
  final BoxFit fit;
  final BorderRadius borderRadius;

  const ProductPhoto({
    super.key,
    required this.imageUrl,
    this.fit = BoxFit.cover,
    this.borderRadius = BorderRadius.zero,
  });

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: borderRadius,
      child: ColoredBox(
        color: StorefrontColors.photo,
        child: Image.network(
          imageUrl,
          width: double.infinity,
          height: double.infinity,
          fit: fit,
          errorBuilder: (context, error, stackTrace) => const Center(
            child: Icon(
              Icons.photo_outlined,
              color: StorefrontColors.muted,
              size: 38,
            ),
          ),
        ),
      ),
    );
  }
}

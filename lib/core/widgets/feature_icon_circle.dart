
import 'package:flutter/material.dart';
import 'package:figma_app/core/theme/app_colors.dart';

/// Feature Icon Circle - Pattern phổ biến trong Figma
/// Icon tròn với background color cho các tính năng
class FeatureIconCircle extends StatelessWidget {
  final IconData icon;
  final Color? iconColor;
  final Color? backgroundColor;
  final double size;
  final double iconSize;

  const FeatureIconCircle({
    super.key,
    required this.icon,
    this.iconColor,
    this.backgroundColor,
    this.size = 56,
    this.iconSize = 28,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        color: backgroundColor ?? AppColors.primaryLight,
        shape: BoxShape.circle,
      ),
      child: Icon(
        icon,
        color: iconColor ?? AppColors.primary,
        size: iconSize,
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:figma_app/core/utils/responsive/responsive.dart';
import 'package:figma_app/core/theme/app_colors.dart';
import 'package:figma_app/core/theme/app_shadows.dart';

/// Custom Card Widget - Dựa trên card design từ Figma
class AppCard extends StatelessWidget {
  final Widget child;
  final EdgeInsetsGeometry? padding;
  final double? width;
  final double? height;
  final Color? backgroundColor;
  final double borderRadius;
  final List<BoxShadow>? boxShadow;
  final Border? border;
  final VoidCallback? onTap;

  const AppCard({
    super.key,
    required this.child,
    this.padding,
    this.width,
    this.height,
    this.backgroundColor,
    this.borderRadius = 12,
    this.boxShadow,
    this.border,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final responsivePad = padding ?? ResponsiveHelper.cardPadding(context);
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: width,
        height: height,
        padding: responsivePad,
        decoration: BoxDecoration(
          color: backgroundColor ?? AppColors.cardBackground,
          borderRadius: BorderRadius.circular(borderRadius),
          boxShadow: boxShadow ?? AppShadows.small,
          border: border,
        ),
        child: child,
      ),
    );
  }
}


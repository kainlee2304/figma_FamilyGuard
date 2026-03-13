import 'package:flutter/material.dart';
import '../../theme/app_colors.dart';

/// Gradient Background phổ biến trong Figma design
/// Sử dụng cho toàn bộ screen có gradient teal background
class GradientBackground extends StatelessWidget {
  final Widget child;
  final List<Color>? colors;

  const GradientBackground({
    super.key,
    required this.child,
    this.colors,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: colors ?? const [
            AppColors.gradientStart,
            AppColors.gradientEnd,
          ],
        ),
      ),
      child: child,
    );
  }
}

import 'package:flutter/material.dart';
import '../../core/responsive/responsive.dart';
import '../../theme/app_colors.dart';

/// Section Header widget - Pattern phổ biến trong Figma
/// Gồm title bên trái + optional action text bên phải
class SectionHeader extends StatelessWidget {
  final String title;
  final String? actionText;
  final VoidCallback? onActionTap;
  final EdgeInsetsGeometry padding;

  const SectionHeader({
    super.key,
    required this.title,
    this.actionText,
    this.onActionTap,
    this.padding = const EdgeInsets.symmetric(horizontal: 24),
  });

  @override
  Widget build(BuildContext context) {
    final titleSz = ResponsiveHelper.sp(context, 18);
    final actionSz = ResponsiveHelper.sp(context, 14);
    return Padding(
      padding: padding,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: TextStyle(
              color: AppColors.primary,
              fontSize: titleSz,
              fontFamily: 'Lexend',
              fontWeight: FontWeight.w700,
              height: 1.56,
            ),
          ),
          if (actionText != null)
            TextButton(
              onPressed: onActionTap,
              child: Text(
                actionText!,
                style: TextStyle(
                  color: AppColors.primary,
                  fontSize: actionSz,
                  fontFamily: 'Lexend',
                  fontWeight: FontWeight.w700,
                  height: 1.43,
                ),
              ),
            ),
        ],
      ),
    );
  }
}

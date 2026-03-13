import 'package:flutter/material.dart';
import '../../theme/app_colors.dart';
import '../../theme/app_text_styles.dart';

/// Badge / Chip Widget - Dựa trên badge/tag component từ Figma
class AppBadge extends StatelessWidget {
  final String text;
  final Color? backgroundColor;
  final Color? textColor;
  final double borderRadius;
  final EdgeInsetsGeometry? padding;
  final IconData? icon;

  const AppBadge({
    super.key,
    required this.text,
    this.backgroundColor,
    this.textColor,
    this.borderRadius = 20,
    this.padding,
    this.icon,
  });

  /// Preset: Unified badge (all use primary color)
  factory AppBadge.success(String text) => AppBadge(
        text: text,
        backgroundColor: AppColors.primary.withOpacity(0.1),
        textColor: AppColors.primary,
      );

  factory AppBadge.warning(String text) => AppBadge(
        text: text,
        backgroundColor: AppColors.primary.withOpacity(0.1),
        textColor: AppColors.primary,
      );

  factory AppBadge.error(String text) => AppBadge(
        text: text,
        backgroundColor: AppColors.primary.withOpacity(0.1),
        textColor: AppColors.primary,
      );

  factory AppBadge.info(String text) => AppBadge(
        text: text,
        backgroundColor: AppColors.primary.withOpacity(0.1),
        textColor: AppColors.primary,
      );

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: padding ??
          const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(
        color: backgroundColor ?? AppColors.primary.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(borderRadius),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (icon != null) ...[
            Icon(icon, size: 12, color: textColor ?? AppColors.primary),
            const SizedBox(width: 4),
          ],
          Text(
            text,
            style: AppTextStyles.labelSmall.copyWith(
              color: textColor ?? AppColors.primary,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:figma_app/core/utils/responsive/responsive.dart';
import 'package:figma_app/core/theme/app_colors.dart';
import 'package:figma_app/core/theme/app_text_styles.dart';
import 'package:figma_app/core/theme/app_shadows.dart';

/// List Item Widget - Dựa trên list item component từ Figma
class AppListItem extends StatelessWidget {
  final Widget? leading;
  final String title;
  final String? subtitle;
  final Widget? trailing;
  final VoidCallback? onTap;
  final EdgeInsetsGeometry? padding;
  final bool showDivider;
  final bool showShadow;

  const AppListItem({
    super.key,
    this.leading,
    required this.title,
    this.subtitle,
    this.trailing,
    this.onTap,
    this.padding,
    this.showDivider = true,
    this.showShadow = false,
  });

  @override
  Widget build(BuildContext context) {
    final hPad = ResponsiveHelper.isTablet(context) ? 20.0 : 16.0;
    final vPad = ResponsiveHelper.isTablet(context) ? 16.0 : 12.0;
    final titleSz = ResponsiveHelper.sp(context, 16);
    final subtitleSz = ResponsiveHelper.sp(context, 12);
    final child = InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(12),
      child: Container(
        padding: padding ??
            EdgeInsets.symmetric(horizontal: hPad, vertical: vPad),
        decoration: BoxDecoration(
          color: AppColors.card,
          borderRadius: showShadow ? BorderRadius.circular(12) : null,
          boxShadow: showShadow ? AppShadows.small : null,
        ),
        child: Row(
          children: [
            if (leading != null) ...[
              leading!,
              const SizedBox(width: 12),
            ],
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: AppTextStyles.bodyLarge.copyWith(
                      color: AppColors.primary,
                      fontWeight: FontWeight.w500,
                      fontSize: titleSz,
                    ),
                  ),
                  if (subtitle != null) ...[
                    const SizedBox(height: 2),
                    Text(
                      subtitle!,
                      style: AppTextStyles.bodySmall.copyWith(
                        color: AppColors.textGrey,
                        fontSize: subtitleSz,
                      ),
                    ),
                  ],
                ],
              ),
            ),
            if (trailing != null) ...[
              const SizedBox(width: 12),
              trailing!,
            ] else if (onTap != null) ...[
              const Icon(
                Icons.chevron_right,
                color: AppColors.textGrey,
                size: 20,
              ),
            ],
          ],
        ),
      ),
    );

    if (showDivider && !showShadow) {
      return Column(
        children: [
          child,
          Divider(height: 1, indent: leading != null ? 52 : 16),
        ],
      );
    }

    return child;
  }
}


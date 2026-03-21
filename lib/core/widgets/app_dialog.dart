
import 'package:flutter/material.dart';
import 'package:figma_app/core/theme/app_colors.dart';

/// Các preset loại dialog
enum AppDialogType { delete, success, warning, info }

/// Dialog dùng chung cho toàn bộ app.
///
/// Sử dụng:
/// ```dart
/// AppDialog.show(
///   context: context,
///   type: AppDialogType.delete,
///   title: 'Xóa tài khoản',
///   content: 'Tài khoản sẽ được xóa khỏi hệ thống...',
///   confirmText: 'Xóa tài khoản',
///   onConfirm: () { /* action */ },
/// );
/// ```
class AppDialog {
  AppDialog._();

  // ── Color presets ───────────────────────────────────────────────
  static const _presets = {
    AppDialogType.delete: _Preset(
      iconBg: AppColors.primaryLight,
      iconColor: AppColors.primary,
      icon: Icons.error_outline_rounded,
      buttonBg: AppColors.primary,
      buttonShadow: AppColors.primaryLight,
    ),
    AppDialogType.success: _Preset(
      iconBg: AppColors.primaryLight,
      iconColor: AppColors.primary,
      icon: Icons.check_circle_outline_rounded,
      buttonBg: AppColors.primary,
      buttonShadow: AppColors.primaryLight,
    ),
    AppDialogType.warning: _Preset(
      iconBg: AppColors.primaryLight,
      iconColor: AppColors.primary,
      icon: Icons.warning_amber_rounded,
      buttonBg: AppColors.primary,
      buttonShadow: AppColors.primaryLight,
    ),
    AppDialogType.info: _Preset(
      iconBg: AppColors.primaryLight,
      iconColor: AppColors.primary,
      icon: Icons.info_outline_rounded,
      buttonBg: AppColors.primary,
      buttonShadow: AppColors.primaryLight,
    ),
  };

  // ── Standard dialog (icon + title + content + confirm/cancel) ──
  static Future<T?> show<T>({
    required BuildContext context,
    required AppDialogType type,
    required String title,
    String? content,
    String confirmText = 'Xác nhận',
    String cancelText = 'Hủy',
    VoidCallback? onConfirm,
    VoidCallback? onCancel,
    bool showCancel = true,
    bool barrierDismissible = true,
    IconData? icon,
  }) {
    final preset = _presets[type]!;
    return showGeneralDialog<T>(
      context: context,
      barrierDismissible: barrierDismissible,
      barrierLabel: 'dismiss',
      barrierColor: Colors.black38,
      transitionDuration: const Duration(milliseconds: 250),
      transitionBuilder: (ctx, anim, _, child) {
        return ScaleTransition(
          scale: CurvedAnimation(parent: anim, curve: Curves.easeOutBack),
          child: FadeTransition(opacity: anim, child: child),
        );
      },
      pageBuilder: (ctx, _, __) {
        return Center(
          child: Material(
            color: Colors.transparent,
            child: Container(
              margin: const EdgeInsets.symmetric(horizontal: 32),
              padding:
                  const EdgeInsets.symmetric(horizontal: 24, vertical: 32),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20),
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  // Icon
                  Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: preset.iconBg,
                      shape: BoxShape.circle,
                    ),
                    child: Icon(icon ?? preset.icon,
                        color: preset.iconColor, size: 32),
                  ),
                  const SizedBox(height: 16),

                  // Title
                  Text(
                    title,
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      fontSize: 18,
                      fontFamily: 'Lexend',
                      fontWeight: FontWeight.w700,
                      color: Color(0xFF1E293B),
                    ),
                  ),

                  // Content
                  if (content != null) ...[
                    const SizedBox(height: 12),
                    Text(
                      content,
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        fontSize: 14,
                        fontFamily: 'Lexend',
                        fontWeight: FontWeight.w400,
                        color: Color(0xFF64748B),
                        height: 1.43,
                      ),
                    ),
                  ],
                  const SizedBox(height: 24),

                  // Confirm button
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: preset.buttonBg,
                        foregroundColor: Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30),
                        ),
                        padding: const EdgeInsets.symmetric(vertical: 14),
                        elevation: 4,
                        shadowColor: preset.buttonShadow,
                      ),
                      onPressed: () {
                        Navigator.of(ctx).pop(true);
                        onConfirm?.call();
                      },
                      child: Text(confirmText),
                    ),
                  ),

                  // Cancel button
                  if (showCancel) ...[
                    const SizedBox(height: 12),
                    TextButton(
                      onPressed: () {
                        Navigator.of(ctx).pop(false);
                        onCancel?.call();
                      },
                      child: Text(
                        cancelText,
                        style: const TextStyle(
                          fontFamily: 'Lexend',
                          fontSize: 15,
                          fontWeight: FontWeight.w500,
                          color: Color(0xFF64748B),
                        ),
                      ),
                    ),
                  ],
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  // ── Custom content dialog (for grids, forms, etc.) ─────────────
  static Future<T?> showCustom<T>({
    required BuildContext context,
    required String title,
    required Widget child,
    String cancelText = 'Hủy',
    bool showCancel = true,
    bool barrierDismissible = true,
  }) {
    return showGeneralDialog<T>(
      context: context,
      barrierDismissible: barrierDismissible,
      barrierLabel: 'dismiss',
      barrierColor: Colors.black38,
      transitionDuration: const Duration(milliseconds: 250),
      transitionBuilder: (ctx, anim, _, child) {
        return ScaleTransition(
          scale: CurvedAnimation(parent: anim, curve: Curves.easeOutBack),
          child: FadeTransition(opacity: anim, child: child),
        );
      },
      pageBuilder: (ctx, _, __) {
        return Center(
          child: Material(
            color: Colors.transparent,
            child: Container(
              margin: const EdgeInsets.symmetric(horizontal: 24),
              padding: const EdgeInsets.fromLTRB(20, 24, 20, 16),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20),
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  // Title
                  Text(
                    title,
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      fontSize: 18,
                      fontFamily: 'Lexend',
                      fontWeight: FontWeight.w700,
                      color: Color(0xFF006D5B),
                    ),
                  ),
                  const SizedBox(height: 20),

                  // Custom child
                  child,

                  // Cancel
                  if (showCancel) ...[
                    const SizedBox(height: 16),
                    TextButton(
                      onPressed: () => Navigator.of(ctx).pop(),
                      style: TextButton.styleFrom(
                        minimumSize: const Size(double.infinity, 44),
                      ),
                      child: Text(
                        cancelText,
                        style: const TextStyle(
                          fontFamily: 'Lexend',
                          fontSize: 15,
                          fontWeight: FontWeight.w600,
                          color: Color(0xFF64748B),
                        ),
                      ),
                    ),
                  ],
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}

class _Preset {
  final Color iconBg;
  final Color iconColor;
  final IconData icon;
  final Color buttonBg;
  final Color buttonShadow;

  const _Preset({
    required this.iconBg,
    required this.iconColor,
    required this.icon,
    required this.buttonBg,
    required this.buttonShadow,
  });
}


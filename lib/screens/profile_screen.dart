import 'package:flutter/material.dart';
import '../core/responsive/responsive.dart';
import '../theme/theme.dart';
import '../widgets/common/app_dialog.dart';
import '../widgets/common/common_widgets.dart';

/// ============================================================
/// PROFILE SCREEN - Template
/// Paste code Widget từ Figma Dev Mode vào đây
/// ============================================================
class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final hPad = ResponsiveHelper.horizontalPadding(context);
    final avatarRadius = ResponsiveHelper.wp(context, 13).clamp(40.0, 64.0);
    final h3Sz = ResponsiveHelper.sp(context, 20);
    final bodyMdSz = ResponsiveHelper.sp(context, 14);
    final captionSz = ResponsiveHelper.sp(context, 12);

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        title: Text(
          'Hồ sơ',
          style: TextStyle(fontSize: ResponsiveHelper.sp(context, 18)),
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.settings_outlined,
                size: ResponsiveHelper.sp(context, 24)),
            onPressed: () {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Cài đặt sẽ được cập nhật')),
              );
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(height: 24),

            // === AVATAR ===
            Center(
              child: Stack(
                children: [
                  CircleAvatar(
                    radius: avatarRadius,
                    backgroundColor: AppColors.primary.withValues(alpha: 0.1),
                    child: Icon(
                      Icons.person,
                      size: avatarRadius,
                      color: AppColors.primary,
                    ),
                  ),
                  Positioned(
                    bottom: 0,
                    right: 0,
                    child: Container(
                      padding: EdgeInsets.all(6),
                      decoration: BoxDecoration(
                        color: AppColors.primary,
                        shape: BoxShape.circle,
                        border: Border.all(color: Colors.white, width: 2),
                      ),
                      child: Icon(
                        Icons.camera_alt,
                        size: ResponsiveHelper.sp(context, 16),
                        color: Colors.white,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),

            // === NAME ===
            Text(
              'Nguyen Van A',
              style: AppTextStyles.h3.copyWith(
                color: AppColors.textPrimary,
                fontSize: h3Sz,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              'nguyenvana@email.com',
              style: AppTextStyles.bodyMedium.copyWith(
                color: AppColors.textSecondary,
                fontSize: bodyMdSz,
              ),
            ),
            const SizedBox(height: 24),

            // === STATS ROW ===
            Padding(
              padding: EdgeInsets.symmetric(horizontal: hPad),
              child: Row(
                children: [
                  _buildStat(context, '12', 'Dự án', h3Sz, captionSz),
                  Container(
                    height: 40,
                    width: 1,
                    color: AppColors.border,
                  ),
                  _buildStat(context, '48', 'Widget', h3Sz, captionSz),
                  Container(
                    height: 40,
                    width: 1,
                    color: AppColors.border,
                  ),
                  _buildStat(context, '156', 'Thiết kế', h3Sz, captionSz),
                ],
              ),
            ),
            const SizedBox(height: 24),

            // === MENU ITEMS ===
            _buildMenuItem(context, Icons.person_outline, 'Thông tin cá nhân'),
            _buildMenuItem(context, Icons.notifications_outlined, 'Thông báo'),
            _buildMenuItem(context, Icons.palette_outlined, 'Giao diện'),
            _buildMenuItem(context, Icons.security_outlined, 'Bảo mật'),
            _buildMenuItem(context, Icons.help_outline, 'Trợ giúp'),
            _buildMenuItem(context, Icons.info_outline, 'Về ứng dụng'),
            const SizedBox(height: 16),

            // === LOGOUT BUTTON ===
            Padding(
              padding: EdgeInsets.symmetric(horizontal: hPad),
              child: AppButton(
                text: 'Đăng xuất',
                backgroundColor: AppColors.error,
                onPressed: () {
                  AppDialog.show(
                    context: context,
                    type: AppDialogType.warning,
                    title: 'Xác nhận',
                    content: 'Bạn có chắc muốn đăng xuất?',
                    confirmText: 'Đăng xuất',
                    icon: Icons.logout_rounded,
                    onConfirm: () {
                      Navigator.of(context).pushNamedAndRemoveUntil('/', (_) => false);
                    },
                  );
                },
              ),
            ),
            const SizedBox(height: 32),
          ],
        ),
      ),
    );
  }

  Widget _buildStat(BuildContext context, String value, String label,
      double valSz, double lblSz) {
    return Expanded(
      child: Column(
        children: [
          Text(
            value,
            style: AppTextStyles.h3.copyWith(
              color: AppColors.primary,
              fontSize: valSz,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            label,
            style: AppTextStyles.caption.copyWith(
              color: AppColors.textSecondary,
              fontSize: lblSz,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMenuItem(BuildContext context, IconData icon, String title) {
    final hPad = ResponsiveHelper.horizontalPadding(context);
    final iconSz = ResponsiveHelper.sp(context, 20);
    final titleSz = ResponsiveHelper.sp(context, 16);

    return ListTile(
      contentPadding: EdgeInsets.symmetric(horizontal: hPad, vertical: 4),
      leading: Container(
        padding: EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: AppColors.primary.withValues(alpha: 0.1),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Icon(icon, color: AppColors.primary, size: iconSz),
      ),
      title: Text(
        title,
        style: AppTextStyles.bodyLarge.copyWith(
          color: AppColors.textPrimary,
          fontSize: titleSz,
        ),
      ),
      trailing: const Icon(
        Icons.chevron_right,
        color: AppColors.textHint,
      ),
      onTap: () {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('$title - sẽ được cập nhật')),
        );
      },
    );
  }
}

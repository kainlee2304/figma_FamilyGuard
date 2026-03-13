import 'package:flutter/material.dart';
import '../../core/responsive/responsive.dart';
import '../../theme/app_colors.dart';

/// Bottom Navigation Bar tùy chỉnh theo design Figma
/// Sử dụng lại cho tất cả các screen có bottom nav
class AppBottomNav extends StatelessWidget {
  final int currentIndex;
  final ValueChanged<int> onTap;

  const AppBottomNav({
    super.key,
    required this.currentIndex,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final navItems = [
      _NavItem(icon: Icons.home_outlined, activeIcon: Icons.home, label: 'Trang chủ'),
      _NavItem(icon: Icons.notifications_outlined, activeIcon: Icons.notifications, label: 'Lịch nhắc'),
      _NavItem(icon: Icons.monitor_heart_outlined, activeIcon: Icons.monitor_heart, label: 'Sức khỏe'),
      _NavItem(icon: Icons.person_outline, activeIcon: Icons.person, label: 'Cá nhân'),
    ];

    final isTablet = ResponsiveHelper.isTablet(context);
    final hPad = ResponsiveHelper.horizontalPadding(context);
    final iconSz = ResponsiveHelper.sp(context, 24);
    final labelSz = ResponsiveHelper.sp(context, 10);
    final itemWidth = isTablet ? 80.0 : 60.0;

    return Container(
      padding: EdgeInsets.symmetric(horizontal: hPad, vertical: 12),
      decoration: BoxDecoration(
        color: Colors.white,
        border: const Border(
          top: BorderSide(color: AppColors.border, width: 1),
        ),
      ),
      child: SafeArea(
        top: false,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: navItems.asMap().entries.map((entry) {
            final index = entry.key;
            final item = entry.value;
            final isActive = index == currentIndex;

            return GestureDetector(
              onTap: () => onTap(index),
              behavior: HitTestBehavior.opaque,
              child: SizedBox(
                width: itemWidth,
                height: ResponsiveHelper.minTapTarget,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      isActive ? item.activeIcon : item.icon,
                      size: iconSz,
                      color: isActive ? AppColors.primary : AppColors.textGrey,
                    ),
                    const SizedBox(height: 4),
                    Text(
                      item.label,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: isActive ? AppColors.primary : AppColors.textGrey,
                        fontSize: labelSz,
                        fontFamily: 'Lexend',
                        fontWeight: isActive ? FontWeight.w700 : FontWeight.w500,
                        height: 1.5,
                      ),
                    ),
                  ],
                ),
              ),
            );
          }).toList(),
        ),
      ),
    );
  }
}

class _NavItem {
  final IconData icon;
  final IconData activeIcon;
  final String label;

  const _NavItem({
    required this.icon,
    required this.activeIcon,
    required this.label,
  });
}

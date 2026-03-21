import 'package:flutter/material.dart';
import 'package:figma_app/core/utils/responsive/responsive.dart';

/// Floating pill-shaped bottom nav bar, identical to MainShellScreen's nav.
/// [activeIndex] highlights the given tab (0=home, 1=map, 2=notif, 3=profile).
/// Pass -1 for no tab highlighted.
class FloatingBottomNav extends StatelessWidget {
  final int activeIndex;
  final ValueChanged<int> onTap;

  const FloatingBottomNav({
    super.key,
    this.activeIndex = -1,
    required this.onTap,
  });

  static const _icons = [
    Icons.dashboard_rounded,
    Icons.map_rounded,
    Icons.notifications_rounded,
    Icons.person_rounded,
  ];

  @override
  Widget build(BuildContext context) {
    final isTablet = ResponsiveHelper.isTablet(context);
    final iconContainerSize = ResponsiveHelper.sp(context, isTablet ? 60 : 52);
    final iconSz = ResponsiveHelper.sp(context, 24);

    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: isTablet ? 24.0 : 8.0,
        vertical: 8,
      ),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(width: 1, color: const Color(0xFFF3F4F6)),
        borderRadius: BorderRadius.circular(9999),
        boxShadow: const [
          BoxShadow(
            color: Color(0x3300ACB2),
            blurRadius: 50,
            offset: Offset(0, 25),
            spreadRadius: -12,
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: List.generate(_icons.length, (index) {
          final isActive = index == activeIndex;
          final containerSize = iconContainerSize.clamp(
            ResponsiveHelper.minTapTarget,
            80.0,
          );
          return GestureDetector(
            onTap: () => onTap(index),
            behavior: HitTestBehavior.opaque,
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 200),
              width: containerSize,
              height: containerSize,
              decoration: ShapeDecoration(
                color: isActive ? const Color(0xFF00ACB2) : Colors.transparent,
                shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(9999)),
                ),
                shadows: isActive
                    ? const [
                        BoxShadow(
                          color: Color(0x6600ACB2),
                          blurRadius: 6,
                          offset: Offset(0, 4),
                          spreadRadius: -4,
                        ),
                        BoxShadow(
                          color: Color(0x6600ACB2),
                          blurRadius: 15,
                          offset: Offset(0, 10),
                          spreadRadius: -3,
                        ),
                      ]
                    : [],
              ),
              child: Center(
                child: AnimatedSwitcher(
                  duration: const Duration(milliseconds: 200),
                  child: Icon(
                    _icons[index],
                    key: ValueKey(isActive),
                    size: iconSz,
                    color: isActive ? Colors.white : const Color(0xFF9CA3AF),
                  ),
                ),
              ),
            ),
          );
        }),
      ),
    );
  }
}


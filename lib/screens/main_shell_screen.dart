import 'package:flutter/material.dart';
import '../core/responsive/responsive.dart';
import 'role2_homepage.dart';

/// ============================================================
/// MAIN SHELL SCREEN — Màn hình vỏ với Bottom Navigation (Figma)
///
/// Navbar style: pill-shape, 4 tabs (dashboard, map, notifications, person)
/// Active tab: circle highlight màu 0xFF00ACB2
/// ============================================================
class MainShellScreen extends StatefulWidget {
  final int initialIndex;
  const MainShellScreen({super.key, this.initialIndex = 0});

  @override
  State<MainShellScreen> createState() => _MainShellScreenState();
}

class _MainShellScreenState extends State<MainShellScreen>
    with TickerProviderStateMixin {
  late int _currentIndex;

  final List<GlobalKey<NavigatorState>> _navigatorKeys = [
    GlobalKey<NavigatorState>(),
  ];

  late AnimationController _tabAnimCtrl;

  @override
  void initState() {
    super.initState();
    _currentIndex = widget.initialIndex;
    _tabAnimCtrl = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 200),
    )..forward();
  }

  @override
  void dispose() {
    _tabAnimCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      onPopInvokedWithResult: (didPop, result) async {
        if (didPop) return;
        final nav = _navigatorKeys[0].currentState;
        if (nav != null && nav.canPop()) {
          nav.pop();
        }
      },
      child: Scaffold(
        body: Stack(
          children: [
            _TabNavigator(
              navigatorKey: _navigatorKeys[0],
              routeBuilder: (_) => const Role2Homepage(),
            ),
            // Floating bottom nav
            Positioned(
              left: 0,
              right: 0,
              bottom: 0,
              child: SafeArea(
                top: false,
                child: Padding(
                  padding: const EdgeInsets.only(
                    left: 24,
                    right: 24,
                    bottom: 16,
                  ),
                  child: _FigmaBottomNav(
                    currentIndex: 0,
                    onTap: (_) {}, // Các icon không liên kết trang nào
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ─── Tab Navigator ────────────────────────────────────────────────────────
class _TabNavigator extends StatelessWidget {
  final GlobalKey<NavigatorState> navigatorKey;
  final WidgetBuilder routeBuilder;

  const _TabNavigator({
    required this.navigatorKey,
    required this.routeBuilder,
  });

  @override
  Widget build(BuildContext context) {
    return Navigator(
      key: navigatorKey,
      onGenerateRoute: (settings) =>
          MaterialPageRoute(settings: settings, builder: routeBuilder),
    );
  }
}

// ─── Bottom Navigation Bar (Figma style) ────────────────────────────────
class _FigmaBottomNav extends StatelessWidget {
  final int currentIndex;
  final ValueChanged<int> onTap;

  const _FigmaBottomNav({
    required this.currentIndex,
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
          final isActive = index == currentIndex;
          // Ensure min tap target 48x48 even on small screens
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
                color: isActive
                    ? const Color(0xFF00ACB2)
                    : Colors.transparent,
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
                    color: isActive
                        ? Colors.white
                        : const Color(0xFF9CA3AF),
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

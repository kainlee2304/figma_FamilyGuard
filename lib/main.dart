import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'theme/app_theme.dart';
import 'routes/app_routes.dart';
import 'services/safe_zone_service.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  // Thiết lập status bar style
  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: Brightness.dark,
      statusBarBrightness: Brightness.light,
    ),
  );

  // Hỗ trợ portrait + landscape (tablet/iPad cần landscape)
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
    DeviceOrientation.landscapeLeft,
    DeviceOrientation.landscapeRight,
  ]);

  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  static final navigatorKey = GlobalKey<NavigatorState>();

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  late final SafeZoneService _safeZoneService;

  @override
  void initState() {
    super.initState();
    _safeZoneService = SafeZoneService();
  }

  @override
  void dispose() {
    _safeZoneService.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeZoneProvider(
      service: _safeZoneService,
      child: MaterialApp(
      navigatorKey: MyApp.navigatorKey,
      title: 'FamilyGuard',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,
      themeMode: ThemeMode.light,
      routes: AppRoutes.routes,
      initialRoute: AppRoutes.home,

      // ── Disable auto text scaling — layout kiểm soát kích thước font ──
      // Ngăn system font size (accessibility) phá layout
      builder: (context, child) {
        // Clamp text scale: min 0.85x, max 1.15x để vẫn hỗ trợ a11y nhẹ
        final mediaQuery = MediaQuery.of(context);
        final clampedScale = mediaQuery.textScaler.scale(1.0).clamp(0.85, 1.15);
        return MediaQuery(
          data: mediaQuery.copyWith(
            textScaler: TextScaler.linear(clampedScale),
          ),
          child: child!,
        );
      },

      // Custom page transition: slide từ phải cho mọi route push
      onGenerateRoute: (settings) {
        final builder = AppRoutes.routes[settings.name];
        if (builder == null) return null;
        return PageRouteBuilder(
          settings: settings,
          pageBuilder: (ctx, _, __) => builder(ctx),
          transitionDuration: const Duration(milliseconds: 300),
          reverseTransitionDuration: const Duration(milliseconds: 250),
          transitionsBuilder: (_, anim, __, child) {
            return SlideTransition(
              position: Tween<Offset>(
                begin: const Offset(1.0, 0.0),
                end: Offset.zero,
              ).animate(CurvedAnimation(
                parent: anim,
                curve: Curves.easeOutCubic,
                reverseCurve: Curves.easeInCubic,
              )),
              child: child,
            );
          },
        );
      },
    ),
    );
  }
}

// ─── Global Hover Bottom Nav Overlay ──────────────────────────────────────
class _HoverBottomNavOverlay extends StatefulWidget {
  final Widget child;
  final GlobalKey<NavigatorState> navigatorKey;

  const _HoverBottomNavOverlay({
    required this.child,
    required this.navigatorKey,
  });

  @override
  State<_HoverBottomNavOverlay> createState() => _HoverBottomNavOverlayState();
}

class _HoverBottomNavOverlayState extends State<_HoverBottomNavOverlay>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  late final Animation<Offset> _slideAnimation;
  bool _isVisible = false;
  Timer? _hideTimer;
  bool _isHomeRoute = true;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 250),
    );
    _slideAnimation = Tween<Offset>(
      begin: const Offset(0, 1.5),
      end: Offset.zero,
    ).animate(CurvedAnimation(
      parent: _controller,
      curve: Curves.easeOutCubic,
      reverseCurve: Curves.easeInCubic,
    ));

    // Lắng nghe route changes để biết có đang ở home không
    WidgetsBinding.instance.addPostFrameCallback((_) {
      widget.navigatorKey.currentState?.widget;
      _checkRoute();
    });
  }

  void _checkRoute() {
    final nav = widget.navigatorKey.currentState;
    if (nav == null) return;
    // Nếu không pop được thì đang ở root (home)
    final canPop = nav.canPop();
    if (_isHomeRoute != !canPop) {
      setState(() => _isHomeRoute = !canPop);
    }
  }

  @override
  void didUpdateWidget(covariant _HoverBottomNavOverlay oldWidget) {
    super.didUpdateWidget(oldWidget);
    // Check route mỗi khi child rebuild (route change)
    WidgetsBinding.instance.addPostFrameCallback((_) => _checkRoute());
  }

  @override
  void dispose() {
    _hideTimer?.cancel();
    _controller.dispose();
    super.dispose();
  }

  void _show() {
    if (_isHomeRoute) return; // Trang chủ đã có taskbar riêng
    _hideTimer?.cancel();
    if (!_isVisible) {
      setState(() => _isVisible = true);
      _controller.forward();
    }
  }

  void _hide() {
    if (_isHomeRoute) return;
    _hideTimer?.cancel();
    _hideTimer = Timer(const Duration(milliseconds: 300), () {
      if (mounted && _isVisible) {
        setState(() => _isVisible = false);
        _controller.reverse();
      }
    });
  }

  void _onNavTap(int index) {
    // Chỉ icon 0 (Trang chủ) hoạt động, các tab khác chưa liên kết
    if (index != 0) return;
    final nav = widget.navigatorKey.currentState;
    if (nav == null) return;
    if (nav.canPop()) {
      nav.popUntil((route) => route.isFirst);
    }
  }

  @override
  Widget build(BuildContext context) {
    // Trang chủ: không hiện overlay (có taskbar riêng)
    if (_isHomeRoute) {
      return NotificationListener<ScrollNotification>(
        onNotification: (_) {
          WidgetsBinding.instance.addPostFrameCallback((_) => _checkRoute());
          return false;
        },
        child: widget.child,
      );
    }

    return NotificationListener<ScrollNotification>(
      onNotification: (notification) {
        // Kiểm tra route mỗi khi scroll
        WidgetsBinding.instance.addPostFrameCallback((_) => _checkRoute());

        if (notification is ScrollUpdateNotification) {
          final delta = notification.scrollDelta ?? 0;
          if (delta < -2) {
            // Lướt xuống (ngón tay kéo xuống = scroll offset giảm) → hiện taskbar
            _show();
          } else if (delta > 2) {
            // Lướt lên (ngón tay kéo lên = scroll offset tăng) → ẩn taskbar
            _hide();
          }
        }
        return false;
      },
      child: Stack(
        children: [
          widget.child,

          // Vùng trigger hover ở đáy màn hình (luôn hiện, trong suốt)
          Positioned(
            left: 0,
            right: 0,
            bottom: 0,
            child: GestureDetector(
              behavior: HitTestBehavior.translucent,
              onTap: () {
                if (_isVisible) {
                  _hideTimer?.cancel();
                  setState(() => _isVisible = false);
                  _controller.reverse();
                } else {
                  _show();
                }
              },
              child: MouseRegion(
                onEnter: (_) => _show(),
                onExit: (_) => _hide(),
                opaque: false,
                child: const SizedBox(height: 40),
              ),
            ),
          ),

          // Thanh taskbar (animated slide up/down)
          Positioned(
            left: 0,
            right: 0,
            bottom: 0,
            child: IgnorePointer(
              ignoring: !_isVisible,
              child: MouseRegion(
                onEnter: (_) => _show(),
                onExit: (_) => _hide(),
                child: SlideTransition(
                  position: _slideAnimation,
                  child: SafeArea(
                    top: false,
                    child: Padding(
                      padding: const EdgeInsets.only(
                        left: 24,
                        right: 24,
                        bottom: 16,
                      ),
                      child: _buildNavBar(),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildNavBar() {
    const icons = [
      Icons.dashboard_rounded,
      Icons.map_rounded,
      Icons.notifications_rounded,
      Icons.person_rounded,
    ];

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
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
        children: List.generate(icons.length, (index) {
          return GestureDetector(
            onTap: () => _onNavTap(index),
            behavior: HitTestBehavior.opaque,
            child: Container(
              width: 52,
              height: 52,
              decoration: const ShapeDecoration(
                color: Colors.transparent,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(9999)),
                ),
              ),
              child: Center(
                child: Icon(
                  icons[index],
                  size: 24,
                  color: const Color(0xFF9CA3AF),
                ),
              ),
            ),
          );
        }),
      ),
    );
  }
}

import 'package:flutter/material.dart';

/// ============================================================
/// RESPONSIVE HELPER — Utility class cho responsive design
///
/// Base design = 402px wide (Figma frame của project này)
/// Supports: Mobile Portrait (320–480px) chính, Tablet side
/// ============================================================
class ResponsiveHelper {
  ResponsiveHelper._();

  // ─── Base design dimensions (Figma frame size) ────────────
  static const double _baseWidth  = 402.0;
  static const double _baseHeight = 874.0;

  // ─── Screen dimensions ────────────────────────────────────
  static double screenWidth(BuildContext context) =>
      MediaQuery.sizeOf(context).width;
  static double screenHeight(BuildContext context) =>
      MediaQuery.sizeOf(context).height;

  // ─── Breakpoints ──────────────────────────────────────────
  static bool isMobile(BuildContext context) =>
      screenWidth(context) < 600;
  static bool isTablet(BuildContext context) =>
      screenWidth(context) >= 600 && screenWidth(context) < 1200;
  static bool isDesktop(BuildContext context) =>
      screenWidth(context) >= 1200;

  /// Màn hình nhỏ (iPhone SE, 320–360px)
  static bool isSmallPhone(BuildContext context) =>
      screenWidth(context) <= 360;

  /// Màn hình lớn (iPhone 16 Pro Max, >414px)
  static bool isLargePhone(BuildContext context) =>
      screenWidth(context) > 414 && screenWidth(context) < 600;

  // ─── Fluid font scaling ───────────────────────────────────
  /// Scale font proportionally từ Figma (base 402px)
  /// Clamp để tránh quá nhỏ trên iPhone SE hoặc quá lớn trên tablet
  static double sp(BuildContext context, double size) {
    final scale = screenWidth(context) / _baseWidth;
    return (size * scale).clamp(size * 0.80, size * 1.30);
  }

  // ─── Width / Height percentages ───────────────────────────
  /// % của screen width
  static double wp(BuildContext context, double percent) =>
      screenWidth(context) * percent / 100;

  /// % của screen height
  static double hp(BuildContext context, double percent) =>
      screenHeight(context) * percent / 100;

  // ─── Adaptive padding ─────────────────────────────────────
  static EdgeInsets pagePadding(BuildContext context) {
    if (isDesktop(context)) {
      return const EdgeInsets.symmetric(horizontal: 240, vertical: 24);
    }
    if (isTablet(context)) {
      return const EdgeInsets.symmetric(horizontal: 48, vertical: 20);
    }
    if (isSmallPhone(context)) {
      return const EdgeInsets.symmetric(horizontal: 12, vertical: 12);
    }
    return const EdgeInsets.symmetric(horizontal: 16, vertical: 16);
  }

  static EdgeInsets cardPadding(BuildContext context) {
    if (isSmallPhone(context)) return const EdgeInsets.all(12);
    if (isTablet(context))     return const EdgeInsets.all(24);
    return const EdgeInsets.all(16);
  }

  static double horizontalPadding(BuildContext context) {
    if (isDesktop(context)) return 240;
    if (isTablet(context))  return 48;
    if (isSmallPhone(context)) return 12;
    return 16;
  }

  // ─── Adaptive grid columns ────────────────────────────────
  static int gridColumns(BuildContext context) {
    if (isDesktop(context)) return 4;
    if (isTablet(context))  return 3;
    return 2;
  }

  // ─── Adaptive border radius ───────────────────────────────
  static double radius(BuildContext context, double base) {
    if (isTablet(context) || isDesktop(context)) return base * 1.2;
    return base;
  }

  // ─── Adaptive icon size ───────────────────────────────────
  static double iconSize(BuildContext context, double base) =>
      sp(context, base);

  // ─── Minimum tap target (accessibility) ──────────────────
  static const double minTapTarget = 48.0;

  // ─── Bottom nav height ────────────────────────────────────
  static double bottomNavHeight(BuildContext context) {
    final bottomPadding = MediaQuery.of(context).padding.bottom;
    if (isTablet(context)) return 72 + bottomPadding;
    return 60 + bottomPadding;
  }

  // ─── Content max width (centering on tablet/desktop) ──────
  static double contentMaxWidth(BuildContext context) {
    if (isDesktop(context)) return 800;
    if (isTablet(context))  return 600;
    return double.infinity;
  }
}

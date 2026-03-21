import 'package:flutter/material.dart';

/// Screen size utilities - Hỗ trợ responsive theo Figma breakpoints
class ScreenUtils {
  static double width(BuildContext context) =>
      MediaQuery.of(context).size.width;

  static double height(BuildContext context) =>
      MediaQuery.of(context).size.height;

  static double statusBarHeight(BuildContext context) =>
      MediaQuery.of(context).padding.top;

  static double bottomBarHeight(BuildContext context) =>
      MediaQuery.of(context).padding.bottom;

  /// Kiểm tra breakpoints (dựa trên Figma frame sizes)
  static bool isMobile(BuildContext context) => width(context) < 600;
  static bool isTablet(BuildContext context) =>
      width(context) >= 600 && width(context) < 1024;
  static bool isDesktop(BuildContext context) => width(context) >= 1024;

  /// Scale factor - Dùng để scale UI từ Figma design width
  /// Mặc định Figma mobile design width = 375
  static double scaleFactor(BuildContext context,
      {double designWidth = 375}) {
    return width(context) / designWidth;
  }

  /// Scale size theo design width từ Figma
  static double scaleSize(BuildContext context, double size,
      {double designWidth = 375}) {
    return size * scaleFactor(context, designWidth: designWidth);
  }
}

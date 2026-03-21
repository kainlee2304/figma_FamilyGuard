// Figma to Flutter conversion helpers
//
// Figma Dev Mode thường cho ra các giá trị cần convert:
// - Color: #RRGGBB hoặc rgba() → Color(0xAARRGGBB)
// - Font weight: Regular=400, Medium=500, SemiBold=600, Bold=700
// - Spacing: px values → double
// - Border radius: px values → BorderRadius.circular()
// - Box shadow: figma shadow → BoxShadow()

import 'package:flutter/material.dart';

class FigmaUtils {
  FigmaUtils._();

  /// Convert Figma hex color (#RRGGBB) to Flutter Color
  /// Ví dụ: hexToColor('#6366F1') → Color(0xFF6366F1)
  static Color hexToColor(String hex) {
    hex = hex.replaceFirst('#', '');
    if (hex.length == 6) {
      hex = 'FF$hex';
    }
    return Color(int.parse(hex, radix: 16));
  }

  /// Convert Figma opacity (0-100) to Flutter opacity (0.0-1.0)
  static double opacityToDouble(int opacity) {
    return opacity / 100.0;
  }

  /// Convert Figma shadow to Flutter BoxShadow
  /// Figma: x, y, blur, spread, color, opacity
  static BoxShadow figmaShadow({
    double x = 0,
    double y = 0,
    double blur = 0,
    double spread = 0,
    Color color = Colors.black,
    double opacity = 0.1,
  }) {
    return BoxShadow(
      offset: Offset(x, y),
      blurRadius: blur,
      spreadRadius: spread,
      color: color.withValues(alpha: opacity),
    );
  }

  /// Convert Figma line-height to Flutter height
  /// Figma: lineHeight in px, fontSize in px
  /// Flutter: height = lineHeight / fontSize
  static double lineHeight(double lineHeightPx, double fontSizePx) {
    return lineHeightPx / fontSizePx;
  }

  /// Convert Figma letter-spacing (%) to Flutter letterSpacing
  /// Figma: letterSpacing as percentage or px
  static double letterSpacing(double fontSizePx, double percentOrPx,
      {bool isPercent = false}) {
    if (isPercent) {
      return fontSizePx * percentOrPx / 100;
    }
    return percentOrPx;
  }
}

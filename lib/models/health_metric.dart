import 'package:flutter/material.dart';

/// Model cho chỉ số sức khỏe
class HealthMetric {
  final String label;
  final String value;
  final String? unit;
  final IconData icon;
  final Color iconColor;

  const HealthMetric({
    required this.label,
    required this.value,
    this.unit,
    required this.icon,
    required this.iconColor,
  });
}

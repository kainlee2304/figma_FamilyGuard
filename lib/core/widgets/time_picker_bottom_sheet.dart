import 'package:flutter/material.dart';
import 'package:figma_app/core/theme/app_colors.dart';
import 'package:figma_app/core/theme/app_text_styles.dart';
import 'package:figma_app/core/theme/app_dimens.dart';

/// Custom Time Picker Bottom Sheet - Dựa trên Figma frame "Chọn thời gian"
/// Hiển thị 3 scroll wheels: Giờ, Phút, AM/PM
/// Trả về TimeOfDay khi người dùng xác nhận
class TimePickerBottomSheet extends StatefulWidget {
  final TimeOfDay initialTime;

  const TimePickerBottomSheet({
    super.key,
    required this.initialTime,
  });

  /// Hiển thị bottom sheet và trả về TimeOfDay đã chọn (hoặc null nếu hủy)
  static Future<TimeOfDay?> show(
    BuildContext context, {
    required TimeOfDay initialTime,
  }) {
    return showModalBottomSheet<TimeOfDay>(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (_) => TimePickerBottomSheet(initialTime: initialTime),
    );
  }

  @override
  State<TimePickerBottomSheet> createState() => _TimePickerBottomSheetState();
}

class _TimePickerBottomSheetState extends State<TimePickerBottomSheet> {
  late FixedExtentScrollController _hourController;
  late FixedExtentScrollController _minuteController;
  late FixedExtentScrollController _periodController;

  late int _selectedHour; // 1-12
  late int _selectedMinute; // 0-59
  late int _selectedPeriod; // 0=AM, 1=PM

  // Kích thước mỗi item trong wheel
  static const double _itemExtent = 44.0;

  @override
  void initState() {
    super.initState();
    // Chuyển từ 24h → 12h AM/PM
    final h24 = widget.initialTime.hour;
    _selectedPeriod = h24 >= 12 ? 1 : 0;
    _selectedHour = h24 % 12 == 0 ? 12 : h24 % 12;
    _selectedMinute = widget.initialTime.minute;

    _hourController = FixedExtentScrollController(initialItem: _selectedHour - 1);
    _minuteController = FixedExtentScrollController(initialItem: _selectedMinute);
    _periodController = FixedExtentScrollController(initialItem: _selectedPeriod);
  }

  @override
  void dispose() {
    _hourController.dispose();
    _minuteController.dispose();
    _periodController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: AppColors.primaryLight,
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(AppDimens.radiusRound),
        ),
      ),
      child: SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Handle bar
            Padding(
              padding: const EdgeInsets.only(top: 12, bottom: 8),
              child: Container(
                width: 48,
                height: 6,
                decoration: BoxDecoration(
                  color: AppColors.handleBar,
                  borderRadius: BorderRadius.circular(AppDimens.radiusCircle),
                ),
              ),
            ),

            // Title
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: AppDimens.spacing24,
                vertical: AppDimens.spacing16,
              ),
              child: Text(
                'Chọn thời gian',
                style: AppTextStyles.h3.copyWith(
                  color: AppColors.primary,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),

            // Scroll wheels
            SizedBox(
              height: 240,
              child: Stack(
                children: [
                  // Selection highlight band
                  Center(
                    child: Container(
                      height: 56,
                      margin: const EdgeInsets.symmetric(
                        horizontal: AppDimens.spacing24,
                      ),
                      decoration: BoxDecoration(
                        color: AppColors.primaryLight,
                        borderRadius: AppDimens.borderRadiusXLarge,
                        border: Border.all(
                          color: AppColors.primary,
                        ),
                      ),
                    ),
                  ),

                  // Wheels row
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: AppDimens.spacing40,
                    ),
                    child: Row(
                      children: [
                        // Hour wheel (1–12)
                        Expanded(
                          child: _buildWheel(
                            controller: _hourController,
                            itemCount: 12,
                            labelBuilder: (i) =>
                                (i + 1).toString().padLeft(2, '0'),
                            onChanged: (i) =>
                                setState(() => _selectedHour = i + 1),
                            selectedIndex: _selectedHour - 1,
                          ),
                        ),

                        // Minute wheel (0–59)
                        Expanded(
                          child: _buildWheel(
                            controller: _minuteController,
                            itemCount: 60,
                            labelBuilder: (i) => i.toString().padLeft(2, '0'),
                            onChanged: (i) =>
                                setState(() => _selectedMinute = i),
                            selectedIndex: _selectedMinute,
                          ),
                        ),

                        // AM/PM wheel
                        Expanded(
                          child: _buildWheel(
                            controller: _periodController,
                            itemCount: 2,
                            labelBuilder: (i) => i == 0 ? 'AM' : 'PM',
                            onChanged: (i) =>
                                setState(() => _selectedPeriod = i),
                            selectedIndex: _selectedPeriod,
                          ),
                        ),
                      ],
                    ),
                  ),

                  // Top fade gradient
                  Positioned(
                    top: 0,
                    left: 0,
                    right: 0,
                    height: 80,
                    child: IgnorePointer(
                      child: Container(
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter,
                            colors: [
                              AppColors.surface,
                              AppColors.surface.withValues(alpha: 0),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),

                  // Bottom fade gradient
                  Positioned(
                    bottom: 0,
                    left: 0,
                    right: 0,
                    height: 80,
                    child: IgnorePointer(
                      child: Container(
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            begin: Alignment.bottomCenter,
                            end: Alignment.topCenter,
                            colors: [
                              AppColors.surface,
                              AppColors.surface.withValues(alpha: 0),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),

            // Buttons
            Padding(
              padding: const EdgeInsets.fromLTRB(
                AppDimens.spacing24,
                AppDimens.spacing16,
                AppDimens.spacing24,
                AppDimens.spacing40,
              ),
              child: Column(
                children: [
                  // Xác nhận button
                  SizedBox(
                    width: double.infinity,
                    height: AppDimens.buttonHeightXLarge,
                    child: ElevatedButton(
                      onPressed: _onConfirm,
                      child: const Text('Xác nhận'),
                    ),
                  ),
                  const SizedBox(height: AppDimens.spacing12),
                  // Hủy bỏ text button
                  TextButton(
                    onPressed: () => Navigator.pop(context),
                    child: Text(
                      'Hủy bỏ',
                      style: AppTextStyles.bodyMedium.copyWith(
                        color: AppColors.textHint,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  /// Build a single scroll wheel column
  Widget _buildWheel({
    required FixedExtentScrollController controller,
    required int itemCount,
    required String Function(int) labelBuilder,
    required ValueChanged<int> onChanged,
    required int selectedIndex,
  }) {
    return ListWheelScrollView.useDelegate(
      controller: controller,
      itemExtent: _itemExtent,
      physics: const FixedExtentScrollPhysics(),
      perspective: 0.005,
      diameterRatio: 1.5,
      onSelectedItemChanged: onChanged,
      childDelegate: ListWheelChildBuilderDelegate(
        childCount: itemCount,
        builder: (context, index) {
          final isSelected = index == selectedIndex;
          // Distance from selected — for opacity gradient
          final distance = (index - selectedIndex).abs();
          final isFar = distance >= 2;

          return Center(
            child: Text(
              labelBuilder(index),
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: isSelected ? 24 : (isFar ? 18 : 20),
                fontWeight: isSelected ? FontWeight.w700 : FontWeight.w400,
                color: isSelected
                    ? AppColors.primary
                    : (isFar ? AppColors.handleBar : AppColors.textHint),
              ),
            ),
          );
        },
      ),
    );
  }

  void _onConfirm() {
    // Chuyển lại sang 24h
    int hour24 = _selectedHour % 12;
    if (_selectedPeriod == 1) hour24 += 12;
    final result = TimeOfDay(hour: hour24, minute: _selectedMinute);
    Navigator.pop(context, result);
  }
}


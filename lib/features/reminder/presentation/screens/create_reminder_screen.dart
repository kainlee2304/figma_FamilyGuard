import 'package:flutter/material.dart';
import 'package:figma_app/core/theme/app_colors.dart';
import 'package:figma_app/core/theme/app_text_styles.dart';
import 'package:figma_app/core/theme/app_dimens.dart';
import 'package:figma_app/core/theme/app_shadows.dart';
import 'package:figma_app/core/utils/responsive/responsive_helper.dart';
import 'package:figma_app/features/reminder/domain/entities/reminder_type.dart';
import 'package:figma_app/core/widgets/gradient_background.dart';
import 'package:figma_app/core/widgets/time_picker_bottom_sheet.dart';
import 'package:figma_app/core/routes/app_routes.dart';
import 'package:figma_app/core/widgets/app_header.dart';

/// Screen 3: Tạo lịch nhắc mới (Create New Reminder)
/// Cho phép người dùng tạo lịch nhắc nhở mới với:
/// - Chọn loại nhắc nhở (Thuốc, Ăn uống, Sức khỏe, Khác)
/// - Nhập tiêu đề
/// - Chọn thời gian
/// - Chọn tần suất lặp lại
/// - Ghi âm giọng nói
class CreateReminderScreen extends StatefulWidget {
  const CreateReminderScreen({super.key});

  @override
  State<CreateReminderScreen> createState() => _CreateReminderScreenState();
}

class _CreateReminderScreenState extends State<CreateReminderScreen> {
  // Danh sách loại nhắc nhở
  static const List<ReminderType> _reminderTypes = [
    ReminderType(
      id: 'medicine',
      label: 'Thuốc',
      icon: Icons.medication_outlined,
      iconColor: Color(0xFFE84C6F),
      backgroundColor: AppColors.reminderPink,
    ),
    ReminderType(
      id: 'food',
      label: 'Ăn uống',
      icon: Icons.restaurant_outlined,
      iconColor: Color(0xFFF5A623),
      backgroundColor: AppColors.reminderYellow,
    ),
    ReminderType(
      id: 'health',
      label: 'Sức khỏe',
      icon: Icons.favorite_outline,
      iconColor: Color(0xFF42A5F5),
      backgroundColor: AppColors.reminderBlue,
    ),
    ReminderType(
      id: 'other',
      label: 'Khác',
      icon: Icons.grid_view_rounded,
      iconColor: AppColors.primary,
      backgroundColor: AppColors.iconBgTeal,
    ),
  ];

  String _selectedTypeId = 'other';
  final TextEditingController _titleController = TextEditingController();
  TimeOfDay _selectedTime = const TimeOfDay(hour: 8, minute: 0);
  String _selectedRepeat = 'Mỗi ngày';

  @override
  void dispose() {
    _titleController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: GradientBackground(
        child: SafeArea(
          child: Column(
            children: [
              // Header
              const AppHeader(title: 'Tạo lịch nhắc mới'),

              // Scrollable content
              Expanded(
                child: SingleChildScrollView(
                  padding: EdgeInsets.symmetric(
                    horizontal: ResponsiveHelper.horizontalPadding(context),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(height: AppDimens.spacing16),

                      // Reminder type selector
                      _buildReminderTypeSection(),

                      const SizedBox(height: AppDimens.spacing24),

                      // Title input
                      _buildTitleInput(),

                      const SizedBox(height: AppDimens.spacing24),

                      // Time picker
                      _buildTimePicker(context),

                      const SizedBox(height: AppDimens.spacing24),

                      // Repeat selector
                      _buildRepeatSelector(),

                      const SizedBox(height: AppDimens.spacing24),

                      // Voice recording section
                      _buildVoiceRecordingSection(),

                      const SizedBox(height: AppDimens.spacing24),
                    ],
                  ),
                ),
              ),

              // Submit button - pinned to bottom
              Padding(
                padding: const EdgeInsets.fromLTRB(
                  AppDimens.spacing24, AppDimens.spacing12,
                  AppDimens.spacing24, AppDimens.spacing24,
                ),
                child: _buildSubmitButton(),
              ),
            ],
          ),
        ),
      ),
    );
  }


  /// Section: Chọn loại nhắc nhở (2x2 grid)
  Widget _buildReminderTypeSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Loại nhắc nhở',
          style: AppTextStyles.labelLarge.copyWith(
            color: AppColors.textDark,
          ),
        ),
        const SizedBox(height: AppDimens.spacing12),
        Row(
          children: _reminderTypes.map((type) {
            final isSelected = type.id == _selectedTypeId;
            return Expanded(
              child: Padding(
                padding: EdgeInsets.only(
                  right: type != _reminderTypes.last ? 12 : 0,
                ),
                child: _buildReminderTypeCard(type, isSelected),
              ),
            );
          }).toList(),
        ),
      ],
    );
  }

  /// Card cho từng loại nhắc nhở
  Widget _buildReminderTypeCard(ReminderType type, bool isSelected) {
    return GestureDetector(
      onTap: () => setState(() => _selectedTypeId = type.id),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        curve: Curves.easeInOut,
        decoration: BoxDecoration(
          color: isSelected ? AppColors.selectedCardBg : AppColors.surface,
          borderRadius: AppDimens.borderRadiusLarge,
          border: Border.all(
            color: isSelected ? AppColors.primary : AppColors.inputBorder,
            width: isSelected ? 1.5 : 1,
          ),
          boxShadow: isSelected ? AppShadows.small : null,
        ),
        padding: const EdgeInsets.symmetric(vertical: 14),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Icon circle
            Container(
              width: 48,
              height: 48,
              decoration: BoxDecoration(
                color: type.backgroundColor,
                shape: BoxShape.circle,
              ),
              child: Icon(
                type.icon,
                color: type.iconColor,
                size: 24,
              ),
            ),
            const SizedBox(height: AppDimens.spacing8),
            // Label
            Text(
              type.label,
              style: AppTextStyles.labelMedium.copyWith(
                color: isSelected ? AppColors.primaryDark : AppColors.textMuted,
                fontWeight: isSelected ? FontWeight.w600 : FontWeight.w500,
              ),
            ),
          ],
        ),
      ),
    );
  }

  /// Input: Tiêu đề nhắc nhở
  Widget _buildTitleInput() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Tiêu đề',
          style: AppTextStyles.labelLarge.copyWith(
            color: AppColors.textDark,
          ),
        ),
        const SizedBox(height: AppDimens.spacing8),
        Container(
          decoration: BoxDecoration(
            color: AppColors.inputBackground,
            borderRadius: AppDimens.borderRadiusLarge,
            border: Border.all(color: AppColors.inputBorder),
          ),
          child: TextField(
            controller: _titleController,
            style: AppTextStyles.bodyMedium.copyWith(
              color: AppColors.textDark,
            ),
            decoration: InputDecoration(
              hintText: 'Nhập tiêu đề nhắc nhở',
              hintStyle: AppTextStyles.bodyMedium.copyWith(
                color: AppColors.textHint,
              ),
              contentPadding: const EdgeInsets.symmetric(
                horizontal: AppDimens.spacing16,
                vertical: AppDimens.spacing14,
              ),
              border: InputBorder.none,
              enabledBorder: InputBorder.none,
              focusedBorder: InputBorder.none,
            ),
          ),
        ),
      ],
    );
  }

  /// Row: Chọn thời gian
  Widget _buildTimePicker(BuildContext context) {
    final timeStr =
        '${_selectedTime.hour.toString().padLeft(2, '0')}:${_selectedTime.minute.toString().padLeft(2, '0')}';
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Thời gian',
          style: AppTextStyles.labelLarge.copyWith(
            color: AppColors.textDark,
          ),
        ),
        const SizedBox(height: AppDimens.spacing8),
        GestureDetector(
          onTap: () => _pickTime(context),
          child: Container(
            padding: const EdgeInsets.symmetric(
              horizontal: AppDimens.spacing16,
              vertical: AppDimens.spacing14,
            ),
            decoration: BoxDecoration(
              color: AppColors.inputBackground,
              borderRadius: AppDimens.borderRadiusLarge,
              border: Border.all(color: AppColors.inputBorder),
            ),
            child: Row(
              children: [
                const Icon(
                  Icons.access_time_rounded,
                  size: AppDimens.iconMedium,
                  color: AppColors.primary,
                ),
                const SizedBox(width: AppDimens.spacing12),
                Text(
                  timeStr,
                  style: AppTextStyles.bodyLarge.copyWith(
                    color: AppColors.textDark,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const Spacer(),
                const Icon(
                  Icons.chevron_right_rounded,
                  size: AppDimens.iconMedium,
                  color: AppColors.textMuted,
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  /// Row: Chọn tần suất lặp lại
  Widget _buildRepeatSelector() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Lặp lại',
          style: AppTextStyles.labelLarge.copyWith(
            color: AppColors.textDark,
          ),
        ),
        const SizedBox(height: AppDimens.spacing8),
        GestureDetector(
          onTap: _showRepeatOptions,
          child: Container(
            padding: const EdgeInsets.symmetric(
              horizontal: AppDimens.spacing16,
              vertical: AppDimens.spacing14,
            ),
            decoration: BoxDecoration(
              color: AppColors.inputBackground,
              borderRadius: AppDimens.borderRadiusLarge,
              border: Border.all(color: AppColors.inputBorder),
            ),
            child: Row(
              children: [
                const Icon(
                  Icons.calendar_today_outlined,
                  size: AppDimens.iconMedium,
                  color: AppColors.primary,
                ),
                const SizedBox(width: AppDimens.spacing12),
                Text(
                  _selectedRepeat,
                  style: AppTextStyles.bodyLarge.copyWith(
                    color: AppColors.textDark,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const Spacer(),
                const Icon(
                  Icons.keyboard_arrow_down_rounded,
                  size: AppDimens.iconMedium,
                  color: AppColors.textMuted,
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
  /// Section: Ghi âm giọng nói
  Widget _buildVoiceRecordingSection() {
    return GestureDetector(
      onTap: () => Navigator.pushNamed(context, AppRoutes.voiceRecording),
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.symmetric(vertical: 24, horizontal: 20),
        decoration: BoxDecoration(
          color: AppColors.selectedCardBg,
          borderRadius: AppDimens.borderRadiusXLarge,
        ),
        child: Column(
          children: [
            // Mic button
            Container(
              width: 56,
              height: 56,
              decoration: BoxDecoration(
                color: AppColors.primary.withValues(alpha: 0.15),
                shape: BoxShape.circle,
              ),
              child: const Icon(
                Icons.mic_none_rounded,
                size: 28,
                color: AppColors.primary,
              ),
            ),
            const SizedBox(height: AppDimens.spacing12),
            // Description text
            Text(
              'Nhấn để ghi âm nhắc nhở bằng giọng nói',
              textAlign: TextAlign.center,
              style: AppTextStyles.bodySmall.copyWith(
                color: AppColors.textMuted,
              ),
            ),
          ],
        ),
      ),
    );
  }

  /// Button: Tạo lịch nhắc (primary, full-width)
  Widget _buildSubmitButton() {
    return SizedBox(
      width: double.infinity,
      height: AppDimens.buttonHeightXLarge,
      child: ElevatedButton(
        onPressed: _onSubmit,
        child: const Text('Tạo lịch nhắc'),
      ),
    );
  }

  // ── Actions ──
  Future<void> _pickTime(BuildContext context) async {
    final picked = await TimePickerBottomSheet.show(
      context,
      initialTime: _selectedTime,
    );
    if (picked != null) {
      setState(() => _selectedTime = picked);
    }
  }
  void _showRepeatOptions() {
    Navigator.pushNamed(context, AppRoutes.repeatFrequency).then((result) {
      if (result != null && result is Map) {
        setState(() {
          _selectedRepeat = result['mode'] as String? ?? _selectedRepeat;
        });
      }
    });
  }

  void _onSubmit() {
    final title = _titleController.text.trim();
    if (title.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Vui lòng nhập tiêu đề nhắc nhở'),
          backgroundColor: AppColors.error,
          behavior: SnackBarBehavior.floating,
          shape: RoundedRectangleBorder(
            borderRadius: AppDimens.borderRadiusMedium,
          ),
        ),
      );
      return;
    }

    // Hiện thông báo thành công
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: const Text('Đã tạo lịch nhắc thành công'),
        backgroundColor: AppColors.primary,
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(
          borderRadius: AppDimens.borderRadiusMedium,
        ),
      ),
    );
    // Điều hướng đến trang Chi tiết lịch nhắc
    Navigator.of(context).pushReplacementNamed(AppRoutes.reminderDetail);
  }
}


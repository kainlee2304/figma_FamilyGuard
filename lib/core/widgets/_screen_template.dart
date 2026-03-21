import 'package:flutter/material.dart';
import 'package:figma_app/core/theme/app_colors.dart';
import 'package:figma_app/core/widgets/common_widgets.dart';

/// ============================================================
/// SCREEN TEMPLATE - Dùng cho ứng dụng Quản lí sức khỏe
/// Sao chép file này và đổi tên để tạo screen mới từ Figma
/// ============================================================
///
/// HƯỚNG DẪN SỬ DỤNG:
/// 1. Copy file này → đổi tên (vd: medicine_reminder_screen.dart)
/// 2. Đổi tên class (vd: MedicineReminderScreen)
/// 3. Mở Figma Dev Mode → chọn frame/component
/// 4. Copy code Widget → gửi cho AI để refactor
/// 5. Hoặc tự paste vào phần body bên dưới
///
class ScreenTemplate extends StatefulWidget {
  const ScreenTemplate({super.key});

  @override
  State<ScreenTemplate> createState() => _ScreenTemplateState();
}

class _ScreenTemplateState extends State<ScreenTemplate> {
  int _currentNavIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GradientBackground(
        child: SafeArea(
          bottom: false,
          child: Column(
            children: [
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // === HEADER ===
                      _buildHeader(),

                      // =============================================
                      // PASTE FIGMA WIDGET CODE Ở ĐÂY
                      // =============================================

                      // Placeholder - xóa sau khi paste code Figma
                      const SizedBox(height: 120),
                      Center(
                        child: Column(
                          children: [
                            Icon(
                              Icons.design_services,
                              size: 64,
                              color: AppColors.primary.withValues(alpha: 0.3),
                            ),
                            const SizedBox(height: 16),
                            Text(
                              'Paste Figma code vào đây',
                              style: TextStyle(
                                color: AppColors.primaryDark.withValues(alpha: 0.5),
                                fontSize: 16,
                                fontFamily: 'Lexend',
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              // === Bottom Navigation ===
              AppBottomNav(
                currentIndex: _currentNavIndex,
                onTap: (index) => setState(() => _currentNavIndex = index),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Padding(
      padding: EdgeInsets.only(top: 16, left: 24, right: 24, bottom: 16),
      child: Row(
        children: [
          // Back button
          GestureDetector(
            onTap: () => Navigator.maybePop(context),
            child: Container(
              padding: EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: Colors.white,
                shape: BoxShape.circle,
                border: Border.all(color: AppColors.borderLight, width: 1),
                boxShadow: const [
                  BoxShadow(
                    color: Color(0x0C000000),
                    blurRadius: 2,
                    offset: Offset(0, 1),
                  ),
                ],
              ),
              child: const Icon(
                Icons.arrow_back,
                size: 20,
                color: AppColors.primaryDark,
              ),
            ),
          ),
          const SizedBox(width: 12),

          // Title - Thay đổi text này
          const Expanded(
            child: Text(
              'Tiêu đề màn hình',
              style: TextStyle(
                color: AppColors.primaryDark,
                fontSize: 20,
                fontFamily: 'Lexend',
                fontWeight: FontWeight.w700,
                height: 1.4,
                letterSpacing: -0.5,
              ),
            ),
          ),
        ],
      ),
    );
  }
}


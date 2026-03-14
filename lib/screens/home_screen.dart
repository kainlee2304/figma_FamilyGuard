import 'package:flutter/material.dart';
import '../core/responsive/responsive.dart';
import '../routes/app_routes.dart';
import '../theme/theme.dart';
import '../widgets/common/common_widgets.dart';

/// ============================================================
/// HOME SCREEN
/// Paste code Widget từ Figma Dev Mode vào đây
/// ============================================================
class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    final pagePad = ResponsiveHelper.pagePadding(context);
    final cols = ResponsiveHelper.gridColumns(context);
    final h2Size = ResponsiveHelper.sp(context, 24);
    final h3Size = ResponsiveHelper.sp(context, 20);
    final h4Size = ResponsiveHelper.sp(context, 18);
    final bodyMdSize = ResponsiveHelper.sp(context, 14);
    final bodySmSize = ResponsiveHelper.sp(context, 12);
    final labelLgSize = ResponsiveHelper.sp(context, 14);
    final iconContainerSz = ResponsiveHelper.sp(context, 28);

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        title: Text(
          'Figma App',
          style: TextStyle(fontSize: ResponsiveHelper.sp(context, 18)),
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.notifications_outlined,
                size: ResponsiveHelper.sp(context, 24)),
            onPressed: () {
              ScaffoldMessenger.of(context)
                ..hideCurrentSnackBar()
                ..showSnackBar(const SnackBar(
                  content: Text('Chưa có thông báo mới',
                      style: TextStyle(fontFamily: 'Lexend')),
                  behavior: SnackBarBehavior.floating,
                ));
            },
          ),
        ],
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: pagePad,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // === WELCOME SECTION ===
              Text(
                'Xin chào! 👋',
                style: AppTextStyles.h2.copyWith(
                  color: AppColors.textPrimary,
                  fontSize: h2Size,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                'Chào mừng bạn đến với ứng dụng',
                style: AppTextStyles.bodyMedium.copyWith(
                  color: AppColors.textSecondary,
                  fontSize: bodyMdSize,
                ),
              ),
              const SizedBox(height: 24),

              // === SEARCH BAR ===
              const AppTextField(
                hint: 'Tìm kiếm...',
                prefixIcon: Icon(Icons.search, color: AppColors.textHint),
              ),
              const SizedBox(height: 24),

              // === FEATURED CARD ===
              AppCard(
                backgroundColor: AppColors.primary,
                child: Row(
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Bắt đầu ngay',
                            style: AppTextStyles.h3.copyWith(
                              color: Colors.white,
                              fontSize: h3Size,
                            ),
                          ),
                          const SizedBox(height: 8),
                          Text(
                            'Paste code Widget từ Figma Dev Mode vào project này',
                            style: AppTextStyles.bodySmall.copyWith(
                              color: Colors.white.withValues(alpha: 0.8),
                              fontSize: bodySmSize,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(width: 16),
                    Container(
                      padding: EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: Colors.white.withValues(alpha: 0.2),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Icon(
                        Icons.arrow_forward,
                        color: Colors.white,
                        size: ResponsiveHelper.sp(context, 24),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 24),

              // === SECTION TITLE ===
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Danh mục',
                    style: AppTextStyles.h4.copyWith(
                      color: AppColors.textPrimary,
                      fontSize: h4Size,
                    ),
                  ),
                  TextButton(
                    onPressed: () {
                      Navigator.pushNamed(context, AppRoutes.reminderManagement);
                    },
                    child: Text('Xem tất cả'),
                  ),
                ],
              ),
              const SizedBox(height: 12),

              // === GRID ITEMS - adaptive column count ===
              GridView.count(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                crossAxisCount: cols,
                crossAxisSpacing: 12,
                mainAxisSpacing: 12,
                childAspectRatio: 1.1,
                children: List.generate(4, (index) {
                  final routes = [
                    AppRoutes.reminderManagement,
                    AppRoutes.physicalActivity,
                    AppRoutes.safeZoneManagement, // qua màn hình tổng quan vùng an toàn
                    AppRoutes.profile,
                  ];
                  return AppCard(
                    onTap: () {
                      Navigator.pushNamed(context, routes[index]);
                    },
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          padding: EdgeInsets.all(12),
                          decoration: BoxDecoration(
                            color: AppColors.primary.withValues(alpha: 0.1),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Icon(
                            [
                              Icons.notifications_active_rounded,
                              Icons.directions_run_rounded,
                              Icons.shield_rounded,
                              Icons.person_rounded,
                            ][index],
                            color: AppColors.primary,
                            size: iconContainerSz,
                          ),
                        ),
                        const SizedBox(height: 12),
                        Text(
                          ['Nhắc nhở', 'Hoạt động', 'Vùng an toàn', 'Cá nhân'][index],
                          style: AppTextStyles.labelLarge.copyWith(
                            color: AppColors.textPrimary,
                            fontSize: labelLgSize,
                          ),
                        ),
                      ],
                    ),
                  );
                }),
              ),
              const SizedBox(height: 24),

              // === BUTTONS DEMO ===
              AppButton(
                text: 'Quản lý nhắc nhở',
                onPressed: () {
                  Navigator.pushNamed(context, AppRoutes.reminderManagement);
                },
              ),
              const SizedBox(height: 12),
              AppButton(
                text: 'Hoạt động thể chất',
                isOutlined: true,
                onPressed: () {
                  Navigator.pushNamed(context, AppRoutes.physicalActivity);
                },
              ),
              const SizedBox(height: 32),
            ],
          ),
        ),
      ),

      // === BOTTOM NAVIGATION ===
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: 0,
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.home_outlined),
            activeIcon: Icon(Icons.home),
            label: 'Trang chủ',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.explore_outlined),
            activeIcon: Icon(Icons.explore),
            label: 'Khám phá',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.favorite_outline),
            activeIcon: Icon(Icons.favorite),
            label: 'Yêu thích',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person_outline),
            activeIcon: Icon(Icons.person),
            label: 'Cá nhân',
          ),
        ],
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:figma_app/core/utils/responsive/responsive.dart';
import 'package:figma_app/core/theme/app_colors.dart';
import 'package:figma_app/features/home/domain/entities/models.dart';
import 'package:figma_app/core/routes/app_routes.dart';
import 'package:figma_app/features/member/presentation/screens/member_detail_screen.dart';

/// ============================================================
/// MÀN HÌNH: Quản lí lịch nhắc (Tab 0 trong MainShellScreen)
/// Bottom nav được MainShellScreen quản lý — không cần ở đây
/// ============================================================
class ReminderManagementScreen extends StatefulWidget {
  const ReminderManagementScreen({super.key});

  @override
  State<ReminderManagementScreen> createState() =>
      _ReminderManagementScreenState();
}

class _ReminderManagementScreenState extends State<ReminderManagementScreen> {

  // === DATA ===
  final List<FamilyMember> _familyMembers = const [
    FamilyMember(
      name: 'Bà Lan',
      role: 'Người cao tuổi',
      imageUrl: 'https://i.pravatar.cc/150?img=47',
      isOnline: true,
    ),
    FamilyMember(
      name: 'Ông Hùng',
      role: 'Người cao tuổi',
      imageUrl: 'https://i.pravatar.cc/150?img=68',
      isOnline: true,
    ),
    FamilyMember(
      name: 'Anh Tuấn',
      role: 'Người chăm sóc',
      imageUrl: 'https://i.pravatar.cc/150?img=12',
      isOnline: false,
    ),
  ];

  final List<ReminderFeature> _features = const [
    ReminderFeature(
      title: 'Nhắc nhở\nuống thuốc',
      icon: Icons.medication_outlined,
      iconColor: Color(0xFF8B5CF6),
      iconBgColor: Color(0xFFF3ECFF),
    ),
    ReminderFeature(
      title: 'Lịch hẹn\nkhám bệnh',
      icon: Icons.calendar_month_outlined,
      iconColor: Color(0xFF14B8A6),
      iconBgColor: AppColors.iconBgTeal,
    ),
    ReminderFeature(
      title: 'Hoạt động\nthể chất',
      icon: Icons.directions_run_outlined,
      iconColor: Color(0xFFF59E0B),
      iconBgColor: AppColors.iconBgYellow,
    ),
    ReminderFeature(
      title: 'Theo dõi\nsức khỏe',
      icon: Icons.favorite_outline,
      iconColor: Color(0xFFEC4899),
      iconBgColor: AppColors.iconBgPink,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [AppColors.gradientStart, AppColors.gradientEnd],
          ),
        ),
        child: SafeArea(
          bottom: false,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildAppBar(),
              Expanded(
                child: SingleChildScrollView(
                  padding: const EdgeInsets.only(bottom: 32),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(height: 8),
                      _buildFamilySection(),
                      const SizedBox(height: 24),
                      _buildFeaturesSection(),
                      const SizedBox(height: 32),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  /// === APP BAR ===
  Widget _buildAppBar() {
    final hPad = ResponsiveHelper.horizontalPadding(context);
    final titleSz = ResponsiveHelper.sp(context, 20);
    final btnSz = ResponsiveHelper.sp(context, 13);
    final iconSz = ResponsiveHelper.sp(context, 22);
    return Padding(
      padding: EdgeInsets.only(top: 12, left: hPad, right: hPad, bottom: 8),
      child: Row(
        children: [
          // Back button
          GestureDetector(
            onTap: () => Navigator.of(context).pop(),
            child: Container(
              width: 40,
              height: 40,
              decoration: BoxDecoration(
                color: Colors.white,
                shape: BoxShape.circle,
                boxShadow: const [
                  BoxShadow(
                    color: Color(0x0C000000),
                    blurRadius: 4,
                    offset: Offset(0, 2),
                  ),
                ],
              ),
              child: const Icon(
                Icons.arrow_back_ios_new_rounded,
                size: 18,
                color: Color(0xFF00ACB2),
              ),
            ),
          ),
          const SizedBox(width: 12),

          // Title
          Expanded(
            child: Text(
              'Quản lí lịch nhắc',
              style: TextStyle(
                color: AppColors.primaryDark,
                fontSize: titleSz,
                fontFamily: 'Lexend',
                fontWeight: FontWeight.w700,
                height: 1.3,
              ),
            ),
          ),

          // Bell icon
          GestureDetector(
            onTap: () => Navigator.of(context).pushNamed(AppRoutes.notificationPreview),
            child: Container(
              width: 40,
              height: 40,
              decoration: BoxDecoration(
                color: Colors.white,
                shape: BoxShape.circle,
                border: Border.all(color: AppColors.borderLight, width: 1),
                boxShadow: const [
                  BoxShadow(
                    color: Color(0x0C000000),
                    blurRadius: 4,
                    offset: Offset(0, 2),
                  ),
                ],
              ),
              child: Icon(
                Icons.notifications_none_rounded,
                size: iconSz,
                color: AppColors.primaryDark,
              ),
            ),
          ),
          const SizedBox(width: 12),

          // "Xem tất cả" button
          ElevatedButton(
            onPressed: () => Navigator.of(context).pushNamed(AppRoutes.reminderList),
            style: ElevatedButton.styleFrom(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
            ),
            child: Text(
              'Xem tất cả',
              style: TextStyle(
                fontSize: btnSz,
              ),
            ),
          ),
        ],
      ),
    );
  }

  /// === SECTION: Thành viên gia đình ===
  Widget _buildFamilySection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Section title
        Padding(
          padding: EdgeInsets.symmetric(horizontal: ResponsiveHelper.horizontalPadding(context)),
          child: Text(
            'Thành viên gia đình',
            style: TextStyle(
              color: AppColors.primaryDark,
              fontSize: 18,
              fontFamily: 'Lexend',
              fontWeight: FontWeight.w700,
              height: 1.56,
            ),
          ),
        ),
        const SizedBox(height: 16),

        // Horizontal list
        SizedBox(
          height: 170,
          child: ListView.separated(
            scrollDirection: Axis.horizontal,
            clipBehavior: Clip.none,
            padding: EdgeInsets.symmetric(horizontal: ResponsiveHelper.horizontalPadding(context)),
            itemCount: _familyMembers.length + 1, // +1 for "Thêm mới" card
            separatorBuilder: (_, __) => const SizedBox(width: 12),
            itemBuilder: (context, index) {
              if (index < _familyMembers.length) {
                return _buildFamilyCard(_familyMembers[index]);
              }
              return _buildAddFamilyCard();
            },
          ),
        ),
      ],
    );
  }  /// Card thành viên gia đình
  Widget _buildFamilyCard(FamilyMember member) {
    final cardW = ResponsiveHelper.isTablet(context) ? 148.0 : 130.0;
    final avatarSz = ResponsiveHelper.sp(context, 60).clamp(48.0, 72.0);
    final nameSz = ResponsiveHelper.sp(context, 13);
    final roleSz = ResponsiveHelper.sp(context, 10);
    return GestureDetector(
      onTap: () {
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (_) => MemberDetailScreen(member: member),
          ),
        );
      },
      child: Container(
        width: cardW,
        padding: EdgeInsets.symmetric(vertical: 16, horizontal: 8),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: AppColors.borderPrimary, width: 1),
          boxShadow: const [
            BoxShadow(
              color: AppColors.shadowPrimary,
              blurRadius: 20,
              offset: Offset(0, 4),
              spreadRadius: -2,
            ),
          ],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Avatar with online indicator
            Stack(
              children: [
                Container(
                  width: avatarSz,
                  height: avatarSz,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(color: Colors.white, width: 2),
                    boxShadow: const [
                      BoxShadow(
                        color: Color(0x19000000),
                        blurRadius: 4,
                        offset: Offset(0, 2),
                        spreadRadius: -2,
                      ),
                      BoxShadow(
                        color: Color(0x19000000),
                        blurRadius: 6,
                        offset: Offset(0, 4),
                        spreadRadius: -1,
                      ),
                    ],
                    image: DecorationImage(
                      image: NetworkImage(member.imageUrl),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                // Online status dot
                Positioned(
                  right: 0,
                  bottom: 0,
                  child: Container(
                    width: 16,
                    height: 16,
                    decoration: BoxDecoration(
                      color: member.isOnline
                          ? AppColors.success
                          : const Color(0xFFD1D5DB),
                      shape: BoxShape.circle,
                      border: Border.all(color: Colors.white, width: 2),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),

            // Name
            Text(
              member.name,
              textAlign: TextAlign.center,
              style: TextStyle(
                color: AppColors.primaryDark,
                fontSize: nameSz,
                fontFamily: 'Lexend',
                fontWeight: FontWeight.w700,
                height: 1.43,
              ),
            ),
            const SizedBox(height: 2),

            // Role
            Text(
              member.role,
              textAlign: TextAlign.center,
              style: TextStyle(
                color: AppColors.primary,
                fontSize: roleSz,
                fontFamily: 'Lexend',
                fontWeight: FontWeight.w500,
                height: 1.5,
              ),
            ),
          ],
        ),
      ),
    );
  }

  /// Card "Thêm mới" thành viên
  Widget _buildAddFamilyCard() {
    final cardW = ResponsiveHelper.isTablet(context) ? 148.0 : 130.0;
    final addIconSz = ResponsiveHelper.sp(context, 24);
    final addLabelSz = ResponsiveHelper.sp(context, 10);
    return GestureDetector(
      onTap: () {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: const Text('Chức năng thêm thành viên đang phát triển'),
            backgroundColor: AppColors.primary,
            behavior: SnackBarBehavior.floating,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          ),
        );
      },
      child: Container(
        width: cardW,
        padding: EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: const Color(0x0C00ACB2),
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            color: const Color(0x4C00ACB2),
            width: 1,
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 40,
              height: 40,
              decoration: const BoxDecoration(
                color: Color(0x3300ACB2),
                shape: BoxShape.circle,
              ),
              child: Icon(
                Icons.add,
                color: AppColors.primary,
                size: addIconSz,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              'Thêm mới',
              textAlign: TextAlign.center,
              style: TextStyle(
                color: AppColors.primary,
                fontSize: addLabelSz,
                fontFamily: 'Lexend',
                fontWeight: FontWeight.w700,
                height: 1.5,
              ),
            ),
          ],
        ),
      ),
    );
  }

  /// === SECTION: Tính năng nhắc nhở ===
  Widget _buildFeaturesSection() {
    final hPad = ResponsiveHelper.horizontalPadding(context);
    final sectionTitleSz = ResponsiveHelper.sp(context, 18);
    final cols = ResponsiveHelper.gridColumns(context);
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: hPad),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Section title
          Text(
            'Tính năng nhắc nhở',
            style: TextStyle(
              color: AppColors.primaryDark,
              fontSize: sectionTitleSz,
              fontFamily: 'Lexend',
              fontWeight: FontWeight.w700,
              height: 1.56,
            ),
          ),
          const SizedBox(height: 16),

          // Adaptive columns grid
          GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: cols,
              crossAxisSpacing: 16,
              mainAxisSpacing: 16,
              childAspectRatio: 0.9,
            ),
            itemCount: _features.length,
            itemBuilder: (context, index) {
              return _buildFeatureCard(_features[index], index);
            },
          ),
        ],
      ),
    );
  }
  /// Feature card — navigate based on feature type
  Widget _buildFeatureCard(ReminderFeature feature, int index) {
    final iconContainerSz = ResponsiveHelper.sp(context, 56).clamp(44.0, 68.0);
    final iconSz = ResponsiveHelper.sp(context, 28);
    final titleSz = ResponsiveHelper.sp(context, 14);
    return GestureDetector(
      onTap: () {
        if (index == 0) {
          // Nhắc nhở uống thuốc → Lịch nhắc đã tạo
          Navigator.of(context).pushNamed(AppRoutes.reminderList);
        } else if (index == 3) {
          // Theo dõi sức khỏe → Báo cáo hoạt động
          Navigator.of(context).pushNamed(AppRoutes.activityReport);
        } else if (index == 1) {
          // Lịch hẹn khám bệnh
          Navigator.of(context).pushNamed(AppRoutes.medicalAppointment);
        } else if (index == 2) {
          // Hoạt động thể chất
          Navigator.of(context).pushNamed(AppRoutes.physicalActivity);
        }
      },
      child: Container(
        padding: EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          boxShadow: const [
            BoxShadow(
              color: Color(0x0F000000),
              blurRadius: 12,
              offset: Offset(0, 3),
              spreadRadius: -1,
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            // Icon circle
            Container(
              width: iconContainerSz,
              height: iconContainerSz,
              decoration: BoxDecoration(
                color: feature.iconBgColor,
                shape: BoxShape.circle,
              ),
              child: Icon(
                feature.icon,
                color: feature.iconColor,
                size: iconSz,
              ),
            ),
            const SizedBox(height: 16),

            // Title
            Text(
              feature.title,
              textAlign: TextAlign.center,
              style: TextStyle(
                color: AppColors.primaryDark,
                fontSize: titleSz,
                fontFamily: 'Lexend',
                fontWeight: FontWeight.w700,
                height: 1.25,
              ),
            ),
          ],
        ),
      ),
    );
  }

}


import 'package:flutter/material.dart';
import '../core/responsive/responsive.dart';
import '../models/family_member.dart';
import '../theme/app_colors.dart';
import '../routes/app_routes.dart';
import '../widgets/common/app_dialog.dart';

/// ============================================================
/// MÀN HÌNH: Danh sách thành viên — chọn thành viên để xem
/// tính năng nhắc nhở (uống thuốc, khám bệnh, thể chất, sức khỏe)
/// ============================================================
class MemberListScreen extends StatelessWidget {
  const MemberListScreen({super.key});

  static const List<FamilyMember> _members = [
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

  void _showFeaturePopup(BuildContext context, FamilyMember member) {
    final features = [
      _FeatureOption(
        icon: Icons.medication_outlined,
        label: 'Nhắc nhở uống thuốc',
        color: const Color(0xFF8B5CF6),
        bgColor: const Color(0xFFF3ECFF),
        route: AppRoutes.reminderList,
      ),
      _FeatureOption(
        icon: Icons.calendar_month_outlined,
        label: 'Lịch hẹn khám bệnh',
        color: const Color(0xFF14B8A6),
        bgColor: AppColors.kPrimaryLight,
        route: AppRoutes.medicalAppointment,
      ),
      _FeatureOption(
        icon: Icons.directions_run_outlined,
        label: 'Hoạt động thể chất',
        color: const Color(0xFFF59E0B),
        bgColor: const Color(0xFFFFF8E1),
        route: AppRoutes.physicalActivity,
      ),
      _FeatureOption(
        icon: Icons.favorite_outline,
        label: 'Theo dõi sức khỏe',
        color: const Color(0xFFEC4899),
        bgColor: const Color(0xFFFCE4EC),
        route: AppRoutes.activityReport,
      ),
    ];

    AppDialog.showCustom(
      context: context,
      title: 'Chọn tính năng cho ${member.name}',
      child: Builder(
        builder: (dialogCtx) => GridView.count(
          crossAxisCount: 2,
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          crossAxisSpacing: 12,
          mainAxisSpacing: 12,
          childAspectRatio: 1.2,
          children: features.map((f) => _buildFeatureTile(dialogCtx, f)).toList(),
        ),
      ),
    );
  }

  Widget _buildFeatureTile(BuildContext dialogCtx, _FeatureOption feature) {
    return GestureDetector(
      onTap: () {
        Navigator.pop(dialogCtx);
        Navigator.of(dialogCtx, rootNavigator: true).pushNamed(feature.route);
      },
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: const Color(0xFFE8E8E8), width: 1),
          boxShadow: const [
            BoxShadow(
              color: Color(0x0A000000),
              blurRadius: 8,
              offset: Offset(0, 2),
            ),
          ],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 48,
              height: 48,
              decoration: BoxDecoration(
                color: feature.bgColor,
                shape: BoxShape.circle,
              ),
              child: Icon(feature.icon, color: feature.color, size: 24),
            ),
            const SizedBox(height: 10),
            Text(
              feature.label,
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontFamily: 'Lexend',
                fontSize: 12,
                fontWeight: FontWeight.w600,
                color: Color(0xFF0C1D1A),
                height: 1.3,
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [AppColors.kPrimaryLight, AppColors.background],
          ),
        ),
        child: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // ── App Bar ──
              Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: ResponsiveHelper.horizontalPadding(context),
                  vertical: 12,
                ),
                child: Row(
                  children: [
                    GestureDetector(
                      onTap: () => Navigator.of(context).pop(),
                      child: Container(
                        width: 40,
                        height: 40,
                        decoration: const BoxDecoration(
                          color: Colors.white,
                          shape: BoxShape.circle,
                          boxShadow: [
                            BoxShadow(
                              color: Color(0x0C000000),
                              blurRadius: 2,
                              offset: Offset(0, 1),
                            ),
                          ],
                        ),
                        child: const Icon(
                          Icons.arrow_back_ios_new_rounded,
                          size: 18,
                          color: Color(0xFF00BD9D),
                        ),
                      ),
                    ),
                    const SizedBox(width: 12),
                    Text(
                      'Danh sách thành viên',
                      style: TextStyle(
                        fontFamily: 'Lexend',
                        fontSize: ResponsiveHelper.sp(context, 20),
                        fontWeight: FontWeight.w700,
                        color: const Color(0xFF006D5B),
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 8),

              // ── Member list ──
              Expanded(
                child: ListView.separated(
                  padding: EdgeInsets.symmetric(
                    horizontal: ResponsiveHelper.horizontalPadding(context),
                    vertical: 8,
                  ),
                  itemCount: _members.length,
                  separatorBuilder: (_, __) => const SizedBox(height: 12),
                  itemBuilder: (context, index) {
                    final member = _members[index];
                    return _buildMemberTile(context, member);
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildMemberTile(BuildContext context, FamilyMember member) {
    return GestureDetector(
      onTap: () => _showFeaturePopup(context, member),
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
          boxShadow: const [
            BoxShadow(
              color: Color(0x0F000000),
              blurRadius: 12,
              offset: Offset(0, 3),
              spreadRadius: -1,
            ),
          ],
        ),
        child: Row(
          children: [
            // Avatar with online dot
            Stack(
              children: [
                CircleAvatar(
                  radius: 28,
                  backgroundImage: NetworkImage(member.imageUrl),
                ),
                Positioned(
                  right: 0,
                  bottom: 0,
                  child: Container(
                    width: 14,
                    height: 14,
                    decoration: BoxDecoration(
                      color: member.isOnline
                          ? const Color(0xFF22C55E)
                          : const Color(0xFFD1D5DB),
                      shape: BoxShape.circle,
                      border: Border.all(color: Colors.white, width: 2),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(width: 16),
            // Name + role
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    member.name,
                    style: const TextStyle(
                      fontFamily: 'Lexend',
                      fontSize: 16,
                      fontWeight: FontWeight.w700,
                      color: Color(0xFF0C1D1A),
                    ),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    member.role,
                    style: const TextStyle(
                      fontFamily: 'Lexend',
                      fontSize: 13,
                      fontWeight: FontWeight.w500,
                      color: Color(0xFF00BD9D),
                    ),
                  ),
                ],
              ),
            ),
            // Chevron
            const Icon(
              Icons.chevron_right_rounded,
              color: Color(0xFFB0B0B0),
              size: 24,
            ),
          ],
        ),
      ),
    );
  }
}

class _FeatureOption {
  final IconData icon;
  final String label;
  final Color color;
  final Color bgColor;
  final String route;

  const _FeatureOption({
    required this.icon,
    required this.label,
    required this.color,
    required this.bgColor,
    required this.route,
  });
}

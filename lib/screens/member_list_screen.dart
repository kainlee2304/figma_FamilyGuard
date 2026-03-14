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
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => _MemberFeatureSheet(
        memberName: member.name,
        onFeatureSelected: (feature) {
          Navigator.pop(context);
          switch (feature) {
            case 'medicine':
              Navigator.of(context).pushNamed(AppRoutes.reminderList);
              break;
            case 'appointment':
              Navigator.of(context).pushNamed(AppRoutes.medicalAppointment);
              break;
            case 'activity':
              Navigator.of(context).pushNamed(AppRoutes.physicalActivity);
              break;
            case 'health':
              Navigator.of(context).pushNamed(AppRoutes.activityReport);
              break;
          }
        },
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
                          color: Color(0xFF00ACB2),
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
                      color: Color(0xFF00ACB2),
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

// Widget bottom sheet chọn tính năng
class _MemberFeatureSheet extends StatelessWidget {
  final String memberName;
  final Function(String) onFeatureSelected;
  const _MemberFeatureSheet({
    required this.memberName,
    required this.onFeatureSelected,
  });

  @override
  Widget build(BuildContext context) {
    final features = [
      {
        'label': 'Nhắc nhở\nuống thuốc',
        'icon': Icons.medication_outlined,
        'bgColor': const Color(0xFFEDE7F6),
        'iconColor': const Color(0xFF7E57C2),
        'key': 'medicine',
      },
      {
        'label': 'Lịch hẹn\nkhám bệnh',
        'icon': Icons.calendar_month_outlined,
        'bgColor': const Color(0xFFE8F8F7),
        'iconColor': const Color(0xFF00ACB2),
        'key': 'appointment',
      },
      {
        'label': 'Hoạt động\nthể chất',
        'icon': Icons.directions_run_rounded,
        'bgColor': const Color(0xFFFFF3E0),
        'iconColor': const Color(0xFFFFA000),
        'key': 'activity',
      },
      {
        'label': 'Theo dõi\nsức khỏe',
        'icon': Icons.favorite_outline_rounded,
        'bgColor': const Color(0xFFFCE4EC),
        'iconColor': const Color(0xFFE91E63),
        'key': 'health',
      },
    ];

    return SafeArea(
      child: Container(
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.vertical(top: Radius.circular(28)),
        ),
        padding: const EdgeInsets.fromLTRB(20, 8, 20, 16),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Handle
            Container(
              width: 36, height: 4,
              margin: const EdgeInsets.only(bottom: 20),
              decoration: BoxDecoration(
                color: const Color(0xFFDDE2E8),
                borderRadius: BorderRadius.circular(2)),
            ),
            // Title
            Text(
              'Chọn tính năng cho $memberName',
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w700,
                color: Color(0xFF00ACB2),
              ),
            ),
            const SizedBox(height: 20),
            // Grid 2x2
            Row(children: [
              Expanded(child: _card(context, features[0])),
              const SizedBox(width: 12),
              Expanded(child: _card(context, features[1])),
            ]),
            const SizedBox(height: 12),
            Row(children: [
              Expanded(child: _card(context, features[2])),
              const SizedBox(width: 12),
              Expanded(child: _card(context, features[3])),
            ]),
            const SizedBox(height: 16),
            // Nút Hủy
            GestureDetector(
              onTap: () => Navigator.pop(context),
              child: Container(
                width: double.infinity,
                padding: const EdgeInsets.symmetric(vertical: 12),
                decoration: BoxDecoration(
                  color: const Color(0xFFF5F5F5),
                  borderRadius: BorderRadius.circular(30),
                ),
                child: Text('Hủy',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.grey[600],
                    fontSize: 15,
                    fontWeight: FontWeight.w500,
                  )),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _card(BuildContext context, Map<String, dynamic> f) {
    return GestureDetector(
      onTap: () => onFeatureSelected(f['key'] as String),
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 20),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: const Color(0xFFEEF2F6), width: 1.5),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.04),
              blurRadius: 8,
              offset: const Offset(0, 2),
            )
          ],
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              padding: const EdgeInsets.all(14),
              decoration: BoxDecoration(
                color: f['bgColor'] as Color,
                shape: BoxShape.circle,
              ),
              child: Icon(f['icon'] as IconData,
                color: f['iconColor'] as Color,
                size: 26),
            ),
            const SizedBox(height: 10),
            Text(f['label'] as String,
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontSize: 13,
                fontWeight: FontWeight.w600,
                color: Color(0xFF1A1A1A),
                height: 1.4,
              )),
          ],
        ),
      ),
    );
  }
}

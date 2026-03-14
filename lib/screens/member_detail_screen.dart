import 'package:flutter/material.dart';
import '../theme/app_colors.dart';
import '../models/models.dart';
import '../routes/app_routes.dart';

/// ============================================================
/// MÀN HÌNH: Chi tiết thành viên
/// Chuyển đổi từ Figma Dev Mode → Flutter Clean Code
/// ============================================================
class MemberDetailScreen extends StatefulWidget {
  final FamilyMember? member;

  const MemberDetailScreen({super.key, this.member});

  @override
  State<MemberDetailScreen> createState() => _MemberDetailScreenState();
}

class _MemberDetailScreenState extends State<MemberDetailScreen> {

  // === DATA ===
  final List<HealthMetric> _healthMetrics = const [
    HealthMetric(
      label: 'NHỊP TIM',
      value: '75',
      unit: 'bpm',
      icon: Icons.favorite,
      iconColor: Color(0xFFEF4444),
    ),
    HealthMetric(
      label: 'HUYẾT ÁP',
      value: '120/80',
      icon: Icons.speed,
      iconColor: Color(0xFF3B82F6),
    ),
    HealthMetric(
      label: 'BƯỚC CHÂN',
      value: '3,500',
      icon: Icons.directions_walk,
      iconColor: Color(0xFFF59E0B),
    ),
  ];

  final List<QuickAction> _quickActions = const [
    QuickAction(
      title: 'Thiết lập vùng an toàn',
      subtitle: 'Thông báo khi rời khỏi khu vực',
      icon: Icons.shield_outlined,
    ),
    QuickAction(
      title: 'Quản lý lịch nhắc',
      subtitle: 'Thuốc uống, vận động, ăn uống',
      icon: Icons.notifications_outlined,
    ),
    QuickAction(
      title: 'Lịch sử di chuyển',
      subtitle: 'Xem lại lộ trình trong 24h qua',
      icon: Icons.route_outlined,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: Column(
        children: [
          // === Header (không có gradient) ===
          _buildHeader(),

          // === Content scrollable (có gradient) ===
          Expanded(
            child: Container(
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [AppColors.kPrimaryLight, AppColors.background],
                ),
              ),
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(height: 8),
                      _buildProfileCard(),
                      const SizedBox(height: 16),
                      _buildHealthSection(),
                      const SizedBox(height: 24),
                      _buildQuickActionsSection(),
                      const SizedBox(height: 24),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  /// === HEADER: Back + Title ===
  Widget _buildHeader() {
    return SafeArea(
      bottom: false,
      child: Container(
        padding: const EdgeInsets.all(16),
        child: Row(
          children: [
            // Back button
            GestureDetector(
              onTap: () => Navigator.of(context).maybePop(),
              child: Container(
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                  color: Colors.white,
                  shape: BoxShape.circle,
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
                  color: AppColors.textDark,
                ),
              ),
            ),

            // Title (centered)
            Expanded(
              child: Padding(
                padding: const EdgeInsets.only(right: 40), // offset for centering
                child: const Text(
                  'Chi tiết thành viên',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: AppColors.textDark,
                    fontSize: 18,
                    fontFamily: 'Lexend',
                    fontWeight: FontWeight.w700,
                    height: 1.56,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  /// === PROFILE CARD: Avatar + Name + Role + Status ===
  Widget _buildProfileCard() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(vertical: 25),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(24),
        border: Border.all(color: AppColors.borderLight, width: 1),
        boxShadow: const [
          BoxShadow(
            color: Color(0x0C000000),
            blurRadius: 2,
            offset: Offset(0, 1),
          ),
        ],
      ),
      child: Column(
        children: [
          // Avatar with border ring + online dot
          Stack(
            alignment: Alignment.center,
            children: [
              // Outer ring
              Container(
                width: 112,
                height: 112,
                padding: const EdgeInsets.all(4),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(
                    color: AppColors.borderPrimary,
                    width: 4,
                  ),
                ),
                child: Container(
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    image: DecorationImage(
                      image: NetworkImage(
                        widget.member?.imageUrl ??
                            'https://i.pravatar.cc/150?img=47',
                      ),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
              // Online indicator
              Positioned(
                right: 4,
                bottom: 4,
                child: Container(
                  width: 20,
                  height: 20,
                  decoration: BoxDecoration(
                    color: AppColors.success,
                    shape: BoxShape.circle,
                    border: Border.all(color: Colors.white, width: 2),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),

          // Name
          Text(
            widget.member?.name ?? 'Bà Lan',
            style: const TextStyle(
              color: AppColors.textDark,
              fontSize: 24,
              fontFamily: 'Lexend',
              fontWeight: FontWeight.w700,
              height: 1.33,
            ),
          ),
          const SizedBox(height: 4),

          // Role
          Text(
            widget.member?.role ?? 'Người cao tuổi',
            style: const TextStyle(
              color: AppColors.primary,
              fontSize: 16,
              fontFamily: 'Lexend',
              fontWeight: FontWeight.w500,
              height: 1.5,
            ),
          ),
          const SizedBox(height: 12),

          // Status badge
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
            decoration: BoxDecoration(
              color: const Color(0x1900ACB2),
              borderRadius: BorderRadius.circular(9999),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  width: 8,
                  height: 8,
                  decoration: const BoxDecoration(
                    color: AppColors.primary,
                    shape: BoxShape.circle,
                  ),
                ),
                const SizedBox(width: 8),
                const Text(
                  'Đang ở nhà',
                  style: TextStyle(
                    color: AppColors.primary,
                    fontSize: 14,
                    fontFamily: 'Lexend',
                    fontWeight: FontWeight.w400,
                    height: 1.43,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  /// === SECTION: Chỉ số sức khỏe ===
  Widget _buildHealthSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Section header with "Xem thêm"
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text(
              'Chỉ số sức khỏe',
              style: TextStyle(
                color: AppColors.textDark,
                fontSize: 18,
                fontFamily: 'Lexend',
                fontWeight: FontWeight.w700,
                height: 1.56,
              ),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pushNamed(AppRoutes.activityReport);
              },
              child: const Text(
                'Xem thêm',
                style: TextStyle(
                  color: AppColors.primary,
                  fontSize: 14,
                  fontFamily: 'Lexend',
                  fontWeight: FontWeight.w500,
                  height: 1.43,
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 16),

        // Health metric cards - 3 in a row
        Row(
          children: _healthMetrics.map((metric) {
            return Expanded(
              child: Padding(
                padding: EdgeInsets.only(
                  right: metric != _healthMetrics.last ? 12 : 0,
                ),
                child: _buildHealthMetricCard(metric),
              ),
            );
          }).toList(),
        ),
      ],
    );
  }

  /// Card chỉ số sức khỏe
  Widget _buildHealthMetricCard(HealthMetric metric) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: const Color(0x0C00ACB2), width: 1),
        boxShadow: const [
          BoxShadow(
            color: Color(0x0C000000),
            blurRadius: 2,
            offset: Offset(0, 1),
          ),
        ],
      ),
      child: Column(
        children: [
          // Icon
          Icon(metric.icon, size: 24, color: metric.iconColor),
          const SizedBox(height: 4),

          // Label
          Text(
            metric.label,
            textAlign: TextAlign.center,
            style: const TextStyle(
              color: AppColors.textMuted,
              fontSize: 10,
              fontFamily: 'Lexend',
              fontWeight: FontWeight.w400,
              height: 1.5,
              letterSpacing: 0.5,
            ),
          ),
          const SizedBox(height: 2),

          // Value + Unit
          if (metric.unit != null)
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.baseline,
              textBaseline: TextBaseline.alphabetic,
              children: [
                Text(
                  '${metric.value} ',
                  style: TextStyle(
                    color: AppColors.textDark,
                    fontSize: 18,
                    fontFamily: 'Lexend',
                    fontWeight: FontWeight.w700,
                    height: 1.56,
                  ),
                ),
                Text(
                  metric.unit!,
                  style: TextStyle(
                    color: AppColors.textDark,
                    fontSize: 10,
                    fontFamily: 'Lexend',
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ],
            )
          else
            Text(
              metric.value,
              textAlign: TextAlign.center,
              style: const TextStyle(
                color: AppColors.textDark,
                fontSize: 18,
                fontFamily: 'Lexend',
                fontWeight: FontWeight.w700,
                height: 1.56,
              ),
            ),
        ],
      ),
    );
  }

  /// === SECTION: Hành động nhanh ===
  Widget _buildQuickActionsSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Hành động nhanh',
          style: TextStyle(
            color: AppColors.textDark,
            fontSize: 18,
            fontFamily: 'Lexend',
            fontWeight: FontWeight.w700,
            height: 1.56,
          ),
        ),
        const SizedBox(height: 16),

        // Action items
        ...List.generate(_quickActions.length, (index) {
          return Padding(
            padding: EdgeInsets.only(
              bottom: index < _quickActions.length - 1 ? 12 : 0,
            ),
            child: _buildQuickActionCard(_quickActions[index]),
          );
        }),
      ],
    );
  }
  // ── Feature selection popup for "Quản lý lịch nhắc" ─────────
  void _showFeatureSelectionDialog() {
    final member = widget.member;
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (_) => Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
        ),
        padding: EdgeInsets.fromLTRB(20, 12, 20, MediaQuery.of(context).viewInsets.bottom + 24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Handle bar
            Container(
              width: 40, height: 4,
              decoration: BoxDecoration(
                color: Colors.grey[300],
                borderRadius: BorderRadius.circular(2),
              ),
            ),
            const SizedBox(height: 16),
            // Title
            Text(
              'Chọn tính năng cho ${member?.name ?? "thành viên"}',
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w700,
                color: Color(0xFF0C1D1A),
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 20),
            // Grid 2x2 responsive
            GridView.count(
              crossAxisCount: 2,
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              crossAxisSpacing: 12,
              mainAxisSpacing: 12,
              childAspectRatio: 1.3,
              children: [
                _featureCard(
                  context,
                  icon: Icons.medication_outlined,
                  label: 'Nhắc nhở\nuống thuốc',
                  bgColor: const Color(0xFFEDE7F6),
                  iconColor: const Color(0xFF7E57C2),
                  onTap: () {
                    Navigator.pop(context);
                    Navigator.of(context).pushNamed(AppRoutes.reminderList);
                  },
                ),
                _featureCard(
                  context,
                  icon: Icons.calendar_month_outlined,
                  label: 'Lịch hẹn\nkhám bệnh',
                  bgColor: const Color(0xFFE8F8F7),
                  iconColor: const Color(0xFF00ACB2),
                  onTap: () {
                    Navigator.pop(context);
                    Navigator.of(context).pushNamed(AppRoutes.medicalAppointment);
                  },
                ),
                _featureCard(
                  context,
                  icon: Icons.directions_run,
                  label: 'Hoạt động\nthể chất',
                  bgColor: const Color(0xFFFFF8E1),
                  iconColor: const Color(0xFFFFA000),
                  onTap: () {
                    Navigator.pop(context);
                    Navigator.of(context).pushNamed(AppRoutes.physicalActivity);
                  },
                ),
                _featureCard(
                  context,
                  icon: Icons.favorite_outline,
                  label: 'Theo dõi\nsức khỏe',
                  bgColor: const Color(0xFFFCE4EC),
                  iconColor: const Color(0xFFE91E63),
                  onTap: () {
                    Navigator.pop(context);
                    Navigator.of(context).pushNamed(AppRoutes.activityReport);
                  },
                ),
              ],
            ),
            const SizedBox(height: 12),
            // Nút Hủy
            SizedBox(
              width: double.infinity,
              child: TextButton(
                onPressed: () => Navigator.pop(context),
                child: const Text('Hủy', style: TextStyle(color: Colors.grey, fontSize: 15)),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Widget helper cho mỗi card tính năng:
  Widget _featureCard(
    BuildContext context, {
    required IconData icon,
    required String label,
    required Color bgColor,
    required Color iconColor,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: Colors.grey.shade200),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.05),
              blurRadius: 8,
              offset: const Offset(0, 2),
            )
          ],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: bgColor,
                shape: BoxShape.circle,
              ),
              child: Icon(icon, color: iconColor, size: 24),
            ),
            const SizedBox(height: 8),
            Text(
              label,
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontSize: 13,
                fontWeight: FontWeight.w500,
                color: Color(0xFF0C1D1A),
                height: 1.3,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildFeatureOption({
    required IconData icon,
    required String label,
    required Color iconColor,
    required Color bgColor,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: const Color(0xFFE5E7EB)),
          boxShadow: const [
            BoxShadow(
              color: Color(0x08000000),
              blurRadius: 4,
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
                color: bgColor,
                shape: BoxShape.circle,
              ),
              child: Icon(icon, color: iconColor, size: 24),
            ),
            const SizedBox(height: 8),
            Text(
              label,
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontFamily: 'Lexend',
                fontSize: 12,
                fontWeight: FontWeight.w600,
                color: AppColors.textDark,
                height: 1.3,
              ),
            ),
          ],
        ),
      ),
    );
  }

  /// Card hành động nhanh
  Widget _buildQuickActionCard(QuickAction action) {
    return GestureDetector(
      onTap: () {
        if (action.title == 'Quản lý lịch nhắc') {
          _showFeatureSelectionDialog();
        } else if (action.title == 'Thiết lập vùng an toàn') {
          Navigator.of(context).pushNamed(AppRoutes.safeZoneEmpty);
        } else if (action.title == 'Lịch sử di chuyển') {
          Navigator.of(context).pushNamed(AppRoutes.activityHistory);
        }
      },
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: const Color(0x0C00ACB2), width: 1),
          boxShadow: const [
            BoxShadow(
              color: Color(0x0C000000),
              blurRadius: 2,
              offset: Offset(0, 1),
            ),
          ],
        ),
        child: Row(
          children: [
            // Icon container
            Container(
              width: 48,
              height: 48,
              decoration: BoxDecoration(
                color: const Color(0x1900ACB2),
                borderRadius: BorderRadius.circular(16),
              ),
              child: Icon(
                action.icon,
                size: 24,
                color: AppColors.primary,
              ),
            ),
            const SizedBox(width: 16),

            // Text content
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    action.title,
                    style: const TextStyle(
                      color: AppColors.textDark,
                      fontSize: 16,
                      fontFamily: 'Lexend',
                      fontWeight: FontWeight.w700,
                      height: 1.5,
                    ),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    action.subtitle,
                    style: const TextStyle(
                      color: AppColors.textMuted,
                      fontSize: 12,
                      fontFamily: 'Lexend',
                      fontWeight: FontWeight.w400,
                      height: 1.33,
                    ),
                  ),
                ],
              ),
            ),

            // Chevron
            const Icon(
              Icons.chevron_right,
              size: 24,
              color: AppColors.navInactive,
            ),
          ],
        ),
      ),
    );
  }

  // Bottom nav removed — handled by MainShellScreen
}

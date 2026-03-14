import 'package:flutter/material.dart';
import '../core/responsive/responsive.dart';
import '../routes/app_routes.dart';
import '../theme/app_colors.dart';

/// ============================================================
/// ROLE 2 HOMEPAGE — Trang chủ người giám hộ
/// Responsive: mobile (320-480px), tablet, desktop
/// ============================================================
class Role2Homepage extends StatefulWidget {
  const Role2Homepage({super.key});

  @override
  State<Role2Homepage> createState() => _Role2HomepageState();
}

class _Role2HomepageState extends State<Role2Homepage> {
  final PageController _memberCardController = PageController(
    viewportFraction: 0.88,
    initialPage: 0,
  );
  int _currentMemberPage = 0;

  // Mock data — thành viên gia đình
  final List<_MemberData> _members = const [
    _MemberData(
      name: 'Mẹ',
      statusLabel: 'Đang ở nhà',
      statusColor: Color(0xFF008A8E),
      dotColor: Color(0xFF00ACB2),
      statusBg: Color(0xFFE0F7F7),
      batteryLevel: 85,
      batteryColor: Color(0xFF00ACB2),
      batteryIcon: Icons.battery_full,
      location: '123 Đường Nguyễn Huệ…',
      locationIcon: Icons.location_on,
      locationIconBg: Color(0x4C87E4DB),
      locationIconColor: Color(0xFF008A8E),
      isOnline: true,
      avatarUrl: 'https://i.pravatar.cc/150?img=47',
      indicatorColor: Color(0xFF22C55E),
      nameColor: Color(0xFF00ACB2),
    ),
    _MemberData(
      name: 'Bố',
      statusLabel: 'Đang đi dạo',
      statusColor: Color(0xFF374151),
      dotColor: Color(0xFFEAB308),
      statusBg: Color(0xFFFEF3C7),
      batteryLevel: 24,
      batteryColor: Color(0xFFCA8A04),
      batteryIcon: Icons.battery_alert,
      location: 'Công viên Tao Đàn',
      locationIcon: Icons.park,
      locationIconBg: Color(0xFFDBEAFE),
      locationIconColor: Color(0xFF2563EB),
      isOnline: false,
      avatarUrl: 'https://i.pravatar.cc/150?img=12',
      indicatorColor: Color(0xFFEAB308),
      nameColor: Color(0xFF111827),
    ),
  ];

  // Quick features
  static const _features = [
    _FeatureData(
      icon: Icons.people_alt_rounded,
      label: 'Thành viên',
      sub: 'Quản lí thành viên',
      iconBgColor: Color(0xFF17A8A5),
      route: null,
    ),
    _FeatureData(
      icon: Icons.mood_rounded,
      label: 'Tâm trạng',
      sub: 'Nhật ký hôm nay',
      iconBgColor: Color(0xFFFF8A3D),
      route: null, // coming soon
    ),
    _FeatureData(
      icon: Icons.shield_rounded,
      label: 'An toàn',
      sub: 'Thiết lập vùng',
      iconBgColor: Color(0xFFD94FD3),
      route: AppRoutes.safeZoneManagement,
    ),
    _FeatureData(
      icon: Icons.notifications_active_rounded,
      label: 'Lịch nhắc',
      sub: 'Nhắc nhở hằng ngày',
      iconBgColor: Color(0xFF4A90E2),
      route: AppRoutes.memberList,
    ),
  ];

  @override
  void dispose() {
    _memberCardController.dispose();
    super.dispose();
  }

  String _getGreeting() {
    final hour = DateTime.now().hour;
    if (hour < 12) return 'Chào buổi sáng,';
    if (hour < 18) return 'Chào buổi chiều,';
    return 'Chào buổi tối,';
  }

  @override
  Widget build(BuildContext context) {
    final h = ResponsiveHelper.screenHeight(context);
    final isSmall = ResponsiveHelper.isSmallPhone(context);
    final isTablet = ResponsiveHelper.isTablet(context);

    // Carousel card height: 26% of screen height, clamped
    final carouselHeight = (h * 0.26).clamp(190.0, 280.0);

    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        bottom: false,
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // ── Header ─────────────────────────────────
              _buildHeader(context),

              SizedBox(height: isSmall ? 14 : 20),

              // ── Member card carousel ────────────────────
              _buildMemberCarousel(context, carouselHeight),

              // ── Dot indicator ──────────────────────────
              const SizedBox(height: 12),
              _buildDotIndicator(),

              SizedBox(height: isSmall ? 14 : 20),

              // ── Quick features grid ────────────────────
              _buildFeaturesSection(context),

              // Bottom padding for navbar
              SizedBox(height: isTablet ? 140 : 120),
            ],
          ),
        ),
      ),
    );
  }

  // ─── Header ────────────────────────────────────────────────────────────────
  Widget _buildHeader(BuildContext context) {
    final hPad = ResponsiveHelper.horizontalPadding(context);
    final avatarSize = ResponsiveHelper.sp(context, 48).clamp(40.0, 64.0);
    final greetSize = ResponsiveHelper.sp(context, 24).clamp(18.0, 30.0);

    return Padding(
      padding: EdgeInsets.only(top: 8, left: hPad, right: hPad, bottom: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          // Greeting text
          Flexible(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '${_getGreeting()}\nHuy',
                  style: TextStyle(
                    color: const Color(0xFF00ACB2),
                    fontSize: greetSize,
                    fontFamily: 'Be Vietnam Pro',
                    fontWeight: FontWeight.w700,
                    height: 1.33,
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(width: 12),

          // User avatar
          Container(
            width: avatarSize,
            height: avatarSize,
            decoration: const ShapeDecoration(
              shape: RoundedRectangleBorder(
                side: BorderSide(width: 2, color: Colors.white),
                borderRadius: BorderRadius.all(Radius.circular(9999)),
              ),
              shadows: [
                BoxShadow(
                  color: Color(0x0C000000),
                  blurRadius: 2,
                  offset: Offset(0, 1),
                ),
              ],
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(9999),
              child: Image.network(
                'https://i.pravatar.cc/150?img=33',
                fit: BoxFit.cover,
                errorBuilder: (_, __, ___) => Container(
                  color: const Color(0xFF87E4DB),
                  child: Icon(Icons.person, color: Colors.white,
                      size: avatarSize * 0.55),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  // ─── Member card carousel ────────────────────────────────────────────────
  Widget _buildMemberCarousel(BuildContext context, double height) {
    return SizedBox(
      height: height,
      child: PageView.builder(
        controller: _memberCardController,
        itemCount: _members.length,
        onPageChanged: (i) => setState(() => _currentMemberPage = i),
        itemBuilder: (context, index) {
          return Padding(
            padding: EdgeInsets.only(
              left: index == 0 ? ResponsiveHelper.horizontalPadding(context) : 8,
              right: index == _members.length - 1
                  ? ResponsiveHelper.horizontalPadding(context)
                  : 8,
            ),
            child: _MemberCard(member: _members[index]),
          );
        },
      ),
    );
  }

  // ─── Dot indicator ────────────────────────────────────────────────────────
  Widget _buildDotIndicator() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(_members.length, (index) {
        final isActive = index == _currentMemberPage;
        return AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          margin: EdgeInsets.symmetric(horizontal: 4),
          width: isActive ? 20 : 8,
          height: 8,
          decoration: BoxDecoration(
            color: isActive
                ? const Color(0xFF00ACB2)
                : const Color(0xFF00ACB2).withValues(alpha: 0.3),
            borderRadius: BorderRadius.circular(9999),
          ),
        );
      }),
    );
  }

  // ─── Features section ────────────────────────────────────────────────────
  Widget _buildFeaturesSection(BuildContext context) {
    final hPad = ResponsiveHelper.horizontalPadding(context);
    final cols = ResponsiveHelper.gridColumns(context);
    // childAspectRatio responsive: tablet có nhiều space hơn
    final aspectRatio = ResponsiveHelper.isTablet(context) ? 1.8 : 1.15;
    final titleSize = ResponsiveHelper.sp(context, 18);
    final subTitleSize = ResponsiveHelper.sp(context, 14);

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: hPad),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Section header
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Tiện ích',
                style: TextStyle(
                  color: const Color(0xFF00ACB2),
                  fontSize: titleSize,
                  fontFamily: 'Public Sans',
                  fontWeight: FontWeight.w700,
                  height: 1.56,
                ),
              ),
              TextButton(
                onPressed: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Tính năng xem tất cả tiện ích sẽ được cập nhật')),
                  );
                },
                child: Text(
                  'Xem tất cả',
                  style: TextStyle(
                    color: const Color(0xFF00ACB2),
                    fontSize: subTitleSize,
                    fontFamily: 'Be Vietnam Pro',
                    fontWeight: FontWeight.w500,
                    height: 2,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),

          // Features grid
          GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: _features.length,
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: cols,
              crossAxisSpacing: 12,
              mainAxisSpacing: 12,
              childAspectRatio: aspectRatio,
            ),
            itemBuilder: (context, index) {
              return _FeatureCard(
                feature: _features[index],
                onTap: () {
                  final route = _features[index].route;
                  if (route != null) {
                    Navigator.of(context, rootNavigator: true).pushNamed(route);
                  }
                },
              );
            },
          ),
        ],
      ),
    );
  }
}

// ─── Member card widget ───────────────────────────────────────────────────
class _MemberCard extends StatelessWidget {
  const _MemberCard({required this.member});
  final _MemberData member;

  @override
  Widget build(BuildContext context) {
    final avatarSize = ResponsiveHelper.sp(context, 64).clamp(52.0, 76.0);
    final nameFontSize = ResponsiveHelper.sp(context, 20);
    final statusFontSize = ResponsiveHelper.sp(context, 14);
    final smallFontSize = ResponsiveHelper.sp(context, 12);
    final cardPad = ResponsiveHelper.isSmallPhone(context) ? 16.0 : 24.0;

    return Container(
      clipBehavior: Clip.antiAlias,
      decoration: ShapeDecoration(
        color: Colors.white.withValues(alpha: 0.10),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(24),
        ),
        shadows: const [
          BoxShadow(
            color: Color(0x2600ACB2),
            blurRadius: 40,
            offset: Offset(0, 10),
            spreadRadius: -10,
          ),
        ],
      ),
      child: Stack(
        children: [
          // Background image with gradient overlay
          Positioned.fill(
            child: Stack(
              children: [
                Positioned.fill(
                  child: Opacity(
                    opacity: 0.60,
                    child: Image.network(
                      member.avatarUrl,
                      fit: BoxFit.cover,
                      errorBuilder: (_, __, ___) =>
                          Container(color: const Color(0xFFE5E7EB)),
                    ),
                  ),
                ),
                Positioned.fill(
                  child: DecoratedBox(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [
                          Colors.white.withValues(alpha: 0.10),
                          Colors.white.withValues(alpha: 0.60),
                          Colors.white,
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),

          // Content
          Padding(
            padding: EdgeInsets.all(cardPad),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                // Top row: avatar info + battery
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Avatar + name + status
                    Flexible(
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          // Avatar with status dot
                          Stack(
                            children: [
                              Container(
                                width: avatarSize,
                                height: avatarSize,
                                padding: EdgeInsets.all(4),
                                decoration: const ShapeDecoration(
                                  color: Colors.white,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.all(
                                        Radius.circular(9999)),
                                  ),
                                ),
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(9999),
                                  child: Image.network(
                                    member.avatarUrl,
                                    fit: BoxFit.cover,
                                    errorBuilder: (_, __, ___) => Container(
                                      color: const Color(0xFFE5E7EB),
                                      child: Icon(Icons.person,
                                          size: avatarSize * 0.4,
                                          color: const Color(0xFF9CA3AF)),
                                    ),
                                  ),
                                ),
                              ),
                              Positioned(
                                right: 0,
                                bottom: 0,
                                child: Container(
                                  width: 18,
                                  height: 18,
                                  decoration: ShapeDecoration(
                                    color: member.indicatorColor,
                                    shape: RoundedRectangleBorder(
                                      side: const BorderSide(
                                          width: 2, color: Colors.white),
                                      borderRadius:
                                          BorderRadius.circular(9999),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(width: 12),
                          Flexible(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  member.name,
                                  style: TextStyle(
                                    color: member.nameColor,
                                    fontSize: nameFontSize,
                                    fontFamily: 'Public Sans',
                                    fontWeight: FontWeight.w700,
                                    height: 1.40,
                                  ),
                                ),
                                const SizedBox(height: 4),
                                Container(
                                  padding: EdgeInsets.symmetric(
                                      horizontal: 10, vertical: 3),
                                  decoration: ShapeDecoration(
                                    color:
                                        Colors.white.withValues(alpha: 0.80),
                                    shape: RoundedRectangleBorder(
                                      borderRadius:
                                          BorderRadius.circular(9999),
                                    ),
                                    shadows: const [
                                      BoxShadow(
                                        color: Color(0x0C000000),
                                        blurRadius: 2,
                                        offset: Offset(0, 1),
                                      ),
                                    ],
                                  ),
                                  child: Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Container(
                                        width: 8,
                                        height: 8,
                                        decoration: ShapeDecoration(
                                          color: member.dotColor,
                                          shape: const RoundedRectangleBorder(
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(9999)),
                                          ),
                                        ),
                                      ),
                                      const SizedBox(width: 5),
                                      Text(
                                        member.statusLabel,
                                        style: TextStyle(
                                          color: member.statusColor,
                                          fontSize: statusFontSize,
                                          fontFamily: 'Public Sans',
                                          fontWeight: FontWeight.w500,
                                          height: 1.43,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),

                    const SizedBox(width: 8),

                    // Battery
                    Container(
                      padding: EdgeInsets.symmetric(
                          horizontal: 8, vertical: 4),
                      decoration: ShapeDecoration(
                        color: Colors.white.withValues(alpha: 0.60),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(24),
                        ),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(member.batteryIcon,
                              color: member.batteryColor,
                              size: ResponsiveHelper.sp(context, 18)),
                          const SizedBox(width: 4),
                          Text(
                            '${member.batteryLevel}%',
                            style: TextStyle(
                              color: const Color(0xFF4B5563),
                              fontSize: smallFontSize,
                              fontFamily: 'Public Sans',
                              fontWeight: FontWeight.w600,
                              height: 1.43,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),

                // Bottom row: location pill
                _LocationPill(member: member),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

// ─── Location pill ────────────────────────────────────────────────────────
class _LocationPill extends StatelessWidget {
  const _LocationPill({required this.member});
  final _MemberData member;

  @override
  Widget build(BuildContext context) {
    final iconContainerSize = ResponsiveHelper.sp(context, 40).clamp(32.0, 48.0);
    final smallFontSize = ResponsiveHelper.sp(context, 12);
    final locationFontSize = ResponsiveHelper.sp(context, 14);

    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(ResponsiveHelper.isSmallPhone(context) ? 12 : 16),
      decoration: ShapeDecoration(
        color: Colors.white.withValues(alpha: 0.90),
        shape: RoundedRectangleBorder(
          side: BorderSide(
            width: 1,
            color: Colors.white.withValues(alpha: 0.50),
          ),
          borderRadius: BorderRadius.circular(40),
        ),
        shadows: const [
          BoxShadow(
            color: Color(0x0C000000),
            blurRadius: 2,
            offset: Offset(0, 1),
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Flexible(
            child: Row(
              children: [
                Container(
                  width: iconContainerSize,
                  height: iconContainerSize,
                  decoration: ShapeDecoration(
                    color: member.locationIconBg,
                    shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(9999)),
                    ),
                  ),
                  child: Icon(member.locationIcon,
                      color: member.locationIconColor,
                      size: iconContainerSize * 0.5),
                ),
                const SizedBox(width: 12),
                Flexible(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Vị trí hiện tại',
                        style: TextStyle(
                          color: const Color(0xFF6B7280),
                          fontSize: smallFontSize,
                          fontFamily: 'Public Sans',
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      Text(
                        member.location,
                        style: TextStyle(
                          color: const Color(0xFF111827),
                          fontSize: locationFontSize,
                          fontFamily: 'Public Sans',
                          fontWeight: FontWeight.w600,
                        ),
                        overflow: TextOverflow.ellipsis,
                        maxLines: 1,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Container(
            width: 32,
            height: 32,
            decoration: const ShapeDecoration(
              color: Color(0xFFF3F4F6),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(9999)),
              ),
            ),
            child: const Icon(Icons.arrow_forward_ios_rounded,
                size: 14, color: Color(0xFF4B5563)),
          ),
        ],
      ),
    );
  }
}

// ─── Feature card ─────────────────────────────────────────────────────────
class _FeatureCard extends StatelessWidget {
  const _FeatureCard({required this.feature, required this.onTap});
  final _FeatureData feature;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final iconContainerSize = ResponsiveHelper.sp(context, 44).clamp(36.0, 56.0);
    final labelFontSize = ResponsiveHelper.sp(context, 15);
    final subFontSize = ResponsiveHelper.sp(context, 12);
    final cardPad = ResponsiveHelper.isSmallPhone(context) ? 14.0 : 18.0;

    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.all(cardPad),
        decoration: ShapeDecoration(
          color: Colors.white,
          shape: RoundedRectangleBorder(
            side: const BorderSide(width: 2, color: Color(0xFF87E4DB)),
            borderRadius: BorderRadius.circular(40),
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: iconContainerSize,
              height: iconContainerSize,
              decoration: BoxDecoration(
                color: feature.iconBgColor,
                shape: BoxShape.circle,
                boxShadow: [
                  BoxShadow(
                    color: feature.iconBgColor.withValues(alpha: 0.3),
                    blurRadius: 8,
                    offset: const Offset(0, 3),
                  ),
                ],
              ),
              child: Icon(feature.icon,
                  color: Colors.white,
                  size: iconContainerSize * 0.52),
            ),
            const Spacer(),
            Text(
              feature.label,
              style: TextStyle(
                color: const Color(0xFF1F2937),
                fontSize: labelFontSize,
                fontFamily: 'Public Sans',
                fontWeight: FontWeight.w700,
                height: 1.40,
              ),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
            Text(
              feature.sub,
              style: TextStyle(
                color: const Color(0xFF6B7280),
                fontSize: subFontSize,
                fontFamily: 'Public Sans',
                fontWeight: FontWeight.w400,
              ),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
          ],
        ),
      ),
    );
  }
}

// ─── Data models ─────────────────────────────────────────────────────────
class _MemberData {
  final String name;
  final String statusLabel;
  final Color statusColor;
  final Color dotColor;
  final Color statusBg;
  final int batteryLevel;
  final Color batteryColor;
  final IconData batteryIcon;
  final String location;
  final IconData locationIcon;
  final Color locationIconBg;
  final Color locationIconColor;
  final bool isOnline;
  final String avatarUrl;
  final Color indicatorColor;
  final Color nameColor;

  const _MemberData({
    required this.name,
    required this.statusLabel,
    required this.statusColor,
    required this.dotColor,
    required this.statusBg,
    required this.batteryLevel,
    required this.batteryColor,
    required this.batteryIcon,
    required this.location,
    required this.locationIcon,
    required this.locationIconBg,
    required this.locationIconColor,
    required this.isOnline,
    required this.avatarUrl,
    required this.indicatorColor,
    required this.nameColor,
  });
}

class _FeatureData {
  final IconData icon;
  final String label;
  final String sub;
  final Color iconBgColor;
  final String? route;

  const _FeatureData({
    required this.icon,
    required this.label,
    required this.sub,
    required this.iconBgColor,
    required this.route,
  });
}

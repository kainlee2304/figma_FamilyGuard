import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import '../core/responsive/responsive.dart';
import '../routes/app_routes.dart';
import 'safe_zone_active_screen.dart';
import 'safe_zone_screen.dart';

// ═══════════════════════════════════════════════════════════════════
// SAFE ZONE OVERVIEW SCREEN
// Bản đồ thật OSM + danh sách thành viên + action grid
// ═══════════════════════════════════════════════════════════════════
class SafeZoneOverviewScreen extends StatefulWidget {
  const SafeZoneOverviewScreen({super.key});

  @override
  State<SafeZoneOverviewScreen> createState() => _SafeZoneOverviewScreenState();
}

class _SafeZoneOverviewScreenState extends State<SafeZoneOverviewScreen> {
  final _mapController = MapController();

  // Dữ liệu demo thành viên
  static const List<Map<String, dynamic>> _members = [
    {
      'id': 'm1',
      'name': 'Nguyễn Văn A',
      'avatar': 'A',
      'color': Color(0xFF80CBC4),
      'zones': 3,
      'updated': '5 phút trước',
    },
    {
      'id': 'm2',
      'name': 'Trần Thị B',
      'avatar': 'B',
      'color': Color(0xFFFFCC80),
      'zones': 2,
      'updated': '12 phút trước',
    },
  ];

  // Vùng an toàn demo trên bản đồ
  static const List<Map<String, dynamic>> _zones = [
    {
      'label': 'Nhà',
      'lat': 10.7769,
      'lng': 106.7009,
      'radius': 150.0,
    },
    {
      'label': 'Trường học',
      'lat': 10.7795,
      'lng': 106.7035,
      'radius': 220.0,
    },
  ];

  // Vị trí user demo
  static const _userPos = LatLng(10.7769, 106.7009);

  @override
  void dispose() {
    _mapController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF0F8F7),
      // ── AppBar với nút back ─────────────────────────────────────
      appBar: AppBar(
        backgroundColor: Colors.white,
        foregroundColor: const Color(0xFF0C1D1A),
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new_rounded, size: 20),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: const Text(
          'Quản lí vùng an toàn',
          style: TextStyle(
            color: Color(0xFF00ACB2),
            fontSize: 18,
            fontFamily: 'Lexend',
            fontWeight: FontWeight.w700,
          ),
        ),
        centerTitle: false,
        actions: [
          TextButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => SafeZoneScreen()),
              );
            },
            child: const Text(
              'Xem tất cả',
              style: TextStyle(
                color: Color(0xCC00ACB2),
                fontSize: 14,
                fontFamily: 'Lexend',
                fontWeight: FontWeight.w400,
              ),
            ),
          ),
        ],
      ),

      // ── Body ────────────────────────────────────────────────────
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment(0.5, 0),
            end: Alignment(0.5, 1),
            colors: [Color(0xFFE8F8F7), Color(0xFFF0F8F7)],
          ),
        ),
        child: SingleChildScrollView(
          padding: const EdgeInsets.only(bottom: 24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildMapCard(),
              _buildMembersSection(),
              _buildActionsGrid(),
            ],
          ),
        ),
      ),

      // ── Bottom Navbar (floating pill) ───────────────────────────
      bottomNavigationBar: SafeArea(
        top: false,
        child: Padding(
          padding: const EdgeInsets.fromLTRB(24, 8, 24, 16),
          child: _PillNavBar(
            currentIndex: 1, // map tab active
            onTap: (i) {
              // Tab 0 = home, 1 = map (ta đang ở), 2 = notif, 3 = profile
              if (i == 0) {
                Navigator.pushNamedAndRemoveUntil(
                    context, AppRoutes.home, (r) => false);
              } else if (i == 2) {
                Navigator.pushNamed(context, AppRoutes.safeZoneAlert);
              } else if (i == 3) {
                Navigator.pushNamed(context, AppRoutes.profile);
              }
            },
          ),
        ),
      ),
    );
  }

  // ── Map Card với FlutterMap / OpenStreetMap ─────────────────────
  Widget _buildMapCard() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 16, 16, 20),
      child: Container(
        width: double.infinity,
        height: 260,
        clipBehavior: Clip.antiAlias,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(24),
          border: Border.all(color: const Color(0x1900ACB2), width: 1),
          boxShadow: const [
            BoxShadow(
              color: Color(0x1400ACB2),
              blurRadius: 20,
              offset: Offset(0, 4),
              spreadRadius: -2,
            ),
          ],
        ),
        child: Stack(
          children: [
            // ── Bản đồ OpenStreetMap (tương tác được) ──────────
            FlutterMap(
              mapController: _mapController,
              options: const MapOptions(
                initialCenter: _userPos,
                initialZoom: 15.5,
                interactionOptions: InteractionOptions(
                  flags: InteractiveFlag.all,
                ),
              ),
              children: [
                // Tile layer OSM
                TileLayer(
                  urlTemplate:
                      'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
                  userAgentPackageName: 'com.example.figma_app',
                  maxZoom: 19,
                ),

                // Vùng an toàn (circle)
                CircleLayer(
                  circles: _zones.map((z) {
                    return CircleMarker(
                      point: LatLng(
                          z['lat'] as double, z['lng'] as double),
                      radius: z['radius'] as double,
                      useRadiusInMeter: true,
                      color: const Color(0x3300ACB2),
                      borderColor: const Color(0xFF00ACB2),
                      borderStrokeWidth: 2,
                    );
                  }).toList(),
                ),

                // Nhãn vùng + avatar user
                MarkerLayer(
                  markers: [
                    // Nhãn từng zone
                    ..._zones.map((z) => Marker(
                          point: LatLng(
                              z['lat'] as double, z['lng'] as double),
                          width: 80,
                          height: 28,
                          child: Container(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 6, vertical: 3),
                            decoration: BoxDecoration(
                              color: Colors.white
                                  .withValues(alpha: 0.90),
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: Text(
                              z['label'] as String,
                              textAlign: TextAlign.center,
                              style: const TextStyle(
                                color: Color(0xFF00ACB2),
                                fontSize: 11,
                                fontFamily: 'Lexend',
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                          ),
                        )),

                    // Avatar người dùng
                    Marker(
                      point: _userPos,
                      width: 36,
                      height: 36,
                      child: Container(
                        decoration: BoxDecoration(
                          color: const Color(0xFF00ACB2),
                          shape: BoxShape.circle,
                          border: Border.all(color: Colors.white, width: 2.5),
                          boxShadow: const [
                            BoxShadow(
                              color: Color(0x4400ACB2),
                              blurRadius: 8,
                              offset: Offset(0, 3),
                            ),
                          ],
                        ),
                        child: const Icon(
                          Icons.person,
                          color: Colors.white,
                          size: 18,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),

            // ── Nút zoom controls (góc phải dưới) ──────────────
            Positioned(
              right: 12,
              bottom: 12,
              child: Column(
                children: [
                  _MapButton(
                    icon: Icons.add,
                    onTap: () => _mapController.move(
                        _mapController.camera.center,
                        _mapController.camera.zoom + 1),
                  ),
                  const SizedBox(height: 6),
                  _MapButton(
                    icon: Icons.remove,
                    onTap: () => _mapController.move(
                        _mapController.camera.center,
                        _mapController.camera.zoom - 1),
                  ),
                ],
              ),
            ),

            // ── Nút về vị trí user (góc phải trên) ─────────────
            Positioned(
              right: 12,
              top: 12,
              child: _MapButton(
                icon: Icons.my_location_rounded,
                onTap: () => _mapController.move(_userPos, 15.5),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // ── Members Section ────────────────────────────────────────────
  Widget _buildMembersSection() {
    return Padding(
      padding: const EdgeInsets.only(bottom: 24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 24),
            child: Text(
              'THÀNH VIÊN GIA ĐÌNH',
              style: TextStyle(
                color: Color(0x9900ACB2),
                fontSize: 13,
                fontFamily: 'Lexend',
                fontWeight: FontWeight.w700,
                letterSpacing: 0.70,
              ),
            ),
          ),
          const SizedBox(height: 12),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Column(
              children: List.generate(_members.length, (i) {
                return Padding(
                  padding:
                      EdgeInsets.only(bottom: i < _members.length - 1 ? 12 : 0),
                  child: _buildMemberCard(_members[i]),
                );
              }),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMemberCard(Map<String, dynamic> member) {
    return GestureDetector(
      onTap: () => Navigator.push(
        context,
        MaterialPageRoute(builder: (_) => SafeZoneMemberScreen(member: member)),
      ),
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: ShapeDecoration(
          color: Colors.white,
          shape: RoundedRectangleBorder(
            side: const BorderSide(width: 1, color: Color(0x1900ACB2)),
            borderRadius: BorderRadius.circular(20),
          ),
          shadows: const [
            BoxShadow(color: Color(0x0C000000), blurRadius: 2, offset: Offset(0, 1)),
          ],
        ),
        child: Row(
          children: [
            // Avatar
            Stack(
              clipBehavior: Clip.none,
              children: [
                CircleAvatar(
                  radius: 24,
                  backgroundColor: member['color'] as Color,
                  child: Text(
                    member['avatar'] as String,
                    style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                    ),
                  ),
                ),
                const Positioned(
                  right: 0,
                  bottom: 0,
                  child: _OnlineDot(size: 13),
                ),
              ],
            ),
            const SizedBox(width: 14),

            // Info
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    member['name'] as String,
                    style: const TextStyle(
                      color: Color(0xFF0C1D1A),
                      fontSize: 15,
                      fontFamily: 'Lexend',
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    '${member["zones"]} vùng an toàn',
                    style: const TextStyle(
                      color: Color(0xFF00ACB2),
                      fontSize: 12,
                      fontFamily: 'Lexend',
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  Text(
                    'Cập nhật ${member["updated"]}',
                    style: const TextStyle(
                      color: Color(0xFF9CA3AF),
                      fontSize: 10,
                      fontFamily: 'Lexend',
                    ),
                  ),
                ],
              ),
            ),

            // Arrow
            Container(
              width: 36,
              height: 36,
              decoration: const BoxDecoration(
                color: Color(0x1900ACB2),
                shape: BoxShape.circle,
              ),
              child: const Icon(Icons.chevron_right,
                  color: Color(0xFF00ACB2), size: 20),
            ),
          ],
        ),
      ),
    );
  }

  // ── Actions Grid (2 × 2) ───────────────────────────────────────
  Widget _buildActionsGrid() {
    final actions = [
      _ActionItem(
        icon: Icons.add_location_alt_outlined,
        label: 'Thêm vùng mới',
        color: const Color(0xFF0C1D1A),
        onTap: () => Navigator.pushNamed(context, AppRoutes.safeZoneAdd),
      ),
      _ActionItem(
        icon: Icons.route_outlined,
        label: 'Lịch sử\ndi chuyển',
        color: const Color(0xFF01747A),
        onTap: () => Navigator.pushNamed(context, AppRoutes.activityHistory),
      ),
      _ActionItem(
        icon: Icons.notifications_active_outlined,
        label: 'Cảnh báo',
        color: const Color(0xFF0C1D1A),
        onTap: () => Navigator.pushNamed(context, AppRoutes.safeZoneAlert),
      ),
      _ActionItem(
        icon: Icons.settings_outlined,
        label: 'Cài đặt',
        color: const Color(0xFF0C1D1A),
        onTap: () =>
            Navigator.pushNamed(context, AppRoutes.safeZoneAlertSettings),
      ),
    ];

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: GridView.count(
        crossAxisCount: 2,
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        crossAxisSpacing: 12,
        mainAxisSpacing: 12,
        childAspectRatio: 1.6,
        children: actions.map((a) => _ActionCard(item: a)).toList(),
      ),
    );
  }
}

// ═══════════════════════════════════════════════════════════════════
// PRIVATE WIDGETS
// ═══════════════════════════════════════════════════════════════════

/// Nút tròn overlay trên bản đồ (zoom in/out, locate)
class _MapButton extends StatelessWidget {
  final IconData icon;
  final VoidCallback onTap;
  const _MapButton({required this.icon, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 36,
        height: 36,
        decoration: BoxDecoration(
          color: Colors.white,
          shape: BoxShape.circle,
          boxShadow: const [
            BoxShadow(
              color: Color(0x22000000),
              blurRadius: 6,
              offset: Offset(0, 2),
            ),
          ],
        ),
        child: Icon(icon, color: const Color(0xFF00ACB2), size: 20),
      ),
    );
  }
}

/// Chấm xanh online
class _OnlineDot extends StatelessWidget {
  final double size;
  const _OnlineDot({required this.size});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        color: const Color(0xFF00ACB2),
        shape: BoxShape.circle,
        border: Border.all(color: Colors.white, width: 2),
      ),
    );
  }
}

/// Model cho action button
class _ActionItem {
  final IconData icon;
  final String label;
  final Color color;
  final VoidCallback onTap;
  const _ActionItem(
      {required this.icon,
      required this.label,
      required this.color,
      required this.onTap});
}

/// Card action trong grid
class _ActionCard extends StatelessWidget {
  final _ActionItem item;
  const _ActionCard({required this.item});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: item.onTap,
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: const Color(0x1900ACB2), width: 1),
          boxShadow: const [
            BoxShadow(
              color: Color(0x0C000000),
              blurRadius: 2,
              offset: Offset(0, 1),
            ),
          ],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 40,
              height: 40,
              decoration: BoxDecoration(
                color: const Color(0x1900ACB2),
                borderRadius: BorderRadius.circular(14),
              ),
              child:
                  Icon(item.icon, color: const Color(0xFF00ACB2), size: 20),
            ),
            const SizedBox(height: 8),
            Text(
              item.label,
              textAlign: TextAlign.center,
              style: TextStyle(
                color: item.color,
                fontSize: 12,
                fontFamily: 'Lexend',
                fontWeight: FontWeight.w700,
                height: 1.3,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ═══════════════════════════════════════════════════════════════════
// PILL BOTTOM NAV BAR (cùng style với MainShellScreen)
// ═══════════════════════════════════════════════════════════════════
class _PillNavBar extends StatelessWidget {
  final int currentIndex;
  final ValueChanged<int> onTap;

  const _PillNavBar({required this.currentIndex, required this.onTap});

  static const _icons = [
    Icons.dashboard_rounded,
    Icons.map_rounded,
    Icons.notifications_rounded,
    Icons.person_rounded,
  ];

  @override
  Widget build(BuildContext context) {
    final iconSz = ResponsiveHelper.sp(context, 24);
    final containerSz =
        ResponsiveHelper.sp(context, 52).clamp(48.0, 80.0);

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(width: 1, color: const Color(0xFFF3F4F6)),
        borderRadius: BorderRadius.circular(9999),
        boxShadow: const [
          BoxShadow(
            color: Color(0x3300ACB2),
            blurRadius: 50,
            offset: Offset(0, 25),
            spreadRadius: -12,
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: List.generate(_icons.length, (i) {
          final active = i == currentIndex;
          return GestureDetector(
            onTap: () => onTap(i),
            behavior: HitTestBehavior.opaque,
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 200),
              width: containerSz,
              height: containerSz,
              decoration: ShapeDecoration(
                color: active
                    ? const Color(0xFF00ACB2)
                    : Colors.transparent,
                shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(9999)),
                ),
                shadows: active
                    ? const [
                        BoxShadow(
                          color: Color(0x6600ACB2),
                          blurRadius: 6,
                          offset: Offset(0, 4),
                          spreadRadius: -4,
                        ),
                        BoxShadow(
                          color: Color(0x6600ACB2),
                          blurRadius: 15,
                          offset: Offset(0, 10),
                          spreadRadius: -3,
                        ),
                      ]
                    : [],
              ),
              child: Center(
                child: Icon(
                  _icons[i],
                  size: iconSz,
                  color: active ? Colors.white : const Color(0xFF9CA3AF),
                ),
              ),
            ),
          );
        }),
      ),
    );
  }
}

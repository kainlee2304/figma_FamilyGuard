import 'package:flutter/material.dart';
import 'package:figma_app/core/utils/responsive/responsive.dart';
import 'package:figma_app/core/routes/app_routes.dart';

/// ============================================================
/// SAFE ZONE DETAIL SCREEN - Thông tin vùng an toàn
/// Được dịch và sửa lỗi từ Figma Dev Mode export
/// ============================================================
class SafeZoneDetailScreen extends StatefulWidget {
  const SafeZoneDetailScreen({super.key});

  @override
  State<SafeZoneDetailScreen> createState() => _SafeZoneDetailScreenState();
}

class _SafeZoneDetailScreenState extends State<SafeZoneDetailScreen> {
  // Trạng thái đang chọn
  String _selectedRadius = '500m';
  String _selectedZoneType = 'Trường học';
  bool _scheduleEnabled = true;

  // Danh sách chip bán kính
  final List<String> _radiusOptions = ['50m', '100m', '500m', '1km', '2km'];

  // Danh sách loại vùng
  final List<_ZoneType> _zoneTypes = [
    _ZoneType(
      label: 'Nhà',
      icon: Icons.home_rounded,
      bgColor: Color(0xFFEFF6FF),
      iconColor: Color(0xFF3B82F6),
    ),
    _ZoneType(
      label: 'Trường học',
      icon: Icons.school_rounded,
      bgColor: Color(0xFFFEFCE8),
      iconColor: Color(0xFFEAB308),
    ),
    _ZoneType(
      label: 'Bệnh viện',
      icon: Icons.local_hospital_rounded,
      bgColor: Color(0xFFFEF2F2),
      iconColor: Color(0xFFEF4444),
    ),
    _ZoneType(
      label: 'Tùy chỉnh',
      icon: Icons.tune_rounded,
      bgColor: Color(0xFFF9FAFB),
      iconColor: Color(0xFF6B7280),
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: [
          // ── AppBar ─────────────────────────────────────────────
          _buildAppBar(context),

          // ── Nội dung cuộn ──────────────────────────────────────
          Expanded(
            child: SingleChildScrollView(
              padding: EdgeInsets.only(
                top: 16,
                left: 16,
                right: 16,
                bottom: 96,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Tên vùng
                  _buildSectionLabel('Tên vùng'),
                  const SizedBox(height: 8),
                  _buildTextField(
                    initialValue: 'Trường Tiểu học Kim Đồng',
                    icon: Icons.edit_rounded,
                    iconColor: const Color(0xFF00ACB2),
                    readOnly: false,
                    textColor: const Color(0xFF0C1D1A),
                    bgColor: Colors.white,
                    borderColor: const Color(0xFFE5E7EB),
                  ),

                  const SizedBox(height: 24),

                  // Địa chỉ
                  _buildSectionLabel('Địa chỉ'),
                  const SizedBox(height: 8),
                  _buildTextField(
                    initialValue: '123 Đường Lê Lợi, Quận 1, TP. HCM',
                    icon: Icons.location_on_rounded,
                    iconColor: const Color(0xFF9CA3AF),
                    readOnly: true,
                    textColor: const Color(0xFF6B7280),
                    bgColor: const Color(0xFFF9FAFB),
                    borderColor: const Color(0xFFF3F4F6),
                  ),

                  const SizedBox(height: 24),

                  // Bán kính
                  _buildSectionLabel('Bán kính'),
                  const SizedBox(height: 12),
                  _buildRadiusChips(),
                  const SizedBox(height: 8),
                  TextButton(
                    onPressed: () => Navigator.of(context).pushNamed(AppRoutes.safeZoneConfig),
                    child: Text(
                      'Tùy chỉnh',
                      style: TextStyle(
                        color: Color(0xFF00ACB2),
                        fontSize: ResponsiveHelper.sp(context, 14),
                        fontFamily: 'Lexend',
                        fontWeight: FontWeight.w500,
                        height: 1.43,
                      ),
                    ),
                  ),

                  const SizedBox(height: 24),

                  // Loại vùng
                  _buildSectionLabel('Loại vùng'),
                  const SizedBox(height: 12),
                  _buildZoneTypeGrid(),

                  const SizedBox(height: 24),

                  // Hoạt động theo giờ
                  _buildScheduleCard(),
                ],
              ),
            ),
          ),

          // ── Nút "Lưu thông tin" (bottom bar) ──────────────────
          _buildBottomBar(),
        ],
      ),
    );
  }

  // ── AppBar tuỳ chỉnh ────────────────────────────────────────────
  Widget _buildAppBar(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 73,
      padding: EdgeInsets.all(16),
      decoration: const ShapeDecoration(
        color: Colors.white,
        shape: RoundedRectangleBorder(
          side: BorderSide(width: 1, color: Color(0xFFF3F4F6)),
        ),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          // Nút back
          GestureDetector(
            onTap: () => Navigator.of(context).maybePop(),
            child: Container(
              width: 40,
              height: 40,
              alignment: Alignment.center,
              decoration: ShapeDecoration(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(9999),
                ),
              ),
              child: const Icon(
                Icons.arrow_back_ios_new_rounded,
                size: 18,
                color: Color(0xFF0C1D1A),
              ),
            ),
          ),
          const SizedBox(width: 8),
          // Tiêu đề
          Expanded(
            child: Text(
              'Thông tin vùng an toàn',
              style: TextStyle(
                color: Color(0xFF0C1D1A),
                fontSize: ResponsiveHelper.sp(context, 18),
                fontFamily: 'Lexend',
                fontWeight: FontWeight.w700,
                height: 1.25,
                letterSpacing: -0.45,
              ),
            ),
          ),
        ],
      ),
    );
  }

  // ── Label tiêu đề section ────────────────────────────────────────
  Widget _buildSectionLabel(String label) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 4),
      child: Text(
        label,
        style: TextStyle(
          color: Color(0xFF0C1D1A),
          fontSize: ResponsiveHelper.sp(context, 16),
          fontFamily: 'Lexend',
          fontWeight: FontWeight.w400,
          height: 1.50,
        ),
      ),
    );
  }

  // ── Text field chung ─────────────────────────────────────────────
  Widget _buildTextField({
    required String initialValue,
    required IconData icon,
    required Color iconColor,
    required bool readOnly,
    required Color textColor,
    required Color bgColor,
    required Color borderColor,
  }) {
    return Container(
      width: double.infinity,
      height: 56,
      padding: EdgeInsets.symmetric(horizontal: ResponsiveHelper.horizontalPadding(context)),
      decoration: ShapeDecoration(
        color: bgColor,
        shape: RoundedRectangleBorder(
          side: BorderSide(width: 1, color: borderColor),
          borderRadius: BorderRadius.circular(24),
        ),
      ),
      child: Row(
        children: [
          Icon(icon, color: iconColor, size: 20),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              initialValue,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                color: textColor,
                fontSize: ResponsiveHelper.sp(context, 16),
                fontFamily: 'Lexend',
                fontWeight: FontWeight.w400,
              ),
            ),
          ),
        ],
      ),
    );
  }

  // ── Chip chọn bán kính ───────────────────────────────────────────
  Widget _buildRadiusChips() {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: _radiusOptions.map((option) {
          final isSelected = option == _selectedRadius;
          return GestureDetector(
            onTap: () => setState(() => _selectedRadius = option),
            child: Container(
              margin: EdgeInsets.only(right: 8),
              height: 40,
              padding: EdgeInsets.symmetric(horizontal: 20),
              decoration: ShapeDecoration(
                color: isSelected
                    ? const Color(0xFF00ACB2)
                    : const Color(0x1900ACB2),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(9999),
                ),
                shadows: isSelected
                    ? const [
                        BoxShadow(
                          color: Color(0x4C00ACB2),
                          blurRadius: 6,
                          offset: Offset(0, 4),
                          spreadRadius: -4,
                        ),
                        BoxShadow(
                          color: Color(0x4C00ACB2),
                          blurRadius: 15,
                          offset: Offset(0, 10),
                          spreadRadius: -3,
                        ),
                      ]
                    : null,
              ),
              child: Center(
                child: Text(
                  option,
                  style: TextStyle(
                    color: isSelected ? Colors.white : const Color(0xFF0C1D1A),
                    fontSize: ResponsiveHelper.sp(context, 14),
                    fontFamily: 'Lexend',
                    fontWeight: FontWeight.w500,
                    height: 1.43,
                  ),
                ),
              ),
            ),
          );
        }).toList(),
      ),
    );
  }

  // ── Grid chọn loại vùng 2x2 ─────────────────────────────────────
  Widget _buildZoneTypeGrid() {
    return GridView.count(
      crossAxisCount: 2,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      crossAxisSpacing: 4,
      mainAxisSpacing: 4,
      childAspectRatio: 1.2,
      children: _zoneTypes.map((type) {
        final isSelected = type.label == _selectedZoneType;
        return GestureDetector(
          onTap: () => setState(() => _selectedZoneType = type.label),
          child: Container(
            padding: EdgeInsets.all(16),
            decoration: ShapeDecoration(
              color: isSelected
                  ? const Color(0x0C00ACB2)
                  : Colors.white,
              shape: RoundedRectangleBorder(
                side: BorderSide(
                  width: isSelected ? 2 : 1,
                  color: isSelected
                      ? const Color(0xFF00ACB2)
                      : const Color(0xFFF3F4F6),
                ),
                borderRadius: BorderRadius.circular(16),
              ),
              shadows: const [
                BoxShadow(
                  color: Color(0x0C000000),
                  blurRadius: 2,
                  offset: Offset(0, 1),
                  spreadRadius: 0,
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
                    color: type.bgColor,
                    shape: BoxShape.circle,
                  ),
                  child: Icon(type.icon, color: type.iconColor, size: 24),
                ),
                const SizedBox(height: 12),
                Text(
                  type.label,
                  style: TextStyle(
                    color: const Color(0xFF0C1D1A),
                    fontSize: ResponsiveHelper.sp(context, 14),
                    fontFamily: 'Lexend',
                    fontWeight: isSelected
                        ? FontWeight.w700
                        : FontWeight.w500,
                    height: 1.43,
                  ),
                ),
              ],
            ),
          ),
        );
      }).toList(),
    );
  }

  // ── Card "Hoạt động theo giờ" ────────────────────────────────────
  Widget _buildScheduleCard() {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(16),
      decoration: ShapeDecoration(
        color: const Color(0x0C00ACB2),
        shape: RoundedRectangleBorder(
          side: const BorderSide(width: 1, color: Color(0x1900ACB2)),
          borderRadius: BorderRadius.circular(16),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Toggle header
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Hoạt động theo giờ',
                    style: TextStyle(
                      color: Color(0xFF0C1D1A),
                      fontSize: ResponsiveHelper.sp(context, 16),
                      fontFamily: 'Lexend',
                      fontWeight: FontWeight.w400,
                      height: 1.25,
                    ),
                  ),
                  SizedBox(height: 2),
                  Text(
                    'Giám sát trong khung giờ nhất định',
                    style: TextStyle(
                      color: Color(0xFF6B7280),
                      fontSize: ResponsiveHelper.sp(context, 12),
                      fontFamily: 'Lexend',
                      fontWeight: FontWeight.w400,
                      height: 1.33,
                    ),
                  ),
                ],
              ),
              // Toggle switch giả lập
              GestureDetector(
                onTap: () => setState(() => _scheduleEnabled = !_scheduleEnabled),
                child: Stack(
                  children: [
                    Container(
                      width: 44,
                      height: 24,
                      decoration: BoxDecoration(
                        color: _scheduleEnabled
                            ? const Color(0xFF00ACB2)
                            : const Color(0xFFE5E7EB),
                        borderRadius: BorderRadius.circular(9999),
                      ),
                    ),
                    AnimatedPositioned(
                      duration: const Duration(milliseconds: 200),
                      left: _scheduleEnabled ? 22 : 2,
                      top: 2,
                      child: Container(
                        width: 20,
                        height: 20,
                        decoration: const BoxDecoration(
                          color: Colors.white,
                          shape: BoxShape.circle,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),

          // Khung giờ (hiện khi bật)
          if (_scheduleEnabled) ...[
            const SizedBox(height: 16),
            GestureDetector(
              onTap: () => Navigator.of(context).pushNamed(AppRoutes.safeZoneTimeRules),
              child: Container(
              width: double.infinity,
              padding: EdgeInsets.all(12),
              decoration: ShapeDecoration(
                color: Colors.white,
                shape: RoundedRectangleBorder(
                  side: const BorderSide(width: 1, color: Color(0x3300ACB2)),
                  borderRadius: BorderRadius.circular(24),
                ),
              ),
              child: Row(
                children: [
                  Container(
                    width: 36,
                    height: 36,
                    decoration: const BoxDecoration(
                      color: Color(0x1900ACB2),
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(
                      Icons.access_time_rounded,
                      color: Color(0xFF00ACB2),
                      size: 18,
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Text(
                      'Khung giờ',
                      style: TextStyle(
                        color: Color(0xFF0C1D1A),
                        fontSize: ResponsiveHelper.sp(context, 16),
                        fontFamily: 'Lexend',
                        fontWeight: FontWeight.w500,
                        height: 1.50,
                      ),
                    ),
                  ),
                  Text(
                    '08:00 - 20:00',
                    style: TextStyle(
                      color: Color(0xFF00ACB2),
                      fontSize: ResponsiveHelper.sp(context, 16),
                      fontFamily: 'Lexend',
                      fontWeight: FontWeight.w700,
                      height: 1.50,
                    ),
                  ),
                  const SizedBox(width: 8),
                  const Icon(
                    Icons.chevron_right_rounded,
                    color: Color(0xFF00ACB2),
                    size: 20,
                  ),
                ],
              ),
            ),
            ),
          ],
        ],
      ),
    );
  }

  // ── Bottom bar nút lưu ───────────────────────────────────────────
  Widget _buildBottomBar() {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(16),
      color: Colors.white.withValues(alpha: 0.95),
      child: ElevatedButton(
        onPressed: () => Navigator.of(context).pushNamed(AppRoutes.safeZoneActive),
        child: const Text('Lưu thông tin'),
      ),
    );
  }
}

// ── Model loại vùng ────────────────────────────────────────────────
class _ZoneType {
  const _ZoneType({
    required this.label,
    required this.icon,
    required this.bgColor,
    required this.iconColor,
  });

  final String label;
  final IconData icon;
  final Color bgColor;
  final Color iconColor;
}


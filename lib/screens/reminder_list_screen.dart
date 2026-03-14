import 'package:flutter/material.dart';
import '../core/responsive/responsive.dart';
import '../routes/app_routes.dart';

/// ============================================================
/// MÀN HÌNH: Lịch nhắc đã tạo
/// Chuyển đổi từ Figma Dev Mode → Flutter Clean Code
/// ============================================================
class ReminderListScreen extends StatefulWidget {
  const ReminderListScreen({super.key});

  @override
  State<ReminderListScreen> createState() => _ReminderListScreenState();
}

class _ReminderListScreenState extends State<ReminderListScreen> {

  // Sample reminders data
  final List<ReminderItem> _reminders = [
    ReminderItem(
      id: '1',
      title: 'Uống thuốc huyết áp',
      time: '08:00 - Mỗi ngày',
      iconColor: const Color(0x33FF85A1),
      icon: Icons.medication,
      isActive: true,
    ),
    ReminderItem(
      id: '2',
      title: 'Ăn sáng',
      time: '07:00 - Mỗi ngày',
      iconColor: const Color(0x33FFD166),
      icon: Icons.restaurant,
      isActive: true,
    ),
    ReminderItem(
      id: '3',
      title: 'Đo huyết áp',
      time: '09:00, 16:00 - Mỗi ngày',
      iconColor: const Color(0x33118AB2),
      icon: Icons.favorite,
      isActive: true,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Color(0xFFF0FFF8), Colors.white],
          ),
        ),
        child: SafeArea(
          bottom: false,
          child: SingleChildScrollView(
            child: Column(
              children: [
                _buildBackButton(),
                _buildMemberCard(),
                _buildTitle(),
                _buildRemindersList(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  /// Back button
  Widget _buildBackButton() {
    return Padding(
      padding: const EdgeInsets.only(top: 16, left: 20),
      child: Align(
        alignment: Alignment.centerLeft,
        child: GestureDetector(
          onTap: () => Navigator.of(context).pop(),
          child: Container(
            width: 40,
            height: 40,
            decoration: const ShapeDecoration(
              color: Colors.white,
              shape: RoundedRectangleBorder(
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
            child: const Icon(
              Icons.arrow_back_ios_new_rounded,
              size: 18,
              color: Color(0xFF00ACB2),
            ),
          ),
        ),
      ),
    );
  }

  /// Member profile card
  Widget _buildMemberCard() {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.only(
        top: 32,
        left: 24,
        right: 24,
        bottom: 24,
      ),
      child: SafeArea(
        bottom: false,
        child: Container(
          padding: EdgeInsets.all(16),
          decoration: ShapeDecoration(
            color: Colors.white,
            shape: RoundedRectangleBorder(
              side: BorderSide(
                width: 1,
                color: const Color(0x2600ACB2),
              ),
              borderRadius: BorderRadius.circular(24),
            ),
            shadows: [
              BoxShadow(
                color: Color(0x1400ACB2),
                blurRadius: 20,
                offset: Offset(0, 4),
                spreadRadius: -2,
              ),
            ],
          ),
          child: Row(
            children: [
              // Avatar with online indicator
              Stack(
                children: [
                  Container(
                    width: 56,
                    height: 56,
                    clipBehavior: Clip.antiAlias,
                    decoration: ShapeDecoration(
                      image: DecorationImage(
                        image: NetworkImage("https://i.pravatar.cc/150?img=47"),
                        fit: BoxFit.cover,
                      ),
                      shape: RoundedRectangleBorder(
                        side: BorderSide(
                          width: 2,
                          color: const Color(0x3300ACB2),
                        ),
                        borderRadius: BorderRadius.circular(9999),
                      ),
                    ),
                  ),
                  Positioned(
                    right: 0,
                    bottom: 0,
                    child: Container(
                      width: 16,
                      height: 16,
                      decoration: ShapeDecoration(
                        color: const Color(0xFF22C55E),
                        shape: RoundedRectangleBorder(
                          side: BorderSide(width: 2, color: Colors.white),
                          borderRadius: BorderRadius.circular(9999),
                        ),
                      ),
                    ),
                  ),
                ],
              ),

              const SizedBox(width: 16),

              // Name and status
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Bà Lan',
                      style: TextStyle(
                        color: const Color(0xFF0F172A),
                        fontSize: 18,
                        fontFamily: 'Lexend',
                        fontWeight: FontWeight.w700,
                        height: 1.56,
                      ),
                    ),
                    Row(
                      children: [
                        Icon(
                          Icons.home,
                          size: 14,
                          color: const Color(0xFF00ACB2),
                        ),
                        const SizedBox(width: 4),
                        Text(
                          'Đang ở nhà',
                          style: TextStyle(
                            color: const Color(0xFF00ACB2),
                            fontSize: 14,
                            fontFamily: 'Lexend',
                            fontWeight: FontWeight.w500,
                            height: 1.43,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),

              // Location and battery info
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                spacing: 4,
                children: [
                  Row(
                    spacing: 4,
                    children: [
                      Icon(
                        Icons.location_on,
                        size: 12,
                        color: const Color(0xFF94A3B8),
                      ),
                      Text(
                        '123 ABC St',
                        style: TextStyle(
                          color: const Color(0xFF94A3B8),
                          fontSize: 12,
                          fontFamily: 'Lexend',
                          fontWeight: FontWeight.w400,
                          height: 1.33,
                        ),
                      ),
                    ],
                  ),
                  Row(
                    spacing: 4,
                    children: [
                      Icon(
                        Icons.battery_charging_full,
                        size: 12,
                        color: const Color(0xFF64748B),
                      ),
                      Text(
                        '85%',
                        style: TextStyle(
                          color: const Color(0xFF64748B),
                          fontSize: 12,
                          fontFamily: 'Lexend',
                          fontWeight: FontWeight.w700,
                          height: 1.33,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  /// Title section
  Widget _buildTitle() {
    final titleSz = ResponsiveHelper.sp(context, 24);
    final hPad = ResponsiveHelper.horizontalPadding(context);
    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(horizontal: hPad, vertical: 8),
      child: Text(
        'Lịch nhắc đã tạo',
        style: TextStyle(
          color: const Color(0xFF0C1D1A),
          fontSize: titleSz,
          fontFamily: 'Lexend',
          fontWeight: FontWeight.w700,
          height: 1.33,
          letterSpacing: -0.60,
        ),
      ),
    );
  }

  /// Reminders list
  Widget _buildRemindersList() {
    final hPad = ResponsiveHelper.horizontalPadding(context);
    return Container(
      padding: EdgeInsets.only(
        top: 16,
        left: hPad,
        right: hPad,
        bottom: 24,
      ),
      child: Column(
        spacing: 16,
        children: [
          // Reminder cards
          ..._reminders.map((reminder) => _buildReminderCard(reminder)),

          // Add new reminder button
          _buildAddButton(),
        ],
      ),
    );
  }

  /// Get icon foreground color based on background color
  Color _getIconColor(Color bgColor) {
    if (bgColor == const Color(0x33FF85A1)) return const Color(0xFFFF85A1);
    if (bgColor == const Color(0x33FFD166)) return const Color(0xFFFFD166);
    if (bgColor == const Color(0x33118AB2)) return const Color(0xFF118AB2);
    return const Color(0xFF00ACB2);
  }

  /// Individual reminder card
  Widget _buildReminderCard(ReminderItem reminder) {
    final iconSz = ResponsiveHelper.sp(context, 24);
    final titleSz = ResponsiveHelper.sp(context, 16);
    final timeSz = ResponsiveHelper.sp(context, 14);
    return GestureDetector(
      onTap: () {
        Navigator.pushNamed(context, AppRoutes.reminderDetail);
      },
      onLongPress: () {
        _showReminderActions(reminder);
      },
      child: Container(
        padding: EdgeInsets.all(16),
        decoration: ShapeDecoration(
          color: Colors.white,
          shape: RoundedRectangleBorder(
            side: const BorderSide(
              width: 1,
              color: Color(0x2600ACB2),
            ),
            borderRadius: BorderRadius.circular(24),
          ),
          shadows: const [
            BoxShadow(
              color: Color(0x1400ACB2),
              blurRadius: 20,
              offset: Offset(0, 4),
              spreadRadius: -2,
            ),
          ],
        ),
        child: Row(
          children: [
            // Icon
            Container(
              width: 48,
              height: 48,
              decoration: ShapeDecoration(
                color: reminder.iconColor,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(9999),
                ),
              ),
              child: Icon(
                reminder.icon,
                color: _getIconColor(reminder.iconColor),
                size: iconSz,
              ),
            ),

            const SizedBox(width: 16),

            // Text info
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    reminder.title,
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: titleSz,
                      fontFamily: 'Lexend',
                      fontWeight: FontWeight.w700,
                      height: 1.50,
                    ),
                  ),
                  Text(
                    reminder.time,
                    style: TextStyle(
                      color: const Color(0xFF64748B),
                      fontSize: timeSz,
                      fontFamily: 'Lexend',
                      fontWeight: FontWeight.w400,
                      height: 1.43,
                    ),
                  ),
                ],
              ),
            ),

            // Toggle switch
            GestureDetector(
              onTap: () {
                setState(() {
                  reminder.isActive = !reminder.isActive;
                });
              },
              child: _buildToggleSwitch(reminder.isActive),
            ),
          ],
        ),
      ),
    );
  }

  /// Toggle switch
  Widget _buildToggleSwitch(bool isActive) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 200),
      width: 48,
      height: 28,
      padding: EdgeInsets.only(
        left: isActive ? 22 : 2,
        right: isActive ? 2 : 22,
        top: 2,
        bottom: 2,
      ),
      decoration: ShapeDecoration(
        color: isActive ? const Color(0xFF00ACB2) : const Color(0xFFE2E8F0),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(9999),
        ),
      ),
      child: Container(
        width: 24,
        height: 24,
        decoration: ShapeDecoration(
          color: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(9999),
          ),
          shadows: [
            BoxShadow(
              color: Color(0x0C000000),
              blurRadius: 2,
              offset: Offset(0, 1),
              spreadRadius: 0,
            ),
          ],
        ),
      ),
    );
  }

  /// Add new reminder button
  Widget _buildAddButton() {
    return OutlinedButton.icon(
      onPressed: () {
        Navigator.pushNamed(context, AppRoutes.createReminder);
      },
      style: OutlinedButton.styleFrom(
        foregroundColor: const Color(0xFF00ACB2),
        side: const BorderSide(width: 2, color: Color(0x4C00ACB2)),
      ),
      icon: const Icon(Icons.add_circle_outline, size: 24),
      label: const Text('Thêm nhắc nhở mới'),
    );
  }

  /// Hiện menu chỉnh sửa / xóa khi long press
  void _showReminderActions(ReminderItem reminder) {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (_) => SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const SizedBox(height: 12),
            Container(
              width: 40,
              height: 4,
              decoration: BoxDecoration(
                color: const Color(0xFFE5E7EB),
                borderRadius: BorderRadius.circular(2),
              ),
            ),
            const SizedBox(height: 16),
            Text(
              reminder.title,
              style: const TextStyle(
                fontFamily: 'Lexend',
                fontWeight: FontWeight.w700,
                fontSize: 16,
                color: Color(0xFF0C1D1A),
              ),
            ),
            const SizedBox(height: 8),
            ListTile(
              leading: const Icon(Icons.edit_outlined, color: Color(0xFF00ACB2)),
              title: const Text(
                'Chỉnh sửa lịch nhắc',
                style: TextStyle(fontFamily: 'Lexend', fontWeight: FontWeight.w500),
              ),
              onTap: () {
                Navigator.pop(context);
                Navigator.pushNamed(context, AppRoutes.reminderListEditable);
              },
            ),
            ListTile(
              leading: const Icon(Icons.delete_outline, color: Color(0xFFEF4444)),
              title: const Text(
                'Xóa lịch nhắc',
                style: TextStyle(
                  fontFamily: 'Lexend',
                  fontWeight: FontWeight.w500,
                  color: Color(0xFFEF4444),
                ),
              ),
              onTap: () {
                Navigator.pop(context);
                Navigator.pushNamed(context, AppRoutes.reminderListDelete);
              },
            ),
            const SizedBox(height: 16),
          ],
        ),
      ),
    );
  }

}

/// Reminder item model
class ReminderItem {
  final String id;
  final String title;
  final String time;
  final Color iconColor;
  final IconData icon;
  bool isActive;

  ReminderItem({
    required this.id,
    required this.title,
    required this.time,
    required this.iconColor,
    required this.icon,
    required this.isActive,
  });
}

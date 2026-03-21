import 'package:flutter/material.dart';
import 'package:figma_app/core/utils/responsive/responsive.dart';
import 'package:figma_app/core/routes/app_routes.dart';
import 'package:figma_app/core/widgets/app_header.dart';

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
          child: Stack(
            children: [
              SingleChildScrollView(
                child: Column(
                  children: [
                    const AppHeader(title: 'Lịch nhắc đã tạo'),
                    _buildMemberCard(),
                    _buildRemindersList(),
                  ],
                ),
              ),
              _buildFAB(),
            ],
          ),
        ),
      ),
    );
  }


  /// Member profile card
  Widget _buildMemberCard() {
    final hPad = ResponsiveHelper.horizontalPadding(context);
    return Container(
      width: double.infinity,
      padding: EdgeInsets.fromLTRB(hPad, 24, hPad, 20),
      child: Container(
        padding: const EdgeInsets.all(16),
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
            Stack(
              children: [
                Container(
                  width: 56,
                  height: 56,
                  clipBehavior: Clip.antiAlias,
                  decoration: ShapeDecoration(
                    image: const DecorationImage(
                      image: NetworkImage("https://i.pravatar.cc/150?img=47"),
                      fit: BoxFit.cover,
                    ),
                    shape: RoundedRectangleBorder(
                      side: const BorderSide(
                        width: 2,
                        color: Color(0x3300ACB2),
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
                        side: const BorderSide(width: 2, color: Colors.white),
                        borderRadius: BorderRadius.circular(9999),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Bà Lan',
                    style: TextStyle(
                      color: Color(0xFF0F172A),
                      fontSize: 18,
                      fontFamily: 'Lexend',
                      fontWeight: FontWeight.w700,
                      height: 1.56,
                    ),
                  ),
                  Row(
                    children: const [
                      Icon(Icons.home, size: 14, color: Color(0xFF00ACB2)),
                      SizedBox(width: 4),
                      Text(
                        'Đang ở nhà',
                        style: TextStyle(
                          color: Color(0xFF00ACB2),
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
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Row(
                  children: const [
                    Icon(Icons.location_on, size: 12, color: Color(0xFF94A3B8)),
                    SizedBox(width: 4),
                    Text(
                      '123 ABC St',
                      style: TextStyle(
                        color: Color(0xFF94A3B8),
                        fontSize: 12,
                        fontFamily: 'Lexend',
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 4),
                Row(
                  children: const [
                    Icon(Icons.battery_charging_full, size: 12, color: Color(0xFF64748B)),
                    SizedBox(width: 4),
                    Text(
                      '85%',
                      style: TextStyle(
                        color: Color(0xFF64748B),
                        fontSize: 12,
                        fontFamily: 'Lexend',
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }


  /// Reminders list
  Widget _buildRemindersList() {
    final hPad = ResponsiveHelper.horizontalPadding(context);
    final bottomPad = MediaQuery.of(context).padding.bottom;
    return Container(
      padding: EdgeInsets.only(
        top: 8,
        left: hPad,
        right: hPad,
        bottom: 100 + bottomPad,
      ),
      child: Column(
        children: [
          ..._reminders.map((reminder) => Padding(
            padding: const EdgeInsets.only(bottom: 16),
            child: _buildSwipeableReminderCard(reminder),
          )),
        ],
      ),
    );
  }

  /// Swipeable wrapper for reminder card
  Widget _buildSwipeableReminderCard(ReminderItem reminder) {
    return _SwipeableReminderItem(
      reminder: reminder,
      onEdit: () => Navigator.pushNamed(context, AppRoutes.reminderListEditable),
      onDelete: () => _confirmDelete(reminder),
      child: _buildReminderCard(reminder),
    );
  }

  /// Xác nhận xóa
  void _confirmDelete(ReminderItem reminder) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        title: const Text('Xóa lịch nhắc', style: TextStyle(fontFamily: 'Lexend')),
        content: Text('Bạn có chắc muốn xóa "${reminder.title}"?', style: const TextStyle(fontFamily: 'Lexend')),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Hủy', style: TextStyle(color: Colors.grey, fontFamily: 'Lexend')),
          ),
          TextButton(
            onPressed: () {
              setState(() {
                _reminders.removeWhere((r) => r.id == reminder.id);
              });
              Navigator.pop(context);
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text('Đã xóa ${reminder.title}'))
              );
            },
            child: const Text('Xóa', style: TextStyle(color: Colors.red, fontFamily: 'Lexend')),
          ),
        ],
      ),
    );
  }

  /// FAB thay thế nút thêm cũ
  Widget _buildFAB() {
    final bottomPad = MediaQuery.of(context).padding.bottom;
    return Positioned(
      right: 24,
      bottom: 24 + bottomPad,
      child: GestureDetector(
        onTap: () => Navigator.pushNamed(context, AppRoutes.createReminder),
        child: Container(
          width: 56,
          height: 56,
          decoration: const BoxDecoration(
            color: Color(0xFF00ACB2),
            shape: BoxShape.circle,
            boxShadow: [
              BoxShadow(
                  color: Color(0x6600ACB2),
                  blurRadius: 15,
                  offset: Offset(0, 8),
                  spreadRadius: -3),
            ],
          ),
          child: const Icon(Icons.add_rounded, color: Colors.white, size: 28),
        ),
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
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 14),
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
          shadows: const [
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
}

// ═══════════════════════════════════════════════════════════════════
// SWIPEABLE REMINDER ITEM – reveals Edit/Delete on swipe left
// ═══════════════════════════════════════════════════════════════════
class _SwipeableReminderItem extends StatefulWidget {
  final ReminderItem reminder;
  final VoidCallback onEdit;
  final VoidCallback onDelete;
  final Widget child;

  const _SwipeableReminderItem({
    required this.reminder,
    required this.onEdit,
    required this.onDelete,
    required this.child,
  });

  @override
  State<_SwipeableReminderItem> createState() => _SwipeableReminderItemState();
}

class _SwipeableReminderItemState extends State<_SwipeableReminderItem>
    with SingleTickerProviderStateMixin {
  late final AnimationController _ctrl;
  late Animation<Offset> _slideAnim;
  double _dragExtent = 0;
  static const double _actionWidth = 120; // 2 buttons × 60

  @override
  void initState() {
    super.initState();
    _ctrl = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 200));
    _slideAnim = Tween<Offset>(begin: Offset.zero, end: Offset.zero)
        .animate(CurvedAnimation(parent: _ctrl, curve: Curves.easeOut));
  }

  @override
  void dispose() {
    _ctrl.dispose();
    super.dispose();
  }

  void _onHorizontalDragUpdate(DragUpdateDetails d) {
    _dragExtent = (_dragExtent + d.delta.dx).clamp(-_actionWidth, 0);
    _slideAnim = AlwaysStoppedAnimation(Offset(_dragExtent, 0));
    setState(() {});
  }

  void _onHorizontalDragEnd(DragEndDetails d) {
    final open = _dragExtent.abs() > _actionWidth / 2;
    final target = open ? -_actionWidth : 0.0;
    _slideAnim = Tween<Offset>(
      begin: Offset(_dragExtent, 0),
      end: Offset(target, 0),
    ).animate(CurvedAnimation(parent: _ctrl, curve: Curves.easeOut));
    _ctrl.forward(from: 0).then((_) => _dragExtent = target);
  }

  void _close() {
    _slideAnim = Tween<Offset>(
      begin: Offset(_dragExtent, 0),
      end: Offset.zero,
    ).animate(CurvedAnimation(parent: _ctrl, curve: Curves.easeOut));
    _ctrl.forward(from: 0).then((_) => _dragExtent = 0);
  }

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(24),
      child: SizedBox(
        height: 96, // Increased height to prevent overflow
        child: Stack(children: [
          // Action buttons behind
          Positioned.fill(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                GestureDetector(
                  onTap: () {
                    _close();
                    // Navigate to detail screen for editing
                    Navigator.pushNamed(context, AppRoutes.reminderDetail);
                  },
                  child: Container(
                    width: 60,
                    decoration: const BoxDecoration(
                      color: Color(0xFFF59E0B),
                    ),
                    child: const Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.edit_rounded,
                              color: Colors.white, size: 22),
                          SizedBox(height: 4),
                          Text('Sửa',
                              style: TextStyle(
                                  fontFamily: 'Lexend',
                                  fontSize: 11,
                                  fontWeight: FontWeight.w600,
                                  color: Colors.white)),
                        ]),
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    _close();
                    widget.onDelete();
                  },
                  child: Container(
                    width: 60,
                    decoration: const BoxDecoration(
                      color: Color(0xFFEF4444),
                    ),
                    child: const Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.delete_rounded,
                              color: Colors.white, size: 22),
                          SizedBox(height: 4),
                          Text('Xóa',
                              style: TextStyle(
                                  fontFamily: 'Lexend',
                                  fontSize: 11,
                                  fontWeight: FontWeight.w600,
                                  color: Colors.white)),
                        ]),
                  ),
                ),
              ],
            ),
          ),

          // Foreground card
          AnimatedBuilder(
            animation: _ctrl,
            builder: (_, __) => Transform.translate(
              offset: _slideAnim.value,
              child: GestureDetector(
                onHorizontalDragUpdate: _onHorizontalDragUpdate,
                onHorizontalDragEnd: _onHorizontalDragEnd,
                child: widget.child,
              ),
            ),
          ),
        ]),
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


import 'package:flutter/material.dart';

/// ============================================================
/// SAFE ZONE UNDO TOAST
/// Thông báo "Đã xóa vùng an toàn thành công" + nút HOÀN TÁC
/// Được dịch và sửa lỗi từ Figma Dev Mode export
/// Usage:  SafeZoneUndoToast.show(context, onUndo: () { ... });
/// ============================================================

class SafeZoneUndoToast {
  // Thời gian hiển thị trước khi tự đóng (ms)
  static const int _autoDismissMs = 4000;

  /// Hiển thị toast thông báo xóa thành công có nút HOÀN TÁC
  static void show(
    BuildContext context, {
    String message = 'Đã xóa vùng an toàn thành công',
    VoidCallback? onUndo,
    VoidCallback? onDismissed,
  }) {
    final overlay = Overlay.of(context);
    late OverlayEntry entry;

    entry = OverlayEntry(
      builder: (_) => _SafeZoneUndoToastWidget(
        message: message,
        onUndo: () {
          entry.remove();
          onUndo?.call();
        },
        onDismissed: () {
          entry.remove();
          onDismissed?.call();
        },
        autoDismissMs: _autoDismissMs,
      ),
    );

    overlay.insert(entry);
  }
}

/// ── Widget toast nội bộ ───────────────────────────────────────────
class _SafeZoneUndoToastWidget extends StatefulWidget {
  final String message;
  final VoidCallback onUndo;
  final VoidCallback onDismissed;
  final int autoDismissMs;

  const _SafeZoneUndoToastWidget({
    required this.message,
    required this.onUndo,
    required this.onDismissed,
    required this.autoDismissMs,
  });

  @override
  State<_SafeZoneUndoToastWidget> createState() =>
      _SafeZoneUndoToastWidgetState();
}

class _SafeZoneUndoToastWidgetState extends State<_SafeZoneUndoToastWidget>
    with TickerProviderStateMixin {
  // Phase 1: Slide in từ dưới lên
  late AnimationController _slideInCtrl;
  late Animation<double> _slideInAnim;
  late Animation<double> _opacityInAnim;

  // Phase 2: Auto-dismiss - slide xuống + fade out
  late AnimationController _slideOutCtrl;
  late Animation<double> _slideOutAnim;
  late Animation<double> _opacityOutAnim;
  late Animation<double> _scaleOutAnim;

  // Progress bar cho countdown (Figma "tự động ẩn" có thể thấy progress)
  double _progress = 1.0;
  bool _isDismissing = false;

  @override
  void initState() {
    super.initState();

    // ── Controller slide IN ────────────────────────────────────────
    _slideInCtrl = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 350),
    );
    _slideInAnim = Tween<double>(begin: 80.0, end: 0.0).animate(
      CurvedAnimation(parent: _slideInCtrl, curve: Curves.easeOutCubic),
    );
    _opacityInAnim = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _slideInCtrl, curve: Curves.easeOut),
    );

    // ── Controller slide OUT (auto-dismiss) ──────────────────────────
    // Khớp với Figma "tự động ẩn": toast slide xuống +
    // scale nhỏ lại về height 50px rồi biến mất
    _slideOutCtrl = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 400),
    );
    _slideOutAnim = Tween<double>(begin: 0.0, end: 60.0).animate(
      CurvedAnimation(parent: _slideOutCtrl, curve: Curves.easeInCubic),
    );
    _opacityOutAnim = Tween<double>(begin: 1.0, end: 0.0).animate(
      CurvedAnimation(
        parent: _slideOutCtrl,
        curve: const Interval(0.3, 1.0, curve: Curves.easeIn),
      ),
    );
    _scaleOutAnim = Tween<double>(begin: 1.0, end: 0.92).animate(
      CurvedAnimation(parent: _slideOutCtrl, curve: Curves.easeInCubic),
    );

    // Bắt đầu slide in
    _slideInCtrl.forward();

    // Bắt đầu đếm ngược
    _startCountdown();
  }

  void _startCountdown() async {
    const fps = 60;
    const tickMs = 1000 ~/ fps;
    final totalTicks = widget.autoDismissMs ~/ tickMs;

    for (int i = 0; i < totalTicks; i++) {
      await Future.delayed(Duration(milliseconds: tickMs));
      if (!mounted) return;
      setState(() {
        _progress = 1.0 - (i + 1) / totalTicks;
      });
    }

    if (!mounted) return;
    _dismiss(dismissed: true);
  }

  void _dismiss({bool dismissed = false}) async {
    if (_isDismissing) return;
    _isDismissing = true;

    if (dismissed) {
      // Auto-dismiss: slide out xuống (Figma "tự động ẩn")
      await _slideOutCtrl.forward();
    } else {
      // Người dùng bấm HOÀN TÁC: reverse slide in
      await _slideInCtrl.reverse();
    }

    if (mounted && dismissed) {
      widget.onDismissed();
    }
  }

  @override
  void dispose() {
    _slideInCtrl.dispose();
    _slideOutCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Positioned(
      left: 16,
      right: 16,
      bottom: MediaQuery.of(context).padding.bottom + 24,
      child: AnimatedBuilder(
        animation: Listenable.merge([_slideInCtrl, _slideOutCtrl]),
        builder: (_, child) {
          // Phase slide IN (trượt lên từ dưới)
          final slideInOffset = _slideInAnim.value;
          final opacityIn = _opacityInAnim.value;

          // Phase slide OUT (tự động ẩn - trượt xuống + scale + fade)
          final slideOutOffset = _slideOutAnim.value;
          final opacityOut = _opacityOutAnim.value;
          final scale = _scaleOutAnim.value;

          final totalOffset = slideInOffset + slideOutOffset;
          final opacity = opacityIn * opacityOut;

          return Transform.translate(
            offset: Offset(0, totalOffset),
            child: Transform.scale(
              scale: scale,
              alignment: Alignment.bottomCenter,
              child: Opacity(opacity: opacity.clamp(0.0, 1.0), child: child),
            ),
          );
        },
        child: _buildToastCard(),
      ),
    );
  }

  Widget _buildToastCard() {
    return Container(
      decoration: BoxDecoration(
        color: const Color(0xFF00ACB2),
        borderRadius: BorderRadius.circular(16),
        boxShadow: const [
          BoxShadow(
            color: Color(0x3300ACB2),
            blurRadius: 20,
            offset: Offset(0, 8),
            spreadRadius: -4,
          ),
          BoxShadow(
            color: Color(0x19000000),
            blurRadius: 30,
            offset: Offset(0, 15),
            spreadRadius: -3,
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(16),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Nội dung toast
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  // Icon check circle
                  Container(
                    width: 36,
                    height: 36,
                    decoration: BoxDecoration(
                      color: Colors.white.withValues(alpha: 0.20),
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(
                      Icons.check_circle_rounded,
                      color: Colors.white,
                      size: 20,
                    ),
                  ),

                  const SizedBox(width: 12),

                  // Nội dung text
                  Expanded(
                    child: Text(
                      widget.message,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 14,
                        fontFamily: 'Lexend',
                        fontWeight: FontWeight.w500,
                        height: 1.43,
                      ),
                    ),
                  ),

                  const SizedBox(width: 8),

                  // Divider dọc
                  Container(
                    width: 1,
                    height: 32,
                    color: Colors.white.withValues(alpha: 0.30),
                  ),

                  const SizedBox(width: 12),

                  // Nút HOÀN TÁC
                  TextButton(
                    onPressed: widget.onUndo,
                    style: TextButton.styleFrom(
                      padding: EdgeInsets.zero,
                      minimumSize: Size.zero,
                      tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                    ),
                    child: const Text(
                      'HOÀN\nTÁC',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 13,
                        fontFamily: 'Lexend',
                        fontWeight: FontWeight.w700,
                        height: 1.43,
                        letterSpacing: 0.70,
                        decoration: TextDecoration.underline,
                        decorationColor: Colors.white,
                      ),
                    ),
                  ),
                ],
              ),
            ),

            // Progress bar tự động
            LinearProgressIndicator(
              value: _progress,
              backgroundColor: Colors.white.withValues(alpha: 0.20),
              valueColor:
                  const AlwaysStoppedAnimation<Color>(Colors.white),
              minHeight: 3,
            ),
          ],
        ),
      ),
    );
  }
}

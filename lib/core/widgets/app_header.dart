import 'package:flutter/material.dart';
import 'package:figma_app/core/utils/responsive/responsive.dart';

class AppHeader extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final VoidCallback? onBack;
  final List<Widget>? actions;

  const AppHeader({
    super.key,
    required this.title,
    this.onBack,
    this.actions,
  });

  @override
  Size get preferredSize => const Size.fromHeight(80);

  @override
  Widget build(BuildContext context) {
    final hPad = ResponsiveHelper.horizontalPadding(context);
    final iconSz = ResponsiveHelper.sp(context, 24);
    return Container(
      margin: EdgeInsets.symmetric(horizontal: hPad - 4, vertical: 8),
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 10),
      decoration: const BoxDecoration(
        color: Colors.transparent,
      ),
      child: Stack(
        alignment: Alignment.center,
        children: [
          // Back button
          Align(
            alignment: Alignment.centerLeft,
            child: GestureDetector(
              onTap: onBack ?? () => Navigator.of(context).pop(),
              behavior: HitTestBehavior.opaque,
              child: Icon(
                Icons.chevron_left,
                color: const Color(0xFF2196F3),
                size: iconSz,
              ),
            ),
          ),
          
          // Title
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 40),
            child: Text(
              title,
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.black,
                fontSize: ResponsiveHelper.sp(context, 18),
                fontWeight: FontWeight.bold,
                fontFamily: 'Lexend',
              ),
            ),
          ),
          
          // Actions if any
          if (actions != null)
            Align(
              alignment: Alignment.centerRight,
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: actions!,
              ),
            ),
        ],
      ),
    );
  }
}

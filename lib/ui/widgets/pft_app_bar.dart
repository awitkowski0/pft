import 'package:flutter/material.dart';
import '../../core/theme/app_colors.dart';

class PftAppBar extends StatelessWidget implements PreferredSizeWidget {
  final DateTime? sessionStartTime;

  const PftAppBar({super.key, this.sessionStartTime});

  @override
  Size get preferredSize => const Size.fromHeight(56);

  String _formatDuration(Duration d) {
    final h = d.inHours.toString().padLeft(2, '0');
    final m = (d.inMinutes % 60).toString().padLeft(2, '0');
    final s = (d.inSeconds % 60).toString().padLeft(2, '0');
    return '$h:$m:$s';
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 56,
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Row(
        children: [
          const Icon(
            Icons.local_fire_department,
            color: AppColors.primary,
            size: 20,
          ),
          const SizedBox(width: 8),
          Text(
            'PFT PATH',
            style: TextStyle(
              fontFamily: 'Inter',
              fontSize: 24,
              fontWeight: FontWeight.w900,
              color: AppColors.primary,
              letterSpacing: -0.5,
            ),
          ),
          const Spacer(),
          if (sessionStartTime != null)
            Padding(
              padding: const EdgeInsets.only(right: 16),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    'SESSION TIME',
                    style: TextStyle(
                      fontFamily: 'Inter',
                      fontSize: 12,
                      fontWeight: FontWeight.w700,
                      letterSpacing: 0.05,
                      color: AppColors.onSurfaceVariant,
                    ),
                  ),
                  Text(
                    _formatDuration(
                      DateTime.now().difference(sessionStartTime!),
                    ),
                    style: TextStyle(
                      fontFamily: 'JetBrains Mono',
                      fontSize: 20,
                      fontWeight: FontWeight.w500,
                      color: AppColors.primary,
                    ),
                  ),
                ],
              ),
            ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
            decoration: BoxDecoration(
              border: Border.all(color: AppColors.primary),
            ),
            child: Text(
              'TIER 1',
              style: TextStyle(
                fontFamily: 'Inter',
                fontSize: 12,
                fontWeight: FontWeight.w700,
                letterSpacing: 0.05,
                color: AppColors.primary,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

import 'package:flutter/material.dart';
import '../../core/theme/app_colors.dart';

class BottomNav extends StatelessWidget {
  final int currentIndex;
  final bool suppressed;
  final void Function(int) onTap;

  const BottomNav({
    super.key,
    required this.currentIndex,
    this.suppressed = false,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    if (suppressed) return const SizedBox.shrink();

    return Container(
      height: 64,
      decoration: const BoxDecoration(
        color: AppColors.surface,
        border: Border(
          top: BorderSide(color: AppColors.outlineVariant, width: 1),
        ),
      ),
      child: Row(
        children: [
          _NavItem(
            icon: Icons.dashboard,
            label: 'Dashboard',
            isActive: currentIndex == 0,
            onTap: () => onTap(0),
          ),
          _NavItem(
            icon: Icons.history,
            label: 'Logs',
            isActive: currentIndex == 1,
            onTap: () => onTap(1),
          ),
          _NavItem(
            icon: Icons.settings,
            label: 'Settings',
            isActive: currentIndex == 2,
            onTap: () => onTap(2),
          ),
        ],
      ),
    );
  }
}

class _NavItem extends StatelessWidget {
  final IconData icon;
  final String label;
  final bool isActive;
  final VoidCallback onTap;

  const _NavItem({
    required this.icon,
    required this.label,
    required this.isActive,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          padding: const EdgeInsets.only(top: 8, bottom: 4),
          decoration: BoxDecoration(
            border: isActive
                ? const Border(
                    top: BorderSide(color: AppColors.primary, width: 2),
                  )
                : null,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                icon,
                color: isActive
                    ? AppColors.primary
                    : AppColors.onSurfaceVariant,
                size: 24,
              ),
              const SizedBox(height: 4),
              Text(
                label.toUpperCase(),
                style: TextStyle(
                  fontFamily: 'Inter',
                  fontSize: 10,
                  fontWeight: FontWeight.w700,
                  letterSpacing: 0.05,
                  color: isActive
                      ? AppColors.primary
                      : AppColors.onSurfaceVariant,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

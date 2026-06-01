import 'package:flutter/material.dart';
import '../../core/theme/app_colors.dart';

class IncidentLogEntry extends StatelessWidget {
  final int leadingNumber;
  final String title;
  final String subtitle;
  final bool isRegression;
  final bool isCompleted;
  final VoidCallback? onTap;

  const IncidentLogEntry({
    super.key,
    required this.leadingNumber,
    required this.title,
    required this.subtitle,
    this.isRegression = false,
    this.isCompleted = true,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final numberColor = isRegression
        ? AppColors.onTertiaryContainer
        : AppColors.primary;
    final titleColor = isRegression
        ? AppColors.onTertiaryContainer
        : AppColors.primary;

    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          color: AppColors.surfaceContainer,
          border: Border(
            left: isRegression
                ? const BorderSide(color: AppColors.onTertiaryContainer, width: 4)
                : const BorderSide(color: AppColors.outline, width: 1),
            right: const BorderSide(color: AppColors.outline, width: 1),
            top: const BorderSide(color: AppColors.outline, width: 1),
            bottom: const BorderSide(color: AppColors.outline, width: 1),
          ),
        ),
        padding: const EdgeInsets.all(16),
        child: Row(
          children: [
            SizedBox(
              width: 32,
              child: Text(
                leadingNumber.toString().padLeft(2, '0'),
                style: TextStyle(
                  fontFamily: 'JetBrains Mono',
                  fontSize: 20,
                  fontWeight: FontWeight.w500,
                  color: numberColor,
                ),
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title.toUpperCase(),
                    style: TextStyle(
                      fontFamily: 'Inter',
                      fontSize: 12,
                      fontWeight: FontWeight.w700,
                      letterSpacing: 0.05,
                      color: titleColor,
                    ),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    subtitle,
                    style: TextStyle(
                      fontFamily: 'Inter',
                      fontSize: 10,
                      color: AppColors.onSurfaceVariant,
                    ),
                  ),
                ],
              ),
            ),
            Icon(
              isRegression ? Icons.warning : Icons.check_circle,
              color: isRegression
                  ? AppColors.onTertiaryContainer
                  : AppColors.secondary,
              size: 16,
            ),
          ],
        ),
      ),
    );
  }
}

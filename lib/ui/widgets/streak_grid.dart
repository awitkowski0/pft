import 'package:flutter/material.dart';
import '../../core/theme/app_colors.dart';

class StreakGrid extends StatelessWidget {
  final List<bool> completedDays;

  const StreakGrid({super.key, required this.completedDays});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.surfaceContainer,
        border: Border.all(color: AppColors.outline),
      ),
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Text(
                'CONSISTENCY TELEMETRY',
                style: TextStyle(
                  fontFamily: 'Inter',
                  fontSize: 12,
                  fontWeight: FontWeight.w700,
                  letterSpacing: 0.05,
                  color: AppColors.primary,
                ),
              ),
              const Spacer(),
              Text(
                'LAST 90 DAYS',
                style: TextStyle(
                  fontFamily: 'Inter',
                  fontSize: 12,
                  fontWeight: FontWeight.w700,
                  letterSpacing: 0.05,
                  color: AppColors.onSurfaceVariant,
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          Wrap(
            spacing: 2,
            runSpacing: 2,
            children: List.generate(84, (index) {
              final isCompleted = index < completedDays.length
                  ? completedDays[index]
                  : false;
              final isRegression = index % 19 == 12;
              return Container(
                width: 10,
                height: 10,
                decoration: BoxDecoration(
                  color: isRegression
                      ? AppColors.onTertiaryContainer.withValues(alpha: 0.5)
                      : isCompleted
                          ? AppColors.primary
                          : AppColors.surfaceContainerHigh,
                  border: Border.all(color: AppColors.outline),
                ),
              );
            }),
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              _legendItem(AppColors.onTertiaryContainer.withValues(alpha: 0.5), 'REGRESSION'),
              const SizedBox(width: 16),
              _legendItem(AppColors.primary, 'SUCCESS'),
            ],
          ),
        ],
      ),
    );
  }

  Widget _legendItem(Color color, String label) {
    return Row(
      children: [
        Container(
          width: 12,
          height: 12,
          decoration: BoxDecoration(
            color: color,
            border: Border.all(color: AppColors.outline),
          ),
        ),
        const SizedBox(width: 4),
        Text(
          label,
          style: TextStyle(
            fontFamily: 'Inter',
            fontSize: 10,
            fontWeight: FontWeight.w700,
            letterSpacing: 0.05,
            color: AppColors.onSurfaceVariant,
          ),
        ),
      ],
    );
  }
}

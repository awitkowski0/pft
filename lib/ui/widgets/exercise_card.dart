import 'package:flutter/material.dart';
import '../../core/theme/app_colors.dart';

class ExerciseCard extends StatelessWidget {
  final String exerciseName;
  final String description;
  final String target;
  final String status;
  final bool isCompleted;
  final double progress;
  final String feelRight;
  final String feelWrong;
  final String restTime;
  final String sets;
  final String reps;
  final String notes;
  final VoidCallback onToggle;
  final VoidCallback? onTapDetail;
  final VoidCallback? onSwap;

  const ExerciseCard({
    super.key,
    required this.exerciseName,
    required this.description,
    required this.target,
    required this.status,
    required this.isCompleted,
    this.progress = 0.0,
    this.feelRight = '',
    this.feelWrong = '',
    this.restTime = '',
    this.sets = '',
    this.reps = '',
    this.notes = '',
    required this.onToggle,
    this.onTapDetail,
    this.onSwap,
  });

  void _showDetail(BuildContext context) {
    showDialog(
      context: context,
      builder: (ctx) => Dialog(
        backgroundColor: AppColors.surface,
        shape: const RoundedRectangleBorder(borderRadius: BorderRadius.zero),
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: SingleChildScrollView(
            child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                exerciseName.toUpperCase(),
                style: const TextStyle(
                  fontFamily: 'Inter',
                  fontSize: 20,
                  fontWeight: FontWeight.w700,
                  color: AppColors.primary,
                ),
              ),
              const SizedBox(height: 4),
              const Divider(color: AppColors.outlineVariant, height: 1),
              const SizedBox(height: 16),
              Text(
                description,
                style: const TextStyle(
                  fontFamily: 'Inter',
                  fontSize: 14,
                  height: 1.5,
                  color: AppColors.onSurface,
                ),
              ),
              if (feelRight.isNotEmpty) ...[
                const SizedBox(height: 16),
                Text(
                  'DOING IT RIGHT',
                  style: const TextStyle(
                    fontFamily: 'Inter',
                    fontSize: 12,
                    fontWeight: FontWeight.w700,
                    letterSpacing: 0.05,
                    color: AppColors.secondary,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  feelRight,
                  style: const TextStyle(
                    fontFamily: 'Inter',
                    fontSize: 14,
                    height: 1.4,
                    color: AppColors.onSurface,
                  ),
                ),
              ],
              if (feelWrong.isNotEmpty) ...[
                const SizedBox(height: 12),
                Text(
                  'COMMON MISTAKES',
                  style: const TextStyle(
                    fontFamily: 'Inter',
                    fontSize: 12,
                    fontWeight: FontWeight.w700,
                    letterSpacing: 0.05,
                    color: AppColors.error,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  feelWrong,
                  style: const TextStyle(
                    fontFamily: 'Inter',
                    fontSize: 14,
                    height: 1.4,
                    color: AppColors.onSurface,
                  ),
                ),
              ],
              if (notes.isNotEmpty) ...[
                const SizedBox(height: 12),
                Text(
                  'NOTES',
                  style: const TextStyle(
                    fontFamily: 'Inter',
                    fontSize: 12,
                    fontWeight: FontWeight.w700,
                    letterSpacing: 0.05,
                    color: AppColors.onSurfaceVariant,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  notes,
                  style: const TextStyle(
                    fontFamily: 'Inter',
                    fontSize: 14,
                    height: 1.4,
                    color: AppColors.onSurfaceVariant,
                  ),
                ),
              ],
              const SizedBox(height: 12),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  color: AppColors.surfaceContainer,
                  border: Border.all(color: AppColors.outlineVariant),
                ),
                child: Text(
                  target,
                  style: const TextStyle(
                    fontFamily: 'Inter',
                    fontSize: 13,
                    fontWeight: FontWeight.w700,
                    letterSpacing: 0.05,
                    color: AppColors.secondary,
                  ),
                ),
              ),
              const SizedBox(height: 24),
              GestureDetector(
                onTap: () => Navigator.pop(ctx),
                child: Container(
                  width: double.infinity,
                  padding: const EdgeInsets.symmetric(vertical: 12),
                  color: AppColors.primary,
                  child: const Text(
                    'CLOSE',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontFamily: 'Inter',
                      fontSize: 14,
                      fontWeight: FontWeight.w700,
                      letterSpacing: 0.1,
                      color: AppColors.onPrimary,
                    ),
                  ),
                ),
              ),
            ],
          ),
            ),
        ),
      ),
    );
  }

  Color get _accentColor {
    if (isCompleted) return AppColors.secondary;
    return AppColors.primary;
  }

  String get _statusLabel {
    switch (status) {
      case 'activeTask':
        return 'ACTIVE TASK';
      case 'upNext':
        return 'UP NEXT';
      case 'coolDown':
        return 'COOL DOWN';
      default:
        return '';
    }
  }

  Color get _statusColor {
    switch (status) {
      case 'activeTask':
        return AppColors.secondary;
      case 'upNext':
        return AppColors.onSurfaceVariant;
      case 'coolDown':
        return AppColors.onSurfaceVariant;
      default:
        return AppColors.onSurfaceVariant;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.surface,
        border: Border(
          left: BorderSide(color: _accentColor, width: 4),
          right: const BorderSide(color: AppColors.outlineVariant, width: 1),
          top: const BorderSide(color: AppColors.outlineVariant, width: 1),
          bottom: const BorderSide(color: AppColors.outlineVariant, width: 1),
        ),
      ),
      child: Column(
        children: [
          GestureDetector(
            onTap: () => _showDetail(context),
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          _statusLabel,
                          style: TextStyle(
                            fontFamily: 'Inter',
                            fontSize: 12,
                            fontWeight: FontWeight.w700,
                            letterSpacing: 0.05,
                            color: _statusColor,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          exerciseName,
                          style: TextStyle(
                            fontFamily: 'JetBrains Mono',
                            fontSize: 20,
                            fontWeight: FontWeight.w500,
                            color: AppColors.primary,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          description,
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            fontFamily: 'Inter',
                            fontSize: 14,
                            color: AppColors.onSurfaceVariant,
                          ),
                        ),
                        const SizedBox(height: 8),
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 8,
                            vertical: 4,
                          ),
                          decoration: BoxDecoration(
                            color: AppColors.surfaceContainerHigh,
                            border: Border.all(color: AppColors.outlineVariant),
                          ),
                          child: Text(
                            target,
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
                  ),
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      if (onSwap != null && !isCompleted)
                        GestureDetector(
                          onTap: onSwap,
                          child: Container(
                            width: 40,
                            height: 40,
                            margin: const EdgeInsets.only(right: 8),
                            decoration: BoxDecoration(
                              border: Border.all(color: AppColors.outline),
                            ),
                            child: const Icon(
                              Icons.swap_horiz,
                              color: AppColors.onSurfaceVariant,
                              size: 20,
                            ),
                          ),
                        ),
                      GestureDetector(
                        onTap: onToggle,
                        child: Container(
                          width: 40,
                          height: 40,
                          decoration: BoxDecoration(
                            border: Border.all(color: AppColors.outline),
                          ),
                          child: Icon(
                            Icons.check,
                            color: isCompleted
                                ? AppColors.secondary
                                : AppColors.surface,
                            size: 20,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
          Container(
            height: 4,
            color: AppColors.surfaceContainer,
            child: FractionallySizedBox(
              alignment: Alignment.centerLeft,
              widthFactor: progress.clamp(0.0, 1.0),
              child: Container(
                color: AppColors.secondary,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

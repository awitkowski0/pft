import 'package:flutter/material.dart';
import '../../core/theme/app_colors.dart';

class BriefingCard extends StatelessWidget {
  final String title;
  final String body;
  final Color accentColor;

  const BriefingCard({
    super.key,
    required this.title,
    required this.body,
    this.accentColor = AppColors.secondary,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.surfaceContainer,
        border: Border(
          left: BorderSide(color: accentColor, width: 4),
          bottom: BorderSide.none,
          right: BorderSide.none,
          top: BorderSide.none,
        ),
      ),
      padding: const EdgeInsets.all(16),
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
              color: accentColor,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            body,
            style: TextStyle(
              fontFamily: 'Inter',
              fontSize: 16,
              fontWeight: FontWeight.w400,
              height: 1.5,
              color: AppColors.onSurface,
            ),
          ),
        ],
      ),
    );
  }
}

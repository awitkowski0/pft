import 'package:flutter/material.dart';
import '../../core/theme/app_colors.dart';

class MetricItem {
  final String label;
  final String value;
  final String? unit;
  final Color? valueColor;
  final IconData? icon;
  final int colSpan;
  final Color? accentBorderColor;

  const MetricItem({
    required this.label,
    required this.value,
    this.unit,
    this.valueColor,
    this.icon,
    this.colSpan = 1,
    this.accentBorderColor,
  });
}

class MetricBento extends StatelessWidget {
  final List<MetricItem> items;

  const MetricBento({super.key, required this.items});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        for (int i = 0; i < items.length; i += 2)
          Padding(
            padding: const EdgeInsets.only(bottom: 4),
            child: Row(
              children: [
                _buildItem(items[i]),
                if (i + 1 < items.length) ...[
                  const SizedBox(width: 4),
                  _buildItem(items[i + 1]),
                ],
              ],
            ),
          ),
      ],
    );
  }

  Widget _buildItem(MetricItem item) {
    return Expanded(
      flex: item.colSpan,
      child: Container(
        decoration: BoxDecoration(
          color: AppColors.surfaceContainer,
          border: Border(
            left: item.accentBorderColor != null
                ? BorderSide(color: item.accentBorderColor!, width: 4)
                : const BorderSide(color: AppColors.outlineVariant, width: 1),
            right: const BorderSide(color: AppColors.outlineVariant, width: 1),
            top: const BorderSide(color: AppColors.outlineVariant, width: 1),
            bottom: const BorderSide(color: AppColors.outlineVariant, width: 1),
          ),
        ),
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Expanded(
                  child: Text(
                    item.label.toUpperCase(),
                    style: TextStyle(
                      fontFamily: 'Inter',
                      fontSize: 12,
                      fontWeight: FontWeight.w700,
                      letterSpacing: 0.05,
                      color: AppColors.onSurfaceVariant,
                    ),
                  ),
                ),
                if (item.icon != null)
                  Icon(
                    item.icon,
                    color: item.valueColor ?? AppColors.primary,
                    size: 16,
                  ),
              ],
            ),
            const SizedBox(height: 8),
            Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Flexible(
                  child: Text(
                    item.value,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      fontFamily: 'JetBrains Mono',
                      fontSize: 40,
                      fontWeight: FontWeight.w600,
                      letterSpacing: -0.05,
                      color: item.valueColor ?? AppColors.primary,
                    ),
                  ),
                ),
                if (item.unit != null) ...[
                  const SizedBox(width: 4),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 4),
                    child: Text(
                      item.unit!,
                      style: TextStyle(
                        fontFamily: 'Inter',
                        fontSize: 14,
                        color: AppColors.onSurfaceVariant,
                      ),
                    ),
                  ),
                ],
              ],
            ),
          ],
        ),
      ),
    );
  }
}

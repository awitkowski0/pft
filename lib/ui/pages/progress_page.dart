import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:isar/isar.dart';
import '../../core/theme/app_colors.dart';
import '../../database/isar_service.dart';
import '../../database/schemas/daily_session.dart';
import '../../state/progression_notifier.dart';
import '../widgets/pft_app_bar.dart';
import '../widgets/bottom_nav.dart';
import '../widgets/metric_bento.dart';
import '../widgets/section_header.dart';
import '../widgets/streak_grid.dart';
import '../widgets/incident_log_entry.dart';

class ProgressPage extends ConsumerStatefulWidget {
  const ProgressPage({super.key});

  @override
  ConsumerState<ProgressPage> createState() => _ProgressPageState();
}

class _ProgressPageState extends ConsumerState<ProgressPage> {
  List<DailySession> _allSessions = [];

  @override
  void initState() {
    super.initState();
    _loadSessions();
  }

  Future<void> _loadSessions() async {
    final isar = await IsarService().db;
    final allSessions = await isar.dailySessions
        .where()
        .anyDate()
        .findAll();
    final sessions = allSessions
        .where((s) => s.isCompleted || s.isWeatherSkip)
        .toList()
      ..sort((a, b) => b.date.compareTo(a.date));
    if (mounted) {
      setState(() {
        _allSessions = sessions;
      });
    }
  }

  List<bool> _buildCompletedDays(List<DailySession> sessions) {
    if (sessions.isEmpty) return [];
    final result = <bool>[];
    final now = DateTime.now();
    for (int i = 83; i >= 0; i--) {
      final day = now.subtract(Duration(days: i));
      final dayStart = DateTime(day.year, day.month, day.day);
      final hasSession = sessions.any((s) {
        final sDate = DateTime(s.date.year, s.date.month, s.date.day);
        return sDate == dayStart;
      });
      result.add(hasSession);
    }
    return result;
  }

  @override
  Widget build(BuildContext context) {
    final progression = ref.watch(progressionNotifierProvider);
    final isRegression =
        progression.label == ProgressionLabel.punishedRegression;
    final completedDays = _buildCompletedDays(_allSessions);

    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            const PftAppBar(),
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Status indicator
                    Row(
                      children: [
                        Container(
                          width: 8,
                          height: 8,
                          color: isRegression
                              ? AppColors.onTertiaryContainer
                              : AppColors.onSecondaryContainer,
                        ),
                        const SizedBox(width: 8),
                        Text(
                          'STATUS: ${isRegression ? 'REGRESSION' : 'ACTIVE'}',
                          style: TextStyle(
                            fontFamily: 'Inter',
                            fontSize: 12,
                            fontWeight: FontWeight.w700,
                            letterSpacing: 0.05,
                            color: isRegression
                                ? AppColors.onTertiaryContainer
                                : AppColors.onSecondaryContainer,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),

                    // Metrics
                    MetricBento(
                      items: [
                        MetricItem(
                          label: 'Total Successful Steps',
                          value: '${progression.currentProgressIndex}',
                          colSpan: 2,
                        ),
                        MetricItem(
                          label: 'Current Streak',
                          value: '${progression.currentStreak}',
                          accentBorderColor: AppColors.secondary,
                          colSpan: 1,
                        ),
                        MetricItem(
                          label: 'Max Streak',
                          value: '${progression.maxStreak}',
                          colSpan: 1,
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),

                    // Punishment alert (only when in regression)
                    if (isRegression)
                      Container(
                        margin: const EdgeInsets.only(bottom: 16),
                        decoration: BoxDecoration(
                          color: AppColors.surfaceContainer,
                          border: Border(
                            left: BorderSide(
                              color: AppColors.onTertiaryContainer,
                              width: 4,
                            ),
                            right:
                                const BorderSide(color: AppColors.outline),
                            top: const BorderSide(color: AppColors.outline),
                            bottom:
                                const BorderSide(color: AppColors.outline),
                          ),
                        ),
                        padding: const EdgeInsets.all(16),
                        child: Row(
                          children: [
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'REGRESSION DETECTED',
                                    style: TextStyle(
                                      fontFamily: 'Inter',
                                      fontSize: 12,
                                      fontWeight: FontWeight.w700,
                                      letterSpacing: 0.05,
                                      color: AppColors.onTertiaryContainer,
                                    ),
                                  ),
                                  const SizedBox(height: 4),
                                  Text(
                                    'Missed session: Consistency interrupted.',
                                    style: TextStyle(
                                      fontFamily: 'Inter',
                                      fontSize: 14,
                                      color: AppColors.onSurface,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Text(
                              '-1 UNIT',
                              style: TextStyle(
                                fontFamily: 'JetBrains Mono',
                                fontSize: 20,
                                fontWeight: FontWeight.w500,
                                color: AppColors.onTertiaryContainer,
                              ),
                            ),
                          ],
                        ),
                      ),

                    // Streak Grid
                    StreakGrid(completedDays: completedDays),
                    const SizedBox(height: 32),

                    // Incident Log
                    SectionHeader(title: 'INCIDENT LOG'),
                    ...List.generate(
                      _allSessions.length > 4 ? 4 : _allSessions.length,
                      (index) {
                        final session = _allSessions[index];
                        final isReg = !session.isCompleted || session.isWeatherSkip;
                        final num = _allSessions.length - index;
                        return Padding(
                          padding: const EdgeInsets.only(bottom: 4),
                          child: IncidentLogEntry(
                            leadingNumber: num,
                            title: isReg ? 'REGRESSION ALERT' : 'SUCCESSFUL UPLOAD',
                            subtitle:
                                '${_monthAbbr(session.date.month)} ${session.date.day}, ${session.date.year}'
                                ' \u2022 ${session.date.hour.toString().padLeft(2, '0')}:${session.date.minute.toString().padLeft(2, '0')}',
                            isRegression: isReg,
                            isCompleted: session.isCompleted,
                          ),
                        );
                      },
                    ),
                    const SizedBox(height: 80),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomNav(
        currentIndex: 2,
        onTap: (i) {
          if (i == 0) Navigator.pushReplacementNamed(context, '/');
          if (i == 1) Navigator.pushReplacementNamed(context, '/journal');
          if (i == 2) Navigator.pushReplacementNamed(context, '/settings');
        },
      ),
    );
  }

  String _monthAbbr(int month) {
    const months = [
      'JAN', 'FEB', 'MAR', 'APR', 'MAY', 'JUN',
      'JUL', 'AUG', 'SEP', 'OCT', 'NOV', 'DEC'
    ];
    return months[month - 1];
  }
}

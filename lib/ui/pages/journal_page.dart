import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:isar/isar.dart';
import '../../core/theme/app_colors.dart';
import '../../database/isar_service.dart';
import '../../database/schemas/daily_session.dart';
import '../../core/progression_math.dart';
import '../../state/progression_notifier.dart';
import '../widgets/pft_app_bar.dart';
import '../widgets/bottom_nav.dart';
import '../widgets/section_header.dart';

class JournalPage extends ConsumerStatefulWidget {
  const JournalPage({super.key});

  @override
  ConsumerState<JournalPage> createState() => _JournalPageState();
}

class _JournalPageState extends ConsumerState<JournalPage> {
  final _notesController = TextEditingController();
  bool _saving = false;
  List<_TelemetryEntry> _recentEntries = [];

  @override
  void initState() {
    super.initState();
    _loadTelemetry();
  }

  Future<void> _loadTelemetry() async {
    final isar = await IsarService().db;
    final allSessions = await isar.dailySessions
        .where()
        .anyDate()
        .findAll();
    final completed = allSessions
        .where((s) => s.isCompleted || s.isWeatherSkip)
        .toList()
      ..sort((a, b) => a.date.compareTo(b.date));

    final entries = completed.asMap().entries.map((entry) {
      final idx = entry.key;
      final session = entry.value;
      return _TelemetryEntry(
        sessionNumber: idx + 1,
        date: session.date,
        exerciseCount: session.completedExerciseIds.length,
        isWeatherSkip: session.isWeatherSkip,
        userNotes: session.userNotes,
        phase: phaseAtSession(idx),
      );
    }).toList()
      ..sort((a, b) => b.date.compareTo(a.date));

    if (mounted) {
      setState(() {
        _recentEntries = entries.take(5).toList();
      });
    }
  }

  @override
  void dispose() {
    _notesController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final progression = ref.watch(progressionNotifierProvider);
    final count = progression.completedSessionCount;
    final phaseIdx = phaseIndex(count);
    final nextAt = nextPhaseAt(count);

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
                    // Status Summary
                    Container(
                      decoration: BoxDecoration(
                        color: AppColors.surfaceContainer,
                        border: Border(
                          left: BorderSide(
                            color: progression.currentStreak > 0
                                ? AppColors.secondary
                                : AppColors.outlineVariant,
                            width: 4,
                          ),
                        ),
                      ),
                      padding: const EdgeInsets.all(16),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'CURRENT STATUS',
                            style: TextStyle(
                              fontFamily: 'Inter',
                              fontSize: 12,
                              fontWeight: FontWeight.w700,
                              letterSpacing: 0.05,
                              color: AppColors.secondary,
                            ),
                          ),
                          const SizedBox(height: 12),
                          Text(
                            'Phase ${phaseIdx + 1}: ${phaseName(count)}',
                            style: TextStyle(
                              fontFamily: 'Inter',
                              fontSize: 20,
                              fontWeight: FontWeight.w700,
                              color: AppColors.primary,
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            phaseDescription(phaseIdx),
                            style: TextStyle(
                              fontFamily: 'Inter',
                              fontSize: 14,
                              color: AppColors.onSurfaceVariant,
                            ),
                          ),
                          const SizedBox(height: 16),
                          Row(
                            children: [
                              _summaryStat(
                                'Sessions',
                                '$count',
                                nextAt > 0 ? '$nextAt needed' : 'max',
                              ),
                              const SizedBox(width: 24),
                              _summaryStat(
                                'Streak',
                                '${progression.currentStreak}',
                                'max ${progression.maxStreak}',
                              ),
                            ],
                          ),
                          if (nextAt > 0) ...[
                            const SizedBox(height: 12),
                            ClipRRect(
                              borderRadius: BorderRadius.zero,
                              child: LinearProgressIndicator(
                                value: (count % 10) / 10.0,
                                backgroundColor: AppColors.surfaceContainerHigh,
                                color: AppColors.secondary,
                                minHeight: 4,
                              ),
                            ),
                            const SizedBox(height: 6),
                            Text(
                              '${nextAt - count} sessions until ${nextPhaseName(count)}',
                              style: TextStyle(
                                fontFamily: 'Inter',
                                fontSize: 12,
                                color: AppColors.onSurfaceVariant,
                              ),
                            ),
                          ],
                        ],
                      ),
                    ),
                    const SizedBox(height: 32),

                    // Physical Feedback
                    Text(
                      'Physical Feedback / Soreness Notes',
                      style: TextStyle(
                        fontFamily: 'Inter',
                        fontSize: 12,
                        fontWeight: FontWeight.w700,
                        letterSpacing: 0.05,
                        color: AppColors.primary,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Stack(
                      children: [
                        TextField(
                          controller: _notesController,
                          maxLines: 6,
                          decoration: InputDecoration(
                            hintText: 'Enter raw physiological observations...',
                            filled: true,
                            fillColor: AppColors.surfaceContainerLowest,
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.zero,
                              borderSide:
                                  const BorderSide(color: AppColors.outline),
                            ),
                            contentPadding: const EdgeInsets.all(16),
                          ),
                          style: TextStyle(
                            fontFamily: 'Inter',
                            fontSize: 16,
                            color: AppColors.primary,
                          ),
                        ),
                        Positioned(
                          bottom: 16,
                          right: 16,
                          child: Row(
                            children: [
                              Icon(Icons.edit_note,
                                  color: AppColors.onSurfaceVariant, size: 14),
                              const SizedBox(width: 4),
                              Text(
                                'RECOVERY_LOG_${DateTime.now().month.toString().padLeft(2, '0')}${DateTime.now().day.toString().padLeft(2, '0')}',
                                style: TextStyle(
                                  fontFamily: 'Inter',
                                  fontSize: 10,
                                  fontWeight: FontWeight.w700,
                                  letterSpacing: 0.05,
                                  color: AppColors.onSurfaceVariant,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 32),

                    // Historical Telemetry
                    SectionHeader(
                      title: 'Historical Telemetry',
                      trailing: 'LAST ${_recentEntries.length}',
                    ),
                    if (_recentEntries.isEmpty)
                      Container(
                        width: double.infinity,
                        padding: const EdgeInsets.all(24),
                        decoration: BoxDecoration(
                          color: AppColors.surfaceContainer,
                          border: Border.all(color: AppColors.outline),
                        ),
                        child: Text(
                          'No completed sessions yet. Complete your first workout to see telemetry.',
                          style: TextStyle(
                            fontFamily: 'Inter',
                            fontSize: 14,
                            color: AppColors.onSurfaceVariant,
                          ),
                        ),
                      )
                    else
                      ...List.generate(_recentEntries.length, (index) {
                        final entry = _recentEntries[index];
                        return Container(
                          margin: const EdgeInsets.only(bottom: 8),
                          decoration: BoxDecoration(
                            color: AppColors.surfaceContainerLow,
                            border: Border.all(color: AppColors.outline),
                          ),
                          child: Column(
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(16),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      children: [
                                        Text(
                                          'SESSION #${entry.sessionNumber}',
                                          style: TextStyle(
                                            fontFamily: 'JetBrains Mono',
                                            fontSize: 14,
                                            fontWeight: FontWeight.w700,
                                            color: AppColors.primary,
                                          ),
                                        ),
                                        const Spacer(),
                                        Text(
                                          '${entry.date.month}/${entry.date.day}/${entry.date.year}',
                                          style: TextStyle(
                                            fontFamily: 'JetBrains Mono',
                                            fontSize: 12,
                                            color: AppColors.onSurfaceVariant,
                                          ),
                                        ),
                                      ],
                                    ),
                                    const SizedBox(height: 8),
                                    Row(
                                      children: [
                                        _telemetryTag(
                                          entry.phase,
                                          AppColors.secondary,
                                        ),
                                        const SizedBox(width: 8),
                                        _telemetryTag(
                                          '${entry.exerciseCount} exercises',
                                          AppColors.primary,
                                        ),
                                        if (entry.isWeatherSkip) ...[
                                          const SizedBox(width: 8),
                                          _telemetryTag(
                                            'weather skip',
                                            AppColors.onSurfaceVariant,
                                          ),
                                        ],
                                      ],
                                    ),
                                    if (entry.userNotes != null &&
                                        entry.userNotes!.isNotEmpty) ...[
                                      const SizedBox(height: 8),
                                      Text(
                                        entry.userNotes!,
                                        style: TextStyle(
                                          fontFamily: 'Inter',
                                          fontSize: 14,
                                          fontStyle: FontStyle.italic,
                                          color: AppColors.onSurfaceVariant,
                                        ),
                                      ),
                                    ],
                                  ],
                                ),
                              ),
                            ],
                          ),
                        );
                      }),
                    const SizedBox(height: 80),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: Container(
        decoration: const BoxDecoration(
          color: AppColors.surface,
          border: Border(
            top: BorderSide(color: AppColors.outlineVariant),
          ),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            GestureDetector(
              onTap: _saving
                  ? null
                  : () async {
                      final navigator = Navigator.of(context);
                      setState(() => _saving = true);
                      final isar = await IsarService().db;
                      final now = DateTime.now();
                      final today = DateTime(now.year, now.month, now.day);

                      final existing = await isar.dailySessions
                          .where()
                          .dateEqualTo(today)
                          .findFirst();
                      if (existing != null) {
                        await isar.writeTxn(() async {
                          existing.userNotes = _notesController.text;
                          await isar.dailySessions.put(existing);
                        });
                      }

                      await Future.delayed(const Duration(milliseconds: 800));
                      if (!mounted) return;
                      setState(() => _saving = false);
                      navigator.pushNamedAndRemoveUntil('/', (route) => false);
                    },
              child: Container(
                color: _saving
                    ? AppColors.secondaryContainer
                    : AppColors.primary,
                padding: const EdgeInsets.symmetric(vertical: 16),
                child: Text(
                  _saving ? 'LOG COMMITTED' : 'SAVE JOURNAL',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontFamily: 'Inter',
                    fontSize: 12,
                    fontWeight: FontWeight.w700,
                    letterSpacing: 0.1,
                    color:
                        _saving ? AppColors.secondary : AppColors.onPrimary,
                  ),
                ),
              ),
            ),
            BottomNav(
              currentIndex: 1,
              onTap: (i) {
                if (i == 0) Navigator.pushReplacementNamed(context, '/');
                if (i == 2) Navigator.pushReplacementNamed(context, '/settings');
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _summaryStat(String label, String value, String sub) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label.toUpperCase(),
          style: TextStyle(
            fontFamily: 'Inter',
            fontSize: 11,
            fontWeight: FontWeight.w700,
            letterSpacing: 0.05,
            color: AppColors.onSurfaceVariant,
          ),
        ),
        const SizedBox(height: 2),
        Text(
          value,
          style: TextStyle(
            fontFamily: 'JetBrains Mono',
            fontSize: 24,
            fontWeight: FontWeight.w600,
            color: AppColors.primary,
          ),
        ),
        Text(
          sub,
          style: TextStyle(
            fontFamily: 'Inter',
            fontSize: 11,
            color: AppColors.onSurfaceVariant,
          ),
        ),
      ],
    );
  }

  Widget _telemetryTag(String text, Color color) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
      decoration: BoxDecoration(
        border: Border.all(color: color),
      ),
      child: Text(
        text.toUpperCase(),
        style: TextStyle(
          fontFamily: 'Inter',
          fontSize: 10,
          fontWeight: FontWeight.w700,
          letterSpacing: 0.05,
          color: color,
        ),
      ),
    );
  }
}

class _TelemetryEntry {
  final int sessionNumber;
  final DateTime date;
  final int exerciseCount;
  final bool isWeatherSkip;
  final String? userNotes;
  final String phase;

  const _TelemetryEntry({
    required this.sessionNumber,
    required this.date,
    required this.exerciseCount,
    required this.isWeatherSkip,
    this.userNotes,
    required this.phase,
  });
}

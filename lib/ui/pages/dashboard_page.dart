import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:isar/isar.dart';
import '../../core/progression_math.dart';
import '../../core/theme/app_colors.dart';
import '../../database/isar_service.dart';
import '../../database/schemas/daily_session.dart';
import '../../database/schemas/user_state.dart';
import '../../database/schemas/workout_configuration.dart';
import '../../state/progression_notifier.dart';
import '../../state/session_notifier.dart';
import '../../state/briefing_notifier.dart';
import '../widgets/pft_app_bar.dart';
import '../widgets/bottom_nav.dart';
import '../widgets/briefing_card.dart';
import '../widgets/metric_bento.dart';
import '../widgets/section_header.dart';

class DashboardPage extends ConsumerStatefulWidget {
  const DashboardPage({super.key});

  @override
  ConsumerState<DashboardPage> createState() => _DashboardPageState();
}

class _DashboardPageState extends ConsumerState<DashboardPage> {
  List<Map<String, String>> _previewExercises = [];
  bool _loadingPreview = true;

  @override
  void initState() {
    super.initState();
    _loadPreview();
    _generateBriefing();
  }

  Future<void> _loadPreview() async {
    final exercises =
        await ref.read(progressionNotifierProvider.notifier).getActiveExercises();
    if (mounted) {
      setState(() {
        _previewExercises = exercises
            .map((e) => {
                  'name': e.name,
                  'target': _shortTarget(e),
                  'description': e.instructions,
                })
            .toList();
        _loadingPreview = false;
      });
    }
  }

  Future<void> _generateBriefing() async {
    final isar = await IsarService().db;
    final progression = ref.read(progressionNotifierProvider);
    final userState = await isar.userStates.where().anyId().findFirst();
    final prevSessions = await isar.dailySessions
        .where()
        .anyDate()
        .findAll();

    final exercises = await ref
        .read(progressionNotifierProvider.notifier)
        .getActiveExercises();

    // BriefingNotifier.build() already loaded today's cached briefing from DB.
    // This call refreshes in background if cached data already visible,
    // or shows loading and fetches if no cache.
    ref.read(briefingNotifierProvider.notifier).generateBriefing(
          userName: userState?.userName.isNotEmpty == true
              ? userState!.userName
              : 'Applicant',
          stateLabel: progression.label.name,
          streak: progression.currentStreak,
          isWeatherSkip:
              progression.label == ProgressionLabel.weatherSkipActive,
          todayFocus: phaseName(progression.completedSessionCount),
          previousLogs: prevSessions,
          targetExercises: exercises.map((e) => e.name).toList(),
          fitnessLevel: userState?.fitnessLevel,
          goals: userState?.goals,
          limitations: userState?.limitations,
        );
  }

  String _shortTarget(WorkoutConfiguration e) {
    if (e.instructions.length > 25) {
      return '${e.instructions.substring(0, 25)}...';
    }
    return e.instructions;
  }

  void _showExerciseDetail(BuildContext context, String name, String description) {
    showDialog(
      context: context,
      builder: (ctx) => Dialog(
        backgroundColor: AppColors.surface,
        shape: const RoundedRectangleBorder(borderRadius: BorderRadius.zero),
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                name.toUpperCase(),
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
    );
  }

  @override
  Widget build(BuildContext context) {
    final progression = ref.watch(progressionNotifierProvider);
    final briefingAsync = ref.watch(briefingNotifierProvider);
    final overrideController = TextEditingController();

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
                    briefingAsync.when(
                      data: (text) {
                        if (text == null || text.isEmpty) {
                          return Padding(
                            padding: const EdgeInsets.only(bottom: 32),
                            child: BriefingCard(
                              title: 'Morning Briefing',
                              body: 'Good morning, Applicant. No briefing available yet — get after it.',
                              accentColor: AppColors.secondary,
                            ),
                          );
                        }
                        return Padding(
                          padding: const EdgeInsets.only(bottom: 32),
                          child: BriefingCard(
                            title: 'Morning Briefing',
                            body: text,
                            accentColor: AppColors.secondary,
                          ),
                        );
                      },
                      loading: () => Padding(
                        padding: const EdgeInsets.only(bottom: 32),
                        child: BriefingCard(
                          title: 'Morning Briefing',
                          body: 'Generating today\'s briefing...',
                          accentColor: AppColors.secondary,
                        ),
                      ),
                      error: (err, _) => Padding(
                        padding: const EdgeInsets.only(bottom: 32),
                        child: BriefingCard(
                          title: 'Morning Briefing',
                          body: 'Good morning, Applicant. Stay focused on today\'s objectives.',
                          accentColor: AppColors.secondary,
                        ),
                      ),
                    ),

                    // Progression Stats
                    MetricBento(
                      items: [
                        MetricItem(
                          label: 'Phase',
                          value: phaseName(progression.completedSessionCount),
                          colSpan: 1,
                        ),
                        MetricItem(
                          label: 'Level',
                          value: 'TIER ${progression.currentTier}',
                          colSpan: 1,
                        ),
                        MetricItem(
                          label: 'Streak',
                          value: '${progression.currentStreak}-DAY',
                          valueColor: AppColors.secondary,
                          icon: Icons.bolt,
                          colSpan: 1,
                        ),
                      ],
                    ),
                    const SizedBox(height: 8),
                    GestureDetector(
                      onTap: () => Navigator.pushNamed(context, '/progress'),
                      child: Padding(
                        padding: const EdgeInsets.only(bottom: 24),
                        child: Text(
                          'VIEW FULL PROGRESS →',
                          style: const TextStyle(
                            fontFamily: 'Inter',
                            fontSize: 12,
                            fontWeight: FontWeight.w700,
                            letterSpacing: 0.05,
                            color: AppColors.secondary,
                          ),
                        ),
                      ),
                    ),

                    // Today's Preview
                    const SectionHeader(title: 'Today\'s Focus'),
                    Container(
                      decoration: BoxDecoration(
                        color: AppColors.surfaceContainer,
                        border: Border.all(color: AppColors.outlineVariant),
                      ),
                      child: Column(
                        children: [
                          Container(
                            width: double.infinity,
                            padding: const EdgeInsets.all(16),
                            decoration: const BoxDecoration(
                              border: Border(
                                bottom:
                                    BorderSide(color: AppColors.outlineVariant),
                              ),
                            ),
                            child: Container(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 8, vertical: 2),
                              color: AppColors.primary,
                              child: Text(
                                phaseName(progression.completedSessionCount)
                                    .toUpperCase(),
                                style: const TextStyle(
                                  fontFamily: 'Inter',
                                  fontSize: 12,
                                  fontWeight: FontWeight.w700,
                                  letterSpacing: 0.05,
                                  color: AppColors.onPrimary,
                                ),
                              ),
                            ),
                          ),
                          if (_loadingPreview)
                            const Padding(
                              padding: EdgeInsets.all(16),
                              child: Text(
                                'Loading...',
                                style: TextStyle(
                                  fontFamily: 'Inter',
                                  fontSize: 14,
                                  color: AppColors.onSurfaceVariant,
                                ),
                              ),
                            )
                          else ...[
                            ..._previewExercises.asMap().entries.map(
                                  (entry) => Column(
                                    children: [
                                      GestureDetector(
                                        onTap: () => _showExerciseDetail(
                                          context,
                                          entry.value['name']!,
                                          entry.value['description']!,
                                        ),
                                        child: _ExerciseRow(
                                          entry.value['name']!,
                                          entry.value['target']!,
                                        ),
                                      ),
                                      if (entry.key <
                                          _previewExercises.length - 1)
                                        const Divider(
                                          height: 1,
                                          color: AppColors.outlineVariant,
                                        ),
                                    ],
                                  ),
                                ),
                          ],
                        ],
                      ),
                    ),
                    const SizedBox(height: 32),

                    // Log Override (Weather Skip)
                    Container(
                      decoration: BoxDecoration(
                        color: AppColors.surface,
                        border: Border.all(color: AppColors.outlineVariant),
                      ),
                      padding: const EdgeInsets.all(16),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'LOG OVERRIDE REASON',
                            style: TextStyle(
                              fontFamily: 'Inter',
                              fontSize: 12,
                              fontWeight: FontWeight.w700,
                              letterSpacing: 0.05,
                              color: AppColors.primary,
                            ),
                          ),
                          const SizedBox(height: 4),
                          const Text(
                            'Specify reason (e.g., Rain, Travel, Injury)',
                            style: TextStyle(
                              fontFamily: 'Inter',
                              fontSize: 14,
                              color: AppColors.onSurfaceVariant,
                            ),
                          ),
                          const SizedBox(height: 12),
                          Row(
                            children: [
                              Expanded(
                                child: TextField(
                                  controller: overrideController,
                                  decoration: const InputDecoration(
                                    hintText: 'Enter reason...',
                                    filled: true,
                                    fillColor: AppColors.surfaceContainer,
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.zero,
                                      borderSide:
                                          BorderSide(color: AppColors.outline),
                                    ),
                                    contentPadding: EdgeInsets.symmetric(
                                        horizontal: 12, vertical: 8),
                                  ),
                                  style: const TextStyle(
                                    fontFamily: 'Inter',
                                    fontSize: 14,
                                    color: AppColors.onSurface,
                                  ),
                                ),
                              ),
                              const SizedBox(width: 8),
                              GestureDetector(
                                onTap: () {
                                  if (overrideController.text.isNotEmpty) {
                                    ref
                                        .read(progressionNotifierProvider
                                            .notifier)
                                        .activateWeatherSkip();
                                  }
                                },
                                child: Container(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 12, vertical: 8),
                                  color: AppColors.primary,
                                  child: const Text(
                                    'LOG',
                                    style: TextStyle(
                                      fontFamily: 'Inter',
                                      fontSize: 12,
                                      fontWeight: FontWeight.w700,
                                      letterSpacing: 0.05,
                                      color: AppColors.onPrimary,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 32),

                    // Start Session Button
                    GestureDetector(
                      onTap: () async {
                        final exercises = await ref
                            .read(progressionNotifierProvider.notifier)
                            .getActiveExercises();
                        if (exercises.isNotEmpty) {
                          final isWeather = ref.read(progressionNotifierProvider)
                                  .label ==
                              ProgressionLabel.weatherSkipActive;
                          ref
                              .read(sessionNotifierProvider.notifier)
                              .startSession(exercises, isWeather: isWeather);
                          if (context.mounted) {
                            Navigator.pushNamed(context, '/workout');
                          }
                        }
                      },
                      child: Container(
                        width: double.infinity,
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        color: AppColors.primary,
                        child: const Text(
                          'START SESSION',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontFamily: 'Inter',
                            fontSize: 24,
                            fontWeight: FontWeight.w900,
                            letterSpacing: -0.5,
                            color: AppColors.onPrimary,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomNav(
        currentIndex: 0,
        onTap: (i) {
          if (i == 0) return;
          if (i == 1) Navigator.pushReplacementNamed(context, '/journal');
          if (i == 2) Navigator.pushReplacementNamed(context, '/settings');
        },
      ),
    );
  }
}

class _ExerciseRow extends StatelessWidget {
  final String name;
  final String target;
  const _ExerciseRow(this.name, this.target);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      child: Row(
        children: [
          Expanded(
            child: Text(
              name,
              style: const TextStyle(
                fontFamily: 'Inter',
                fontSize: 16,
                fontWeight: FontWeight.w700,
                color: AppColors.onSurface,
              ),
            ),
          )
        ],
      ),
    );
  }
}

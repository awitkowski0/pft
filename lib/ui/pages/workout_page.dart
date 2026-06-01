import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../core/theme/app_colors.dart';
import '../../state/progression_notifier.dart';
import '../../state/session_notifier.dart';
import '../widgets/pft_app_bar.dart';
import '../widgets/exercise_card.dart';

class WorkoutPage extends ConsumerStatefulWidget {
  const WorkoutPage({super.key});

  @override
  ConsumerState<WorkoutPage> createState() => _WorkoutPageState();
}

class _WorkoutPageState extends ConsumerState<WorkoutPage> {
  Timer? _timer;
  bool _completing = false;
  bool _regenerating = false;

  @override
  void initState() {
    super.initState();
    _timer = Timer.periodic(const Duration(seconds: 1), (_) {
      setState(() {});
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  Future<void> _addMoreExercises() async {
    setState(() => _regenerating = true);
    final exercises = await ref
        .read(progressionNotifierProvider.notifier)
        .getActiveExercises();
    if (exercises.isNotEmpty) {
      ref.read(sessionNotifierProvider.notifier).appendExercises(exercises);
    }
    setState(() => _regenerating = false);
  }

  Future<void> _swapExercise(int index, String category, String currentId) async {
    final replacement = await ref
        .read(progressionNotifierProvider.notifier)
        .getRandomExercise(category, excludeId: currentId);
    ref.read(sessionNotifierProvider.notifier).swapExercise(index, replacement);
  }

  @override
  Widget build(BuildContext context) {
    final session = ref.watch(sessionNotifierProvider);
    ref.watch(progressionNotifierProvider);

    if (session.exercises.isEmpty) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        Navigator.pop(context);
      });
      return const Scaffold(body: SizedBox.shrink());
    }

    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            PftAppBar(sessionStartTime: session.startedAt),
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Active Workout Header
                    Text(
                      'Active Workout Session',
                      style: TextStyle(
                        fontFamily: 'Inter',
                        fontSize: 24,
                        fontWeight: FontWeight.w700,
                        color: AppColors.primary,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Row(
                      children: [
                        Container(
                          width: 8,
                          height: 8,
                          color: AppColors.secondary,
                        ),
                        const SizedBox(width: 8),
                        Text(
                          session.isWeatherSession ? 'Protocol: MOBILITY BASE' : 'Protocol: MACHINE BASE',
                          style: TextStyle(
                            fontFamily: 'Inter',
                            fontSize: 14,
                            color: AppColors.onSurfaceVariant,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),

                    // Regenerate button
                    GestureDetector(
                      onTap: _regenerating ? null : _addMoreExercises,
                      child: Container(
                        width: double.infinity,
                        padding: const EdgeInsets.symmetric(vertical: 12),
                        color: AppColors.surfaceContainer,
                        child: Text(
                          _regenerating ? 'ADDING...' : 'ADD MORE EXERCISES',
                          textAlign: TextAlign.center,
                          style: const TextStyle(
                            fontFamily: 'Inter',
                            fontSize: 12,
                            fontWeight: FontWeight.w700,
                            letterSpacing: 0.1,
                            color: AppColors.onSurface,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 16),

                    // Exercise Cards
                    ...List.generate(session.exercises.length, (index) {
                      final ex = session.exercises[index];
                      final completedCount = session.exercises
                          .where((e) => e.isCompleted)
                          .length;
                      final progress = session.exercises.isEmpty
                          ? 0.0
                          : completedCount / session.exercises.length;
                      return Padding(
                        padding: const EdgeInsets.only(bottom: 16),
                        child: ExerciseCard(
                          exerciseName: ex.name,
                          description: ex.description,
                          target: ex.target,
                          status: ex.status,
                          isCompleted: ex.isCompleted,
                          progress: progress,
                          feelRight: ex.feelRight,
                          feelWrong: ex.feelWrong,
                          restTime: ex.restTime,
                          sets: ex.sets,
                          reps: ex.reps,
                          notes: ex.notes,
                          onToggle: () {
                            ref
                                .read(sessionNotifierProvider.notifier)
                                .toggleExercise(index);
                          },
                          onSwap: ex.isCompleted
                              ? null
                              : () => _swapExercise(index, ex.category, ex.id),
                        ),
                      );
                    }),

                    // Invisible spacer for bottom button
                    const SizedBox(height: 80),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
      // Fixed bottom action bar
      bottomNavigationBar: Container(
        decoration: const BoxDecoration(
          color: AppColors.primary,
          border: Border(
            top: BorderSide(color: AppColors.outlineVariant),
          ),
        ),
        child: SafeArea(
          child: GestureDetector(
            onTap: _completing
                ? null
                : () async {
                    setState(() => _completing = true);
                    final sessionNotifier =
                        ref.read(sessionNotifierProvider.notifier);
                    final progNotifier =
                        ref.read(progressionNotifierProvider.notifier);

                    final ids = sessionNotifier.getCompletedExerciseIds();
                    if (session.isWeatherSession) {
                      await progNotifier.saveWeatherSkipSession();
                    } else {
                      await progNotifier.completeSession(ids);
                    }
                    sessionNotifier.resetSession();

                    if (context.mounted) {
                      Navigator.pushReplacementNamed(context, '/journal');
                    }
                  },
            child: Container(
              padding: const EdgeInsets.symmetric(vertical: 16),
              child: Text(
                _completing ? 'PROCESSING...' : 'COMPLETE SESSION',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontFamily: 'Inter',
                  fontSize: 12,
                  fontWeight: FontWeight.w700,
                  letterSpacing: 0.1,
                  color: AppColors.onPrimary,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:isar/isar.dart';
import '../database/isar_service.dart';
import '../database/schemas/daily_session.dart';
import '../database/schemas/user_state.dart';
import '../services/openrouter_service.dart';

class BriefingNotifier extends AsyncNotifier<String?> {
  @override
  Future<String?> build() async {
    // Load cached briefing from today
    try {
      final isar = await IsarService().db;
      final userState = await isar.userStates.where().anyId().findFirst();
      if (userState?.lastBriefingDate != null) {
        final now = DateTime.now();
        final cached = userState!.lastBriefingDate!;
        if (cached.year == now.year &&
            cached.month == now.month &&
            cached.day == now.day &&
            userState.lastBriefingText != null &&
            userState.lastBriefingText!.isNotEmpty) {
          return userState.lastBriefingText;
        }
      }
    } catch (_) {}
    return null;
  }

  void setCached(String briefing) {
    state = AsyncData(briefing);
  }

  Future<void> generateBriefing({
    required String userName,
    required String stateLabel,
    required int streak,
    required bool isWeatherSkip,
    required String todayFocus,
    required List<DailySession> previousLogs,
    required List<String> targetExercises,
    String? fitnessLevel,
    String? goals,
    String? limitations,
  }) async {
    // Guard: already generated today — skip API call entirely
    try {
      final isar = await IsarService().db;
      final userState = await isar.userStates.where().anyId().findFirst();
      if (userState?.lastBriefingDate != null) {
        final now = DateTime.now();
        final cached = userState!.lastBriefingDate!;
        if (cached.year == now.year &&
            cached.month == now.month &&
            cached.day == now.day &&
            userState.lastBriefingText != null &&
            userState.lastBriefingText!.isNotEmpty) {
          state = AsyncData(userState.lastBriefingText);
          return;
        }
      }
    } catch (_) {}

    final current = state;
    if (current is AsyncData && current.value != null) {
      // Cached data is visible; refresh in background
    } else {
      state = const AsyncLoading();
    }

    final service = OpenRouterService();
    final result = await service.generateBriefing(
      userName: userName,
      stateLabel: stateLabel,
      streak: streak,
      isWeatherSkip: isWeatherSkip,
      todayFocus: todayFocus,
      previousLogs: previousLogs,
      targetExercises: targetExercises,
      fitnessLevel: fitnessLevel,
      goals: goals,
      limitations: limitations,
    );

    if (result != null) {
      // Save to DB for future cache hits
      try {
        final isar = await IsarService().db;
        final userState = await isar.userStates.where().anyId().findFirst();
        if (userState != null) {
          await isar.writeTxn(() async {
            userState.lastBriefingDate = DateTime.now();
            userState.lastBriefingText = result;
            userState.historicalAILogs.add(result);
            await isar.userStates.put(userState);
          });
        }
      } catch (_) {}
    }

    state = AsyncData(result);
  }
}

final briefingNotifierProvider =
    AsyncNotifierProvider<BriefingNotifier, String?>(
  BriefingNotifier.new,
);

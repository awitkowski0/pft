import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'app.dart';
import 'database/exercise_loader.dart';
import 'database/isar_service.dart';
import 'database/seed_demo_data.dart';
import 'services/firestore_service.dart';
import 'services/openrouter_service.dart';
import 'services/remote_config_service.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await dotenv.load();
  final isar = await IsarService().db;

  // Load remote config first so its values are available for subsequent steps
  await RemoteConfigService().load();
  final config = RemoteConfigService().config;

  await ExerciseLoader.loadFromAssets(isar, remoteUrl: config.workoutsUrl);

  if (dotenv.env['SEED_DEMO_DATA'] == 'true') {
    await seedDemoData(isar);
    print('[PFT] Demo data seeded');
  }

  OpenRouterService.healthCheck();
  runApp(const ProviderScope(child: PftPathApp()));

  // Restore from Firestore on fresh install
  WidgetsBinding.instance.addPostFrameCallback((_) async {
    await FirestoreService().restoreIfNeeded(isar);
  });
}

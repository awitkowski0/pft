import 'package:isar/isar.dart';
import 'package:path_provider/path_provider.dart';
import 'schemas/workout_configuration.dart';
import 'schemas/daily_session.dart';
import 'schemas/user_state.dart';

const _schemaVersion = 2;

class IsarService {
  static final IsarService _instance = IsarService._();
  factory IsarService() => _instance;
  IsarService._();

  Isar? _db;

  Future<Isar> get db async {
    if (_db != null) return _db!;
    await _init();
    return _db!;
  }

  Future<void> _init() async {
    final dir = await getApplicationDocumentsDirectory();
    final name = 'pft_$_schemaVersion';

    // Delete any database files from older schema versions
    final oldFiles = dir.listSync().where((f) {
      final path = f.path;
      return path.endsWith('.isar') && !path.contains('pft_$_schemaVersion');
    }).toList();
    for (final f in oldFiles) {
      await f.delete();
    }

    _db = await Isar.open(
      [WorkoutConfigurationSchema, DailySessionSchema, UserStateSchema],
      directory: dir.path,
      name: name,
    );
  }

  Future<void> close() async {
    await _db?.close();
    _db = null;
  }
}

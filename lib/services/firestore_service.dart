import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:isar/isar.dart';
import '../database/schemas/daily_session.dart';
import '../database/schemas/user_state.dart';

class FirestoreService {
  static final FirestoreService _instance = FirestoreService._();
  factory FirestoreService() => _instance;
  FirestoreService._();

  bool _initialized = false;

  Future<void> _ensureInit() async {
    if (_initialized) return;
    try {
      await Firebase.initializeApp();
      await FirebaseAuth.instance.signInAnonymously();
      _initialized = true;
    } catch (ignored) {}
  }

  Future<void> save(Isar isar) async {
    await _ensureInit();
    if (!_initialized) return;

    final uid = FirebaseAuth.instance.currentUser?.uid;
    if (uid == null) return;

    try {
      final userState = await isar.userStates.where().anyId().findFirst();
      final allSessions = await isar.dailySessions
          .where()
          .anyDate()
          .findAll();
      final recent = allSessions
          .where((s) => s.isCompleted)
          .toList()
        ..sort((a, b) => b.date.compareTo(a.date));

      final db = FirebaseFirestore.instance;
      final batch = db.batch();

      if (userState != null) {
        batch.set(db.doc('users/$uid/userState/current'), _encodeUser(userState));
      }

      for (final s in recent.take(20)) {
        final docId = s.date.toIso8601String().substring(0, 10);
        batch.set(db.doc('users/$uid/sessions/$docId'), _encodeSession(s));
      }
      await batch.commit();
    } catch (_) {}
  }

  Future<void> restoreIfNeeded(Isar isar) async {
    await _ensureInit();
    if (!_initialized) return;

    final count = await isar.dailySessions.where().anyId().count();
    if (count > 0) return;

    final uid = FirebaseAuth.instance.currentUser?.uid;
    if (uid == null) return;

    try {
      final db = FirebaseFirestore.instance;

      final userDoc = await db.doc('users/$uid/userState/current').get();
      if (userDoc.exists) {
        final user = _decodeUser(userDoc.data()!);
        await isar.writeTxn(() async {
          await isar.userStates.put(user);
        });
      }

      final sessionsSnapshot = await db.collection('users/$uid/sessions').get();
      if (sessionsSnapshot.docs.isNotEmpty) {
        for (final doc in sessionsSnapshot.docs) {
          final session = _decodeSession(doc.data());
          await isar.writeTxn(() async {
            await isar.dailySessions.put(session);
          });
        }
      }
    } catch (_) {}
  }

  Map<String, dynamic> _encodeUser(UserState u) => {
        'currentProgressIndex': u.currentProgressIndex,
        'currentStreak': u.currentStreak,
        'lastActiveDate': u.lastActiveDate.toIso8601String(),
        'userName': u.userName,
        'userAge': u.userAge,
        'userWeight': u.userWeight,
        'userHeight': u.userHeight,
        'fitnessLevel': u.fitnessLevel,
        'goals': u.goals,
        'limitations': u.limitations,
        'aiGeneratedPlan': u.aiGeneratedPlan,
        'lastBriefingDate': u.lastBriefingDate?.toIso8601String(),
        'lastBriefingText': u.lastBriefingText,
        'historicalAILogs': u.historicalAILogs.toList(),
      };

  UserState _decodeUser(Map<String, dynamic> m) => UserState()
    ..currentProgressIndex = m['currentProgressIndex'] as int? ?? 0
    ..currentStreak = m['currentStreak'] as int? ?? 0
    ..lastActiveDate = DateTime.parse(m['lastActiveDate'] as String)
    ..userName = m['userName'] as String? ?? ''
    ..userAge = m['userAge'] as int? ?? 0
    ..userWeight = (m['userWeight'] as num?)?.toDouble() ?? 0
    ..userHeight = (m['userHeight'] as num?)?.toDouble() ?? 0
    ..fitnessLevel = m['fitnessLevel'] as String? ?? ''
    ..goals = m['goals'] as String? ?? ''
    ..limitations = m['limitations'] as String? ?? ''
    ..aiGeneratedPlan = m['aiGeneratedPlan'] as String? ?? ''
    ..lastBriefingDate =
        m['lastBriefingDate'] != null ? DateTime.parse(m['lastBriefingDate'] as String) : null
    ..lastBriefingText = m['lastBriefingText'] as String?
    ..historicalAILogs = (m['historicalAILogs'] as List?)?.cast<String>() ?? [];

  Map<String, dynamic> _encodeSession(DailySession s) => {
        'date': s.date.toIso8601String(),
        'isCompleted': s.isCompleted,
        'isWeatherSkip': s.isWeatherSkip,
        'completedExerciseIds': s.completedExerciseIds.toList(),
        'userNotes': s.userNotes,
        'performanceMetrics': s.performanceMetrics,
      };

  DailySession _decodeSession(Map<String, dynamic> m) => DailySession()
    ..date = DateTime.parse(m['date'] as String)
    ..isCompleted = m['isCompleted'] as bool? ?? false
    ..isWeatherSkip = m['isWeatherSkip'] as bool? ?? false
    ..completedExerciseIds =
        (m['completedExerciseIds'] as List?)?.cast<String>() ?? []
    ..userNotes = m['userNotes'] as String?
    ..performanceMetrics = m['performanceMetrics'] as String? ?? '{}';
}

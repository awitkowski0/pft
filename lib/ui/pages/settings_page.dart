import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:isar/isar.dart';
import '../../core/theme/app_colors.dart';
import '../../database/isar_service.dart';
import '../../database/schemas/user_state.dart';
import '../../services/openrouter_service.dart';
import '../widgets/pft_app_bar.dart';
import '../widgets/bottom_nav.dart';

class SettingsPage extends ConsumerStatefulWidget {
  const SettingsPage({super.key});

  @override
  ConsumerState<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends ConsumerState<SettingsPage> {
  final _nameController = TextEditingController();
  final _ageController = TextEditingController();
  final _weightController = TextEditingController();
  final _heightController = TextEditingController();
  final _goalsController = TextEditingController();
  final _limitationsController = TextEditingController();
  String _fitnessLevel = 'beginner';
  String? _aiPlan;
  bool _loading = false;
  bool _saving = false;

  @override
  void initState() {
    super.initState();
    _loadProfile();
  }

  Future<void> _loadProfile() async {
    final isar = await IsarService().db;
    final userState = await isar.userStates.where().anyId().findFirst();
    if (userState != null && mounted) {
      setState(() {
        _nameController.text = userState.userName;
        _ageController.text = userState.userAge > 0 ? userState.userAge.toString() : '';
        _weightController.text = userState.userWeight > 0 ? userState.userWeight.toString() : '';
        _heightController.text = userState.userHeight > 0 ? userState.userHeight.toString() : '';
        _goalsController.text = userState.goals;
        _limitationsController.text = userState.limitations;
        _fitnessLevel = userState.fitnessLevel.isNotEmpty ? userState.fitnessLevel : 'beginner';
        _aiPlan = userState.aiGeneratedPlan.isNotEmpty ? userState.aiGeneratedPlan : null;
      });
    }
  }

  Future<void> _saveProfile() async {
    setState(() => _saving = true);
    final isar = await IsarService().db;
    var userState = await isar.userStates.where().anyId().findFirst();
    userState ??= UserState()
      ..currentProgressIndex = 0
      ..currentStreak = 0
      ..lastActiveDate = DateTime.now()
      ..historicalAILogs = []
      ..aiGeneratedPlan = '';
    await isar.writeTxn(() async {
      userState!.userName = _nameController.text;
      userState.userAge = int.tryParse(_ageController.text) ?? 0;
      userState.userWeight = double.tryParse(_weightController.text) ?? 0;
      userState.userHeight = double.tryParse(_heightController.text) ?? 0;
      userState.fitnessLevel = _fitnessLevel;
      userState.goals = _goalsController.text;
      userState.limitations = _limitationsController.text;
      await isar.userStates.put(userState);
    });
    if (mounted) setState(() => _saving = false);
  }

  Future<void> _generatePlan() async {
    await _saveProfile();
    setState(() => _loading = true);

    final isar = await IsarService().db;
    final userState = await isar.userStates.where().anyId().findFirst();
    final service = OpenRouterService();
    final plan = await service.generatePlan(userState: userState);

    if (plan != null && mounted) {
      await isar.writeTxn(() async {
        userState!.aiGeneratedPlan = plan;
        await isar.userStates.put(userState);
      });
      setState(() {
        _aiPlan = plan;
        _loading = false;
      });
    } else {
      if (mounted) setState(() => _loading = false);
    }
  }

  @override
  void dispose() {
    _nameController.dispose();
    _ageController.dispose();
    _weightController.dispose();
    _heightController.dispose();
    _goalsController.dispose();
    _limitationsController.dispose();
    super.dispose();
  }

  Widget _buildField(String label, Widget child) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label.toUpperCase(),
            style: const TextStyle(
              fontFamily: 'Inter',
              fontSize: 12,
              fontWeight: FontWeight.w700,
              letterSpacing: 0.05,
              color: AppColors.primary,
            ),
          ),
          const SizedBox(height: 6),
          child,
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            const PftAppBar(),
            Expanded(
              child: GestureDetector(
                behavior: HitTestBehavior.translucent,
                onTap: () => FocusScope.of(context).unfocus(),
                child: SingleChildScrollView(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'PROFILE',
                        style: TextStyle(
                          fontFamily: 'Inter',
                          fontSize: 24,
                          fontWeight: FontWeight.w700,
                          color: AppColors.primary,
                        ),
                      ),
                      const SizedBox(height: 4),
                      const Text(
                        'Enter your details for AI-generated training plan',
                      style: TextStyle(
                        fontFamily: 'Inter',
                        fontSize: 14,
                        color: AppColors.onSurfaceVariant,
                      ),
                    ),
                    const SizedBox(height: 24),

                    _buildField('Name', TextField(
                      controller: _nameController,
                      decoration: const InputDecoration(
                        hintText: 'e.g. John',
                        filled: true,
                        fillColor: AppColors.surfaceContainer,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.zero,
                          borderSide: BorderSide(color: AppColors.outline),
                        ),
                        contentPadding: EdgeInsets.symmetric(horizontal: 12, vertical: 10),
                      ),
                      style: const TextStyle(fontFamily: 'Inter', fontSize: 14, color: AppColors.onSurface),
                    )),

                    Row(
                      children: [
                        Expanded(
                          child: _buildField('Age', TextField(
                            controller: _ageController,
                            keyboardType: TextInputType.number,
                            decoration: const InputDecoration(
                              hintText: 'e.g. 28',
                              filled: true,
                              fillColor: AppColors.surfaceContainer,
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.zero,
                                borderSide: BorderSide(color: AppColors.outline),
                              ),
                              contentPadding: EdgeInsets.symmetric(horizontal: 12, vertical: 10),
                            ),
                            style: const TextStyle(fontFamily: 'Inter', fontSize: 14, color: AppColors.onSurface),
                          )),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: _buildField('Weight (lbs)', TextField(
                            controller: _weightController,
                            keyboardType: TextInputType.number,
                            decoration: const InputDecoration(
                              hintText: 'e.g. 175',
                              filled: true,
                              fillColor: AppColors.surfaceContainer,
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.zero,
                                borderSide: BorderSide(color: AppColors.outline),
                              ),
                              contentPadding: EdgeInsets.symmetric(horizontal: 12, vertical: 10),
                            ),
                            style: const TextStyle(fontFamily: 'Inter', fontSize: 14, color: AppColors.onSurface),
                          )),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: _buildField('Height (in)', TextField(
                            controller: _heightController,
                            keyboardType: TextInputType.number,
                            decoration: const InputDecoration(
                              hintText: 'e.g. 70',
                              filled: true,
                              fillColor: AppColors.surfaceContainer,
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.zero,
                                borderSide: BorderSide(color: AppColors.outline),
                              ),
                              contentPadding: EdgeInsets.symmetric(horizontal: 12, vertical: 10),
                            ),
                            style: const TextStyle(fontFamily: 'Inter', fontSize: 14, color: AppColors.onSurface),
                          )),
                        ),
                      ],
                    ),

                    _buildField('Fitness Level', DropdownButtonFormField<String>(
                      initialValue: _fitnessLevel,
                      dropdownColor: AppColors.surface,
                      decoration: const InputDecoration(
                        filled: true,
                        fillColor: AppColors.surfaceContainer,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.zero,
                          borderSide: BorderSide(color: AppColors.outline),
                        ),
                        contentPadding: EdgeInsets.symmetric(horizontal: 12, vertical: 10),
                      ),
                      style: const TextStyle(fontFamily: 'Inter', fontSize: 14, color: AppColors.onSurface),
                      items: const [
                        DropdownMenuItem(value: 'beginner', child: Text('Beginner — no consistent routine')),
                        DropdownMenuItem(value: 'novice', child: Text('Novice — some gym experience')),
                        DropdownMenuItem(value: 'intermediate', child: Text('Intermediate — regular training')),
                        DropdownMenuItem(value: 'advanced', child: Text('Advanced — experienced lifter')),
                      ],
                      onChanged: (v) {
                        if (v != null) setState(() => _fitnessLevel = v);
                      },
                    )),

                    _buildField('Goals', TextField(
                      controller: _goalsController,
                      maxLines: 3,
                      decoration: const InputDecoration(
                        hintText: 'e.g. Build strength, improve cardio, pass PFT',
                        filled: true,
                        fillColor: AppColors.surfaceContainer,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.zero,
                          borderSide: BorderSide(color: AppColors.outline),
                        ),
                        contentPadding: EdgeInsets.symmetric(horizontal: 12, vertical: 10),
                      ),
                      style: const TextStyle(fontFamily: 'Inter', fontSize: 14, color: AppColors.onSurface),
                    )),

                    _buildField('Limitations / Injuries', TextField(
                      controller: _limitationsController,
                      maxLines: 2,
                      decoration: const InputDecoration(
                        hintText: 'e.g. Lower back issues, weak shoulders',
                        filled: true,
                        fillColor: AppColors.surfaceContainer,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.zero,
                          borderSide: BorderSide(color: AppColors.outline),
                        ),
                        contentPadding: EdgeInsets.symmetric(horizontal: 12, vertical: 10),
                      ),
                      style: const TextStyle(fontFamily: 'Inter', fontSize: 14, color: AppColors.onSurface),
                    )),

                    const SizedBox(height: 8),

                    // Save button
                    GestureDetector(
                      onTap: _saving ? null : _saveProfile,
                      child: Container(
                        width: double.infinity,
                        padding: const EdgeInsets.symmetric(vertical: 14),
                        color: AppColors.primary,
                        child: Text(
                          _saving ? 'SAVING...' : 'SAVE PROFILE',
                          textAlign: TextAlign.center,
                          style: const TextStyle(
                            fontFamily: 'Inter',
                            fontSize: 14,
                            fontWeight: FontWeight.w700,
                            letterSpacing: 0.1,
                            color: AppColors.onPrimary,
                          ),
                        ),
                      ),
                    ),

                    const SizedBox(height: 24),

                    // AI Plan Generator
                    const Text(
                      'AI TRAINING PLAN',
                      style: TextStyle(
                        fontFamily: 'Inter',
                        fontSize: 20,
                        fontWeight: FontWeight.w700,
                        color: AppColors.primary,
                      ),
                    ),
                    const SizedBox(height: 4),
                    const Text(
                      'Generate a personalized plan with estimated weights for each phase',
                      style: TextStyle(
                        fontFamily: 'Inter',
                        fontSize: 14,
                        color: AppColors.onSurfaceVariant,
                      ),
                    ),
                    const SizedBox(height: 12),

                    GestureDetector(
                      onTap: _loading ? null : _generatePlan,
                      child: Container(
                        width: double.infinity,
                        padding: const EdgeInsets.symmetric(vertical: 14),
                        color: AppColors.secondary,
                        child: Text(
                          _loading ? 'GENERATING...' : 'GENERATE PLAN',
                          textAlign: TextAlign.center,
                          style: const TextStyle(
                            fontFamily: 'Inter',
                            fontSize: 14,
                            fontWeight: FontWeight.w700,
                            letterSpacing: 0.1,
                            color: Colors.black,
                          ),
                        ),
                      ),
                    ),

                    if (_aiPlan != null) ...[
                      const SizedBox(height: 16),
                      Container(
                        width: double.infinity,
                        padding: const EdgeInsets.all(16),
                        decoration: const BoxDecoration(
                          color: AppColors.surfaceContainer,
                          border: Border(
                            left: BorderSide(color: AppColors.secondary, width: 3),
                          ),
                        ),
                        child: Text(
                          _aiPlan!,
                          style: const TextStyle(
                            fontFamily: 'Inter',
                            fontSize: 13,
                            height: 1.5,
                            color: AppColors.onSurface,
                          ),
                        ),
                      ),
                    ],
                    ],
                  ),
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
          if (i == 2) return;
        },
      ),
    );
  }
}

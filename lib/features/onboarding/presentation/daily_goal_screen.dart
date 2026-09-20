import 'package:flutter/material.dart';

import '../../../core/routes/app_routes.dart';
import '../../../core/theme/app_colors.dart';
import '../model/onboarding_setup.dart';
import '../services/onboarding_storage.dart';

class DailyGoalScreen extends StatefulWidget {
  final OnboardingSetup setup;

  const DailyGoalScreen({
    super.key,
    required this.setup,
  });

  @override
  State<DailyGoalScreen> createState() =>
      _DailyGoalScreenState();
}

class _DailyGoalScreenState extends State<DailyGoalScreen> {
  int? _selectedGoal;
  bool _isSaving = false;

  final List<_GoalOption> _goals = const [
    _GoalOption(
      minutes: 5,
      title: 'Casual',
      description: 'A quick daily practice',
    ),
    _GoalOption(
      minutes: 10,
      title: 'Regular',
      description: 'Build a consistent habit',
      recommended: true,
    ),
    _GoalOption(
      minutes: 15,
      title: 'Serious',
      description: 'Make faster progress',
    ),
    _GoalOption(
      minutes: 20,
      title: 'Intensive',
      description: 'Maximum daily practice',
    ),
  ];

  Future<void> _finishOnboarding() async {
    if (_selectedGoal == null || _isSaving) return;

    setState(() {
      _isSaving = true;
    });

    try {
      final completedSetup = widget.setup.copyWith(
        dailyGoal: _selectedGoal,
      );

      await OnboardingStorage.save(completedSetup);

      if (!mounted) return;

      Navigator.pushNamedAndRemoveUntil(
        context,
        AppRoutes.home,
            (route) => false,
      );
    } catch (_) {
      if (!mounted) return;

      setState(() {
        _isSaving = false;
      });

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text(
            'Could not save your setup. Please try again.',
          ),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: !_isSaving,
      child: Scaffold(
        body: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                Color(0xFF251719),
                AppColors.background,
              ],
            ),
          ),
          child: SafeArea(
            child: Column(
              children: [
                Expanded(
                  child: ListView(
                    padding:
                    const EdgeInsets.fromLTRB(22, 14, 22, 30),
                    children: [
                      _buildTopBar(),
                      const SizedBox(height: 26),
                      const Text(
                        'Set your\ndaily goal',
                        style: TextStyle(
                          fontSize: 31,
                          height: 1.12,
                          fontWeight: FontWeight.w800,
                          letterSpacing: -0.7,
                        ),
                      ),
                      const SizedBox(height: 10),
                      const Text(
                        'Small daily practice creates long-term progress.',
                        style: TextStyle(
                          color: AppColors.textSecondary,
                          fontSize: 14,
                          height: 1.5,
                        ),
                      ),
                      const SizedBox(height: 20),
                      _buildProgress(),
                      const SizedBox(height: 30),
                      ..._goals.map(_buildGoalCard),
                    ],
                  ),
                ),
                _buildBottomButton(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildTopBar() {
    return Row(
      children: [
        IconButton(
          onPressed:
          _isSaving ? null : () => Navigator.pop(context),
          style: IconButton.styleFrom(
            backgroundColor: AppColors.card,
          ),
          icon: const Icon(Icons.arrow_back_rounded),
        ),
        const Spacer(),
        const Text(
          'Step 4 of 4',
          style: TextStyle(
            color: AppColors.textSecondary,
            fontWeight: FontWeight.w600,
          ),
        ),
      ],
    );
  }

  Widget _buildProgress() {
    return ClipRRect(
      borderRadius: BorderRadius.circular(20),
      child: const LinearProgressIndicator(
        value: 1,
        minHeight: 6,
        backgroundColor: AppColors.card,
        valueColor: AlwaysStoppedAnimation(AppColors.primary),
      ),
    );
  }

  Widget _buildGoalCard(_GoalOption goal) {
    final selected = _selectedGoal == goal.minutes;

    return AnimatedContainer(
      duration: const Duration(milliseconds: 200),
      margin: const EdgeInsets.only(bottom: 13),
      decoration: BoxDecoration(
        color: selected
            ? AppColors.primary.withValues(alpha: 0.14)
            : AppColors.card,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: selected
              ? AppColors.primary
              : AppColors.border,
          width: selected ? 1.7 : 1,
        ),
      ),
      child: InkWell(
        onTap: _isSaving
            ? null
            : () {
          setState(() {
            _selectedGoal = goal.minutes;
          });
        },
        borderRadius: BorderRadius.circular(20),
        child: Padding(
          padding: const EdgeInsets.all(17),
          child: Row(
            children: [
              Container(
                width: 58,
                height: 58,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: AppColors.primary.withValues(alpha: 0.12),
                  borderRadius: BorderRadius.circular(17),
                ),
                child: Text(
                  '${goal.minutes}',
                  style: const TextStyle(
                    color: AppColors.primaryLight,
                    fontSize: 22,
                    fontWeight: FontWeight.w800,
                  ),
                ),
              ),
              const SizedBox(width: 15),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Text(
                          goal.title,
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        if (goal.recommended) ...[
                          const SizedBox(width: 8),
                          Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 8,
                              vertical: 3,
                            ),
                            decoration: BoxDecoration(
                              color: AppColors.primary,
                              borderRadius:
                              BorderRadius.circular(20),
                            ),
                            child: const Text(
                              'Recommended',
                              style: TextStyle(
                                fontSize: 9,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                          ),
                        ],
                      ],
                    ),
                    const SizedBox(height: 5),
                    Text(
                      '${goal.description} • ${goal.minutes} min/day',
                      style: const TextStyle(
                        color: AppColors.textSecondary,
                        fontSize: 12,
                      ),
                    ),
                  ],
                ),
              ),
              Icon(
                selected
                    ? Icons.check_circle_rounded
                    : Icons.circle_outlined,
                color: selected
                    ? AppColors.primary
                    : AppColors.border,
                size: 28,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildBottomButton() {
    return Container(
      padding: const EdgeInsets.fromLTRB(22, 14, 22, 18),
      decoration: const BoxDecoration(
        color: AppColors.background,
        border: Border(
          top: BorderSide(color: AppColors.border),
        ),
      ),
      child: ElevatedButton(
        onPressed: _selectedGoal == null || _isSaving
            ? null
            : _finishOnboarding,
        style: ElevatedButton.styleFrom(
          disabledBackgroundColor: AppColors.card,
          disabledForegroundColor: AppColors.textSecondary,
        ),
        child: _isSaving
            ? const SizedBox(
          width: 22,
          height: 22,
          child: CircularProgressIndicator(
            color: Colors.white,
            strokeWidth: 2.5,
          ),
        )
            : const Text('Start Learning'),
      ),
    );
  }
}

class _GoalOption {
  final int minutes;
  final String title;
  final String description;
  final bool recommended;

  const _GoalOption({
    required this.minutes,
    required this.title,
    required this.description,
    this.recommended = false,
  });
}
import 'package:flutter/material.dart';
import '../../../core/routes/app_routes.dart';
import '../../../core/theme/app_colors.dart';
import '../model/onboarding_setup.dart';


class LevelSelectionScreen extends StatefulWidget {
  final OnboardingSetup setup;

  const LevelSelectionScreen({
    super.key,
    required this.setup,
  });

  @override
  State<LevelSelectionScreen> createState() =>
      _LevelSelectionScreenState();
}

class _LevelSelectionScreenState
    extends State<LevelSelectionScreen> {
  String? _selectedLevel;

  final List<_LevelOption> _levels = const [
    _LevelOption(
      id: 'absolute_beginner',
      title: 'Absolute Beginner',
      description: 'I am completely new to this language.',
      icon: Icons.emoji_people_rounded,
    ),
    _LevelOption(
      id: 'beginner',
      title: 'Beginner',
      description: 'I understand a few words and sentences.',
      icon: Icons.menu_book_rounded,
    ),
    _LevelOption(
      id: 'intermediate',
      title: 'Intermediate',
      description: 'I can have simple conversations.',
      icon: Icons.forum_rounded,
    ),
  ];

  void _continue() {
    if (_selectedLevel == null) return;

    Navigator.pushNamed(
      context,
      AppRoutes.dailyGoal,
      arguments: widget.setup.copyWith(
        level: _selectedLevel,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                  padding: const EdgeInsets.fromLTRB(22, 14, 22, 30),
                  children: [
                    _buildTopBar(),
                    const SizedBox(height: 26),
                    const Text(
                      'What is your\ncurrent level?',
                      style: TextStyle(
                        fontSize: 31,
                        height: 1.12,
                        fontWeight: FontWeight.w800,
                        letterSpacing: -0.7,
                      ),
                    ),
                    const SizedBox(height: 10),
                    Text(
                      'We will personalize your '
                          '${widget.setup.learningLanguage.name} lessons.',
                      style: const TextStyle(
                        color: AppColors.textSecondary,
                        fontSize: 14,
                        height: 1.5,
                      ),
                    ),
                    const SizedBox(height: 20),
                    _buildProgress(),
                    const SizedBox(height: 30),
                    ..._levels.map(_buildLevelCard),
                  ],
                ),
              ),
              _buildBottomButton(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTopBar() {
    return Row(
      children: [
        IconButton(
          onPressed: () => Navigator.pop(context),
          style: IconButton.styleFrom(
            backgroundColor: AppColors.card,
          ),
          icon: const Icon(Icons.arrow_back_rounded),
        ),
        const Spacer(),
        const Text(
          'Step 3 of 4',
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
        value: 0.75,
        minHeight: 6,
        backgroundColor: AppColors.card,
        valueColor: AlwaysStoppedAnimation(AppColors.primary),
      ),
    );
  }

  Widget _buildLevelCard(_LevelOption level) {
    final selected = _selectedLevel == level.id;

    return AnimatedContainer(
      duration: const Duration(milliseconds: 200),
      margin: const EdgeInsets.only(bottom: 14),
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
        onTap: () {
          setState(() {
            _selectedLevel = level.id;
          });
        },
        borderRadius: BorderRadius.circular(20),
        child: Padding(
          padding: const EdgeInsets.all(17),
          child: Row(
            children: [
              Container(
                width: 52,
                height: 52,
                decoration: BoxDecoration(
                  color: AppColors.primary.withValues(alpha: 0.12),
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Icon(
                  level.icon,
                  color: AppColors.primaryLight,
                ),
              ),
              const SizedBox(width: 15),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      level.title,
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    const SizedBox(height: 5),
                    Text(
                      level.description,
                      style: const TextStyle(
                        color: AppColors.textSecondary,
                        fontSize: 13,
                        height: 1.35,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 8),
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
        onPressed: _selectedLevel == null ? null : _continue,
        style: ElevatedButton.styleFrom(
          disabledBackgroundColor: AppColors.card,
          disabledForegroundColor: AppColors.textSecondary,
        ),
        child: const Text('Continue'),
      ),
    );
  }
}

class _LevelOption {
  final String id;
  final String title;
  final String description;
  final IconData icon;

  const _LevelOption({
    required this.id,
    required this.title,
    required this.description,
    required this.icon,
  });
}
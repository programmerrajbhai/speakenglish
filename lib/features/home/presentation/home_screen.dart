import 'package:flutter/material.dart';

import '../../../core/theme/app_colors.dart';
import '../../onboarding/model/onboarding_setup.dart';


class HomeScreen extends StatelessWidget {
  final OnboardingSetup setup;
  final VoidCallback onOpenLearn;
  final VoidCallback onOpenTutor;
  final VoidCallback onOpenProgress;

  const HomeScreen({
    super.key,
    required this.setup,
    required this.onOpenLearn,
    required this.onOpenTutor,
    required this.onOpenProgress,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: Stack(
        children: [
          const _HomeBackground(),
          SafeArea(
            bottom: false,
            child: CustomScrollView(
              physics: const BouncingScrollPhysics(),
              slivers: [
                SliverPadding(
                  padding: const EdgeInsets.fromLTRB(20, 18, 20, 30),
                  sliver: SliverList(
                    delegate: SliverChildListDelegate([
                      _buildHeader(context),
                      const SizedBox(height: 24),
                      _buildAiTutorBanner(),
                      const SizedBox(height: 18),
                      _buildFeatureGrid(),
                      const SizedBox(height: 18),
                      _buildBottomTutorCard(),
                      const SizedBox(height: 15),
                      _buildDailyProgress(),
                    ]),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildHeader(BuildContext context) {
    return Row(
      children: [
        Container(
          width: 43,
          height: 43,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            gradient: const LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                Color(0xFFFF5E57),
                Color(0xFF8E1019),
              ],
            ),
            border: Border.all(
              color: Colors.white.withValues(alpha: 0.28),
            ),
            boxShadow: [
              BoxShadow(
                color: AppColors.primary.withValues(alpha: 0.4),
                blurRadius: 18,
              ),
            ],
          ),
          child: const Icon(
            Icons.graphic_eq_rounded,
            color: Colors.white,
            size: 25,
          ),
        ),
        const SizedBox(width: 11),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'SpeakEnglish',
                style: TextStyle(
                  fontSize: 19,
                  fontWeight: FontWeight.w800,
                  letterSpacing: -0.4,
                ),
              ),
              const SizedBox(height: 2),
              Text(
                '${setup.nativeLanguage.flag}  →  '
                    '${setup.learningLanguage.flag}  '
                    '${setup.learningLanguage.name}',
                style: const TextStyle(
                  color: AppColors.textSecondary,
                  fontSize: 11,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
        ),
        IconButton(
          tooltip: 'Course information',
          onPressed: () => _showCourseInformation(context),
          style: IconButton.styleFrom(
            fixedSize: const Size(43, 43),
            backgroundColor: Colors.white.withValues(alpha: 0.06),
            side: BorderSide(
              color: Colors.white.withValues(alpha: 0.12),
            ),
          ),
          icon: const Icon(
            Icons.settings_outlined,
            color: Colors.white,
            size: 21,
          ),
        ),
      ],
    );
  }

  Widget _buildAiTutorBanner() {
    return InkWell(
      onTap: onOpenTutor,
      borderRadius: BorderRadius.circular(24),
      child: Container(
        height: 171,
        clipBehavior: Clip.antiAlias,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(24),
          border: Border.all(
            color: Colors.white.withValues(alpha: 0.15),
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.35),
              blurRadius: 24,
              offset: const Offset(0, 12),
            ),
          ],
          gradient: const LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              Color(0xFF25191B),
              Color(0xFF180D0F),
              Color(0xFF441419),
            ],
          ),
        ),
        child: Stack(
          children: [
            Positioned(
              right: -34,
              top: -45,
              child: Container(
                width: 190,
                height: 190,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  gradient: RadialGradient(
                    colors: [
                      AppColors.primary.withValues(alpha: 0.43),
                      AppColors.primary.withValues(alpha: 0.08),
                      Colors.transparent,
                    ],
                  ),
                ),
              ),
            ),
            Positioned(
              right: 20,
              bottom: 18,
              child: _buildTutorRobot(),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 18, 145, 17),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'AI Conversation Tutor',
                    style: TextStyle(
                      fontSize: 19,
                      fontWeight: FontWeight.w800,
                      letterSpacing: -0.4,
                    ),
                  ),
                  const SizedBox(height: 6),
                  const Text(
                    'Practice real conversations\nwith your personal tutor.',
                    style: TextStyle(
                      color: AppColors.textSecondary,
                      fontSize: 12,
                      height: 1.4,
                    ),
                  ),
                  const Spacer(),
                  Container(
                    height: 41,
                    padding: const EdgeInsets.symmetric(
                      horizontal: 14,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.black.withValues(alpha: 0.25),
                      borderRadius: BorderRadius.circular(14),
                      border: Border.all(
                        color: Colors.white.withValues(alpha: 0.6),
                      ),
                    ),
                    child: const Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(
                          Icons.auto_awesome_rounded,
                          color: AppColors.primaryLight,
                          size: 17,
                        ),
                        SizedBox(width: 8),
                        Text(
                          'Chat with AI',
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w800,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTutorRobot() {
    return SizedBox(
      width: 110,
      height: 125,
      child: Stack(
        alignment: Alignment.center,
        children: [
          Container(
            width: 105,
            height: 105,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              gradient: RadialGradient(
                colors: [
                  AppColors.primary.withValues(alpha: 0.42),
                  Colors.transparent,
                ],
              ),
            ),
          ),
          Container(
            width: 79,
            height: 88,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(28),
              gradient: const LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  Color(0xFFF6E9EA),
                  Color(0xFF9E8B8E),
                  Color(0xFF342326),
                ],
              ),
              border: Border.all(
                color: AppColors.primaryLight,
                width: 1.3,
              ),
              boxShadow: [
                BoxShadow(
                  color: AppColors.primary.withValues(alpha: 0.45),
                  blurRadius: 20,
                ),
              ],
            ),
            child: Center(
              child: Container(
                width: 55,
                height: 39,
                decoration: BoxDecoration(
                  color: const Color(0xFF1C1214),
                  borderRadius: BorderRadius.circular(15),
                ),
                child: const Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    _RobotEye(),
                    SizedBox(width: 10),
                    _RobotEye(),
                  ],
                ),
              ),
            ),
          ),
          Positioned(
            top: 5,
            child: Container(
              width: 4,
              height: 17,
              decoration: BoxDecoration(
                color: AppColors.primaryLight,
                borderRadius: BorderRadius.circular(5),
              ),
            ),
          ),
          Positioned(
            top: 0,
            child: Container(
              width: 10,
              height: 10,
              decoration: const BoxDecoration(
                color: AppColors.primaryLight,
                shape: BoxShape.circle,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFeatureGrid() {
    return Column(
      children: [
        Row(
          children: [
            Expanded(
              child: _FeatureCard(
                title: 'Speaking Practice',
                subtitle: 'Learn to speak real sentences',
                icon: Icons.mic_rounded,
                gradient: const [
                  Color(0xFF6428A8),
                  Color(0xFFFF3B55),
                  Color(0xFF3D171D),
                ],
                onTap: onOpenLearn,
              ),
            ),
            const SizedBox(width: 13),
            Expanded(
              child: _FeatureCard(
                title: 'Audio Passage',
                subtitle: 'Listen and learn from real audio',
                icon: Icons.headphones_rounded,
                onTap: onOpenLearn,
              ),
            ),
          ],
        ),
        const SizedBox(height: 13),
        Row(
          children: [
            Expanded(
              child: _FeatureCard(
                title: 'Lessons',
                subtitle: 'Structured lessons to build skills',
                icon: Icons.school_rounded,
                onTap: onOpenLearn,
              ),
            ),
            const SizedBox(width: 13),
            Expanded(
              child: _FeatureCard(
                title: 'Vocabulary',
                subtitle: 'Expand words with practice',
                icon: Icons.menu_book_rounded,
                onTap: onOpenLearn,
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildBottomTutorCard() {
    return InkWell(
      onTap: onOpenTutor,
      borderRadius: BorderRadius.circular(21),
      child: Container(
        height: 86,
        padding: const EdgeInsets.symmetric(horizontal: 19),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(21),
          border: Border.all(
            color: Colors.white.withValues(alpha: 0.14),
          ),
          gradient: const LinearGradient(
            colors: [
              Color(0xFF251C1E),
              Color(0xFF342A2C),
              Color(0xFF171012),
            ],
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.25),
              blurRadius: 18,
              offset: const Offset(0, 9),
            ),
          ],
        ),
        child: Row(
          children: [
            Container(
              width: 48,
              height: 48,
              decoration: BoxDecoration(
                color: AppColors.primary.withValues(alpha: 0.12),
                borderRadius: BorderRadius.circular(16),
              ),
              child: const Icon(
                Icons.psychology_alt_rounded,
                color: AppColors.primaryLight,
                size: 29,
              ),
            ),
            const SizedBox(width: 14),
            const Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'AI Language Tutor',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                  SizedBox(height: 5),
                  Text(
                    'Improve your language skills',
                    style: TextStyle(
                      color: AppColors.textSecondary,
                      fontSize: 11,
                    ),
                  ),
                ],
              ),
            ),
            Container(
              width: 35,
              height: 35,
              decoration: BoxDecoration(
                color: AppColors.primary.withValues(alpha: 0.13),
                shape: BoxShape.circle,
              ),
              child: const Icon(
                Icons.arrow_forward_rounded,
                color: AppColors.primaryLight,
                size: 19,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDailyProgress() {
    return InkWell(
      onTap: onOpenProgress,
      borderRadius: BorderRadius.circular(18),
      child: Container(
        padding: const EdgeInsets.all(15),
        decoration: BoxDecoration(
          color: Colors.white.withValues(alpha: 0.035),
          borderRadius: BorderRadius.circular(18),
          border: Border.all(
            color: Colors.white.withValues(alpha: 0.09),
          ),
        ),
        child: Row(
          children: [
            const Icon(
              Icons.track_changes_rounded,
              color: AppColors.primaryLight,
            ),
            const SizedBox(width: 11),
            Expanded(
              child: Text(
                'Daily goal: 0 of ${setup.dailyGoal} minutes',
                style: const TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
            const Icon(
              Icons.arrow_forward_ios_rounded,
              size: 14,
              color: AppColors.textSecondary,
            ),
          ],
        ),
      ),
    );
  }

  void _showCourseInformation(BuildContext context) {
    showModalBottomSheet<void>(
      context: context,
      backgroundColor: AppColors.surface,
      showDragHandle: true,
      builder: (bottomSheetContext) {
        return SafeArea(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(22, 4, 22, 25),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Text(
                  'Current Course',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w800,
                  ),
                ),
                const SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      setup.nativeLanguage.flag,
                      style: const TextStyle(fontSize: 39),
                    ),
                    const Padding(
                      padding: EdgeInsets.symmetric(horizontal: 18),
                      child: Icon(
                        Icons.arrow_forward_rounded,
                        color: AppColors.primary,
                      ),
                    ),
                    Text(
                      setup.learningLanguage.flag,
                      style: const TextStyle(fontSize: 39),
                    ),
                  ],
                ),
                const SizedBox(height: 15),
                Text(
                  '${setup.nativeLanguage.name} to '
                      '${setup.learningLanguage.name}',
                  style: const TextStyle(
                    fontSize: 17,
                    fontWeight: FontWeight.w800,
                  ),
                ),
                const SizedBox(height: 7),
                Text(
                  '${setup.dailyGoal} minutes daily goal',
                  style: const TextStyle(
                    color: AppColors.textSecondary,
                  ),
                ),
                const SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () {
                    Navigator.pop(bottomSheetContext);
                  },
                  child: const Text('Done'),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

class _FeatureCard extends StatelessWidget {
  final String title;
  final String subtitle;
  final IconData icon;
  final VoidCallback onTap;
  final List<Color>? gradient;

  const _FeatureCard({
    required this.title,
    required this.subtitle,
    required this.icon,
    required this.onTap,
    this.gradient,
  });

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 0.96,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(23),
        child: Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(23),
            border: Border.all(
              color: Colors.white.withValues(alpha: 0.14),
            ),
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: gradient ??
                  const [
                    Color(0xFF271A1C),
                    Color(0xFF171012),
                  ],
            ),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.24),
                blurRadius: 16,
                offset: const Offset(0, 8),
              ),
            ],
          ),
          child: Stack(
            children: [
              Positioned(
                right: 0,
                top: 0,
                child: Icon(
                  Icons.north_east_rounded,
                  color: Colors.white.withValues(alpha: 0.75),
                  size: 18,
                ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    width: 47,
                    height: 47,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: const Color(0xFF241416),
                      border: Border.all(
                        color: AppColors.primaryLight,
                        width: 1.4,
                      ),
                      boxShadow: [
                        BoxShadow(
                          color:
                          AppColors.primary.withValues(alpha: 0.4),
                          blurRadius: 14,
                        ),
                      ],
                    ),
                    child: Icon(
                      icon,
                      color: AppColors.primaryLight,
                      size: 23,
                    ),
                  ),
                  const Spacer(),
                  Text(
                    title,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                  const SizedBox(height: 6),
                  Text(
                    subtitle,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      color: AppColors.textSecondary,
                      fontSize: 10,
                      height: 1.35,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _RobotEye extends StatelessWidget {
  const _RobotEye();

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 9,
      height: 9,
      decoration: BoxDecoration(
        color: AppColors.primaryLight,
        shape: BoxShape.circle,
        boxShadow: [
          BoxShadow(
            color: AppColors.primary,
            blurRadius: 7,
          ),
        ],
      ),
    );
  }
}

class _HomeBackground extends StatelessWidget {
  const _HomeBackground();

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(color: AppColors.background),
        Positioned(
          top: -160,
          left: -80,
          right: -80,
          child: Container(
            height: 330,
            decoration: BoxDecoration(
              gradient: RadialGradient(
                colors: [
                  const Color(0xFF7A2A30).withValues(alpha: 0.55),
                  const Color(0xFF3A171B).withValues(alpha: 0.24),
                  Colors.transparent,
                ],
              ),
            ),
          ),
        ),
        Positioned(
          bottom: -100,
          right: -100,
          child: Container(
            width: 260,
            height: 260,
            decoration: BoxDecoration(
              gradient: RadialGradient(
                colors: [
                  AppColors.primary.withValues(alpha: 0.16),
                  Colors.transparent,
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
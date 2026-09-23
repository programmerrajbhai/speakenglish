import 'package:flutter/material.dart';

import '../../../core/theme/app_colors.dart';
import '../../onboarding/model/onboarding_setup.dart';

class HomeScreen extends StatelessWidget {
  final OnboardingSetup setup;
  final VoidCallback onOpenLearn;
  final VoidCallback onOpenTutor;
  final VoidCallback onOpenProgress;

  final VoidCallback onOpenSpeaking;

  const HomeScreen({
    super.key,
    required this.setup,
    required this.onOpenLearn,
    required this.onOpenSpeaking,
    required this.onOpenTutor,
    required this.onOpenProgress,
  });

  static const Color _background = Color(0xFF10090B);
  static const Color _surface = Color(0xFF1B1114);
  static const Color _surfaceLight = Color(0xFF26181C);
  static const Color _red = Color(0xFFFF4757);
  static const Color _redDark = Color(0xFF8F1722);
  static const Color _pink = Color(0xFFFF4F81);
  static const Color _purple = Color(0xFF9C4DFF);
  static const Color _orange = Color(0xFFFF8652);
  static const Color _blue = Color(0xFF5B8CFF);
  static const Color _textSecondary = Color(0xFFBBAEB1);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: _background,
      body: Stack(
        children: [
          const _PremiumBackground(),
          SafeArea(
            bottom: false,
            child: CustomScrollView(
              physics: const BouncingScrollPhysics(),
              slivers: [
                SliverPadding(
                  padding: const EdgeInsets.fromLTRB(
                    18,
                    16,
                    18,
                    30,
                  ),
                  sliver: SliverList(
                    delegate: SliverChildListDelegate([
                      _buildHeader(context),
                      const SizedBox(height: 22),
                      _buildTutorBanner(),
                      const SizedBox(height: 25),
                      _buildSectionTitle(
                        title: 'Start learning',
                        subtitle: 'Choose how you want to practice',
                      ),
                      const SizedBox(height: 14),
                      _buildFeatureGrid(),
                      const SizedBox(height: 18),
                      _buildLanguageTutorCard(),
                      const SizedBox(height: 14),
                      _buildDailyGoalCard(),
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
          width: 46,
          height: 46,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            gradient: const LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                Color(0xFFFF6B62),
                Color(0xFFE62F42),
                Color(0xFF8C1420),
              ],
            ),
            border: Border.all(
              color: Colors.white.withValues(alpha: 0.20),
            ),
            boxShadow: [
              BoxShadow(
                color: _red.withValues(alpha: 0.35),
                blurRadius: 20,
                spreadRadius: 1,
              ),
            ],
          ),
          child: const Icon(
            Icons.graphic_eq_rounded,
            color: Colors.white,
            size: 26,
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'SpeakEnglish',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 19,
                  fontWeight: FontWeight.w900,
                  letterSpacing: -0.4,
                ),
              ),
              const SizedBox(height: 4),
              Row(
                children: [
                  Text(
                    setup.nativeLanguage.flag,
                    style: const TextStyle(fontSize: 13),
                  ),
                  const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 6),
                    child: Icon(
                      Icons.arrow_forward_rounded,
                      color: _textSecondary,
                      size: 13,
                    ),
                  ),
                  Text(
                    setup.learningLanguage.flag,
                    style: const TextStyle(fontSize: 13),
                  ),
                  const SizedBox(width: 6),
                  Flexible(
                    child: Text(
                      setup.learningLanguage.name,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        color: _textSecondary,
                        fontSize: 11,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
        IconButton(
          tooltip: 'Course information',
          onPressed: () => _showCourseInformation(context),
          style: IconButton.styleFrom(
            fixedSize: const Size(43, 43),
            backgroundColor:
            Colors.white.withValues(alpha: 0.055),
            side: BorderSide(
              color: Colors.white.withValues(alpha: 0.12),
            ),
          ),
          icon: const Icon(
            Icons.tune_rounded,
            color: Colors.white,
            size: 21,
          ),
        ),
      ],
    );
  }

  Widget _buildTutorBanner() {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onOpenTutor,
        borderRadius: BorderRadius.circular(26),
        child: Ink(
          height: 178,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(26),
            border: Border.all(
              color: Colors.white.withValues(alpha: 0.14),
            ),
            gradient: const LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                Color(0xFF2B1B20),
                Color(0xFF1B0F13),
                Color(0xFF3D121A),
              ],
            ),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.32),
                blurRadius: 25,
                offset: const Offset(0, 13),
              ),
              BoxShadow(
                color: _red.withValues(alpha: 0.10),
                blurRadius: 30,
              ),
            ],
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(26),
            child: Stack(
              children: [
                Positioned(
                  right: -65,
                  top: -80,
                  child: Container(
                    width: 255,
                    height: 255,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      gradient: RadialGradient(
                        colors: [
                          _red.withValues(alpha: 0.40),
                          _red.withValues(alpha: 0.08),
                          Colors.transparent,
                        ],
                      ),
                    ),
                  ),
                ),
                Positioned(
                  left: -50,
                  bottom: -90,
                  child: Container(
                    width: 190,
                    height: 190,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      gradient: RadialGradient(
                        colors: [
                          _purple.withValues(alpha: 0.15),
                          Colors.transparent,
                        ],
                      ),
                    ),
                  ),
                ),
                Positioned(
                  right: 18,
                  bottom: 17,
                  child: const _TutorRobot(),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(
                    19,
                    18,
                    137,
                    18,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 9,
                          vertical: 5,
                        ),
                        decoration: BoxDecoration(
                          color: _red.withValues(alpha: 0.14),
                          borderRadius: BorderRadius.circular(20),
                          border: Border.all(
                            color: _red.withValues(alpha: 0.35),
                          ),
                        ),
                        child: const Text(
                          'AI POWERED',
                          style: TextStyle(
                            color: Color(0xFFFF8992),
                            fontSize: 9,
                            fontWeight: FontWeight.w900,
                            letterSpacing: 0.8,
                          ),
                        ),
                      ),
                      const SizedBox(height: 10),
                      const Text(
                        'AI Conversation\nTutor',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                          height: 1.08,
                          fontWeight: FontWeight.w900,
                          letterSpacing: -0.5,
                        ),
                      ),
                      const Spacer(),
                      Container(
                        height: 39,
                        padding: const EdgeInsets.symmetric(
                          horizontal: 13,
                        ),
                        decoration: BoxDecoration(
                          color: Colors.black.withValues(alpha: 0.25),
                          borderRadius: BorderRadius.circular(13),
                          border: Border.all(
                            color:
                            Colors.white.withValues(alpha: 0.34),
                          ),
                        ),
                        child: const Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Icon(
                              Icons.auto_awesome_rounded,
                              color: Color(0xFFFF7B85),
                              size: 16,
                            ),
                            SizedBox(width: 7),
                            Text(
                              'Chat with AI',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 11,
                                fontWeight: FontWeight.w800,
                              ),
                            ),
                            SizedBox(width: 7),
                            Icon(
                              Icons.arrow_forward_rounded,
                              color: Colors.white,
                              size: 15,
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
        ),
      ),
    );
  }

  Widget _buildSectionTitle({
    required String title,
    required String subtitle,
  }) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                  fontWeight: FontWeight.w900,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                subtitle,
                style: const TextStyle(
                  color: _textSecondary,
                  fontSize: 11,
                ),
              ),
            ],
          ),
        ),
        TextButton(
          onPressed: onOpenLearn,
          child: const Text('View all'),
        ),
      ],
    );
  }

  Widget _buildFeatureGrid() {
    return Column(
      children: [
        Row(
          children: [
            Expanded(
              child: _FeatureCard(
                title: 'Speaking\nPractice',
                subtitle: 'Build confidence with real sentences',
                icon: Icons.mic_rounded,
                accent: _pink,
                colors: const [
                  Color(0xFF5E208F),
                  Color(0xFFE72E68),
                  Color(0xFF39151D),
                ],
                onTap: onOpenSpeaking,
              ),
            ),
            const SizedBox(width: 13),
            Expanded(
              child: _FeatureCard(
                title: 'Audio\nPassage',
                subtitle: 'Listen and understand naturally',
                icon: Icons.headphones_rounded,
                accent: _orange,
                colors: const [
                  Color(0xFF2A191A),
                  Color(0xFF27161A),
                  Color(0xFF171012),
                ],
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
                title: 'Structured\nLessons',
                subtitle: 'Learn English step by step',
                icon: Icons.school_rounded,
                accent: _blue,
                colors: const [
                  Color(0xFF191A27),
                  Color(0xFF21171D),
                  Color(0xFF161012),
                ],
                onTap: onOpenLearn,
              ),
            ),
            const SizedBox(width: 13),
            Expanded(
              child: _FeatureCard(
                title: 'Daily\nVocabulary',
                subtitle: 'Grow useful words every day',
                icon: Icons.menu_book_rounded,
                accent: _purple,
                colors: const [
                  Color(0xFF24172D),
                  Color(0xFF21151D),
                  Color(0xFF161012),
                ],
                onTap: onOpenLearn,
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildLanguageTutorCard() {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onOpenTutor,
        borderRadius: BorderRadius.circular(21),
        child: Ink(
          height: 84,
          padding: const EdgeInsets.symmetric(horizontal: 16),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(21),
            border: Border.all(
              color: Colors.white.withValues(alpha: 0.11),
            ),
            gradient: const LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                Color(0xFF281A1E),
                Color(0xFF21171A),
                Color(0xFF160E11),
              ],
            ),
          ),
          child: Row(
            children: [
              Container(
                width: 48,
                height: 48,
                decoration: BoxDecoration(
                  color: _red.withValues(alpha: 0.13),
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(
                    color: _red.withValues(alpha: 0.22),
                  ),
                ),
                child: const Icon(
                  Icons.psychology_alt_rounded,
                  color: Color(0xFFFF7882),
                  size: 28,
                ),
              ),
              const SizedBox(width: 13),
              const Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'AI Language Tutor',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 15,
                        fontWeight: FontWeight.w900,
                      ),
                    ),
                    SizedBox(height: 5),
                    Text(
                      'Ask questions and improve your skills',
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        color: _textSecondary,
                        fontSize: 10,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 10),
              Container(
                width: 37,
                height: 37,
                decoration: BoxDecoration(
                  color: _red.withValues(alpha: 0.13),
                  shape: BoxShape.circle,
                ),
                child: const Icon(
                  Icons.arrow_forward_rounded,
                  color: Color(0xFFFF7882),
                  size: 19,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildDailyGoalCard() {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onOpenProgress,
        borderRadius: BorderRadius.circular(19),
        child: Ink(
          padding: const EdgeInsets.all(15),
          decoration: BoxDecoration(
            color: Colors.white.withValues(alpha: 0.035),
            borderRadius: BorderRadius.circular(19),
            border: Border.all(
              color: Colors.white.withValues(alpha: 0.09),
            ),
          ),
          child: Row(
            children: [
              Container(
                width: 43,
                height: 43,
                decoration: BoxDecoration(
                  color: _orange.withValues(alpha: 0.12),
                  borderRadius: BorderRadius.circular(14),
                ),
                child: const Icon(
                  Icons.track_changes_rounded,
                  color: _orange,
                  size: 23,
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Daily learning goal',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 13,
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      '${setup.dailyGoal} minutes every day',
                      style: const TextStyle(
                        color: _textSecondary,
                        fontSize: 10,
                      ),
                    ),
                  ],
                ),
              ),
              const Text(
                'View progress',
                style: TextStyle(
                  color: Color(0xFFFF7882),
                  fontSize: 10,
                  fontWeight: FontWeight.w800,
                ),
              ),
              const SizedBox(width: 5),
              const Icon(
                Icons.arrow_forward_ios_rounded,
                color: Color(0xFFFF7882),
                size: 13,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _showCourseInformation(
      BuildContext context,
      ) async {
    await showModalBottomSheet<void>(
      context: context,
      backgroundColor: _surface,
      showDragHandle: true,
      useSafeArea: true,
      builder: (bottomSheetContext) {
        return Padding(
          padding: const EdgeInsets.fromLTRB(22, 2, 22, 24),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text(
                'Current Course',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                  fontWeight: FontWeight.w900,
                ),
              ),
              const SizedBox(height: 7),
              const Text(
                'Your selected learning journey',
                style: TextStyle(
                  color: _textSecondary,
                  fontSize: 11,
                ),
              ),
              const SizedBox(height: 21),
              Container(
                padding: const EdgeInsets.all(18),
                decoration: BoxDecoration(
                  color: _surfaceLight,
                  borderRadius: BorderRadius.circular(21),
                  border: Border.all(
                    color: Colors.white.withValues(alpha: 0.10),
                  ),
                ),
                child: Row(
                  children: [
                    Expanded(
                      child: _LanguageInformation(
                        flag: setup.nativeLanguage.flag,
                        name: setup.nativeLanguage.name,
                        label: 'I speak',
                      ),
                    ),
                    Container(
                      width: 37,
                      height: 37,
                      decoration: BoxDecoration(
                        color: _red.withValues(alpha: 0.13),
                        shape: BoxShape.circle,
                      ),
                      child: const Icon(
                        Icons.arrow_forward_rounded,
                        color: _red,
                        size: 19,
                      ),
                    ),
                    Expanded(
                      child: _LanguageInformation(
                        flag: setup.learningLanguage.flag,
                        name: setup.learningLanguage.name,
                        label: 'I learn',
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 14),
              Container(
                padding: const EdgeInsets.all(15),
                decoration: BoxDecoration(
                  color: _orange.withValues(alpha: 0.08),
                  borderRadius: BorderRadius.circular(17),
                  border: Border.all(
                    color: _orange.withValues(alpha: 0.22),
                  ),
                ),
                child: Row(
                  children: [
                    const Icon(
                      Icons.schedule_rounded,
                      color: _orange,
                    ),
                    const SizedBox(width: 11),
                    Text(
                      '${setup.dailyGoal} minutes daily goal',
                      style: const TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.pop(bottomSheetContext);
                  },
                  child: const Text('Done'),
                ),
              ),
            ],
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
  final Color accent;
  final List<Color> colors;
  final VoidCallback onTap;

  const _FeatureCard({
    required this.title,
    required this.subtitle,
    required this.icon,
    required this.accent,
    required this.colors,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 0.96,
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(23),
          child: Ink(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(23),
              border: Border.all(
                color: Colors.white.withValues(alpha: 0.12),
              ),
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: colors,
              ),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withValues(alpha: 0.25),
                  blurRadius: 17,
                  offset: const Offset(0, 9),
                ),
              ],
            ),
            child: Stack(
              children: [
                Positioned(
                  right: -25,
                  top: -25,
                  child: Container(
                    width: 105,
                    height: 105,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      gradient: RadialGradient(
                        colors: [
                          accent.withValues(alpha: 0.20),
                          Colors.transparent,
                        ],
                      ),
                    ),
                  ),
                ),
                Positioned(
                  right: 14,
                  top: 14,
                  child: Icon(
                    Icons.north_east_rounded,
                    color: Colors.white.withValues(alpha: 0.68),
                    size: 17,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(15),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        width: 47,
                        height: 47,
                        decoration: BoxDecoration(
                          color: const Color(0xFF1E1215),
                          shape: BoxShape.circle,
                          border: Border.all(
                            color: accent.withValues(alpha: 0.90),
                            width: 1.3,
                          ),
                          boxShadow: [
                            BoxShadow(
                              color: accent.withValues(alpha: 0.30),
                              blurRadius: 15,
                            ),
                          ],
                        ),
                        child: Icon(
                          icon,
                          color: accent,
                          size: 23,
                        ),
                      ),
                      const Spacer(),
                      Text(
                        title,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 14,
                          height: 1.15,
                          fontWeight: FontWeight.w900,
                        ),
                      ),
                      const SizedBox(height: 7),
                      Text(
                        subtitle,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                          color: HomeScreen._textSecondary,
                          fontSize: 9.5,
                          height: 1.35,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _TutorRobot extends StatelessWidget {
  const _TutorRobot();

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 112,
      height: 128,
      child: Stack(
        alignment: Alignment.center,
        children: [
          Container(
            width: 110,
            height: 110,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              gradient: RadialGradient(
                colors: [
                  HomeScreen._red.withValues(alpha: 0.37),
                  Colors.transparent,
                ],
              ),
            ),
          ),
          Positioned(
            top: 19,
            child: Container(
              width: 80,
              height: 90,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(29),
                gradient: const LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [
                    Color(0xFFFFF4F5),
                    Color(0xFFB5A1A5),
                    Color(0xFF3C292D),
                  ],
                ),
                border: Border.all(
                  color: const Color(0xFFFF737E),
                  width: 1.3,
                ),
                boxShadow: [
                  BoxShadow(
                    color:
                    HomeScreen._red.withValues(alpha: 0.43),
                    blurRadius: 21,
                  ),
                ],
              ),
              child: Center(
                child: Container(
                  width: 56,
                  height: 40,
                  decoration: BoxDecoration(
                    color: const Color(0xFF1C1114),
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
          ),
          Positioned(
            top: 7,
            child: Container(
              width: 4,
              height: 18,
              decoration: BoxDecoration(
                color: const Color(0xFFFF737E),
                borderRadius: BorderRadius.circular(5),
              ),
            ),
          ),
          Positioned(
            top: 2,
            child: Container(
              width: 10,
              height: 10,
              decoration: const BoxDecoration(
                color: Color(0xFFFF737E),
                shape: BoxShape.circle,
              ),
            ),
          ),
        ],
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
        color: const Color(0xFFFF737E),
        shape: BoxShape.circle,
        boxShadow: [
          BoxShadow(
            color: HomeScreen._red,
            blurRadius: 8,
            spreadRadius: 1,
          ),
        ],
      ),
    );
  }
}

class _LanguageInformation extends StatelessWidget {
  final String flag;
  final String name;
  final String label;

  const _LanguageInformation({
    required this.flag,
    required this.name,
    required this.label,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          flag,
          style: const TextStyle(fontSize: 34),
        ),
        const SizedBox(height: 7),
        Text(
          label,
          style: const TextStyle(
            color: HomeScreen._textSecondary,
            fontSize: 10,
          ),
        ),
        const SizedBox(height: 3),
        Text(
          name,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          textAlign: TextAlign.center,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 12,
            fontWeight: FontWeight.w800,
          ),
        ),
      ],
    );
  }
}

class _PremiumBackground extends StatelessWidget {
  const _PremiumBackground();

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(color: HomeScreen._background),
        Positioned(
          top: -165,
          left: -85,
          right: -85,
          child: Container(
            height: 350,
            decoration: BoxDecoration(
              gradient: RadialGradient(
                colors: [
                  const Color(0xFF7A2932)
                      .withValues(alpha: 0.48),
                  const Color(0xFF3B171D)
                      .withValues(alpha: 0.20),
                  Colors.transparent,
                ],
              ),
            ),
          ),
        ),
        Positioned(
          bottom: -105,
          right: -105,
          child: Container(
            width: 270,
            height: 270,
            decoration: BoxDecoration(
              gradient: RadialGradient(
                colors: [
                  HomeScreen._purple.withValues(alpha: 0.10),
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
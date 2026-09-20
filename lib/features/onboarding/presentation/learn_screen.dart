import 'package:flutter/material.dart';
import '../../../core/theme/app_colors.dart';
import '../../lesson_test/presentation/lesson_test_screen.dart';
import '../../listening/presentation/listening_screen.dart';
import '../../practice/presentation/practice_screen.dart';
import '../../speaking/presentation/speaking_rules_flow_screen.dart';
import '../../speaking/presentation/speaking_screen.dart';
import '../conversation/presentation/conversation_screen.dart';
import '../lessons/data/lessons_data.dart';
import '../lessons/services/lesson_progress_service.dart';
import '../model/onboarding_setup.dart';

import 'lesson_flow_screen.dart';

class LearnScreen extends StatefulWidget {
  final OnboardingSetup setup;

  const LearnScreen({
    super.key,
    required this.setup,
  });

  @override
  State<LearnScreen> createState() => _LearnScreenState();
}

class _LearnScreenState extends State<LearnScreen> {
  bool _loading = true;

  bool _lessonOneCompleted = false;
  bool _practiceCompleted = false;
  bool _listeningCompleted = false;
  bool _speakingCompleted = false;
  bool _conversationCompleted = false;
  bool _testPassed = false;

  int _practiceScore = 0;
  int _listeningScore = 0;
  int _speakingScore = 0;
  int _conversationScore = 0;
  int _testScore = 0;

  @override
  void initState() {
    super.initState();
    _loadProgress();
  }

  Future<void> _loadProgress() async {
    if (mounted) {
      setState(() {
        _loading = true;
      });
    }

    final lessonId = LessonsData.greetings.id;

    try {
      final results = await Future.wait<Object>([
        LessonProgressService.isLearningCompleted(
          lessonId,
        ),
        LessonProgressService.isPracticeCompleted(
          lessonId,
        ),
        LessonProgressService.getPracticeScore(
          lessonId,
        ),
        LessonProgressService.isListeningCompleted(
          lessonId,
        ),
        LessonProgressService.getListeningScore(
          lessonId,
        ),
        LessonProgressService.isSpeakingCompleted(
          lessonId,
        ),
        LessonProgressService.getSpeakingScore(
          lessonId,
        ),
        LessonProgressService.isConversationCompleted(
          lessonId,
        ),
        LessonProgressService.getConversationScore(
          lessonId,
        ),
        LessonProgressService.isTestPassed(
          lessonId,
        ),
        LessonProgressService.getTestScore(
          lessonId,
        ),
      ]);

      if (!mounted) return;

      setState(() {
        _lessonOneCompleted = results[0] as bool;

        _practiceCompleted = results[1] as bool;
        _practiceScore = results[2] as int;

        _listeningCompleted = results[3] as bool;
        _listeningScore = results[4] as int;

        _speakingCompleted = results[5] as bool;
        _speakingScore = results[6] as int;

        _conversationCompleted = results[7] as bool;
        _conversationScore = results[8] as int;

        _testPassed = results[9] as bool;
        _testScore = results[10] as int;

        _loading = false;
      });
    } catch (error) {
      if (!mounted) return;

      setState(() {
        _loading = false;
      });

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            'Could not load progress: $error',
          ),
        ),
      );
    }
  }

  Future<void> _openFirstLesson() async {
    final completed = await Navigator.push<bool>(
      context,
      MaterialPageRoute(
        builder: (_) => LessonFlowScreen(
          lesson: LessonsData.greetings,
          setup: widget.setup,
        ),
      ),
    );

    if (completed == true) {
      await _loadProgress();
    }
  }

  Future<void> _openPractice() async {
    if (!_lessonOneCompleted) return;

    final completed = await Navigator.push<bool>(
      context,
      MaterialPageRoute(
        builder: (_) => PracticeScreen(
          lesson: LessonsData.greetings,
          setup: widget.setup,
        ),
      ),
    );

    if (completed == true) {
      await _loadProgress();
    }
  }

  Future<void> _openListening() async {
    if (!_practiceCompleted) return;

    final completed = await Navigator.push<bool>(
      context,
      MaterialPageRoute(
        builder: (_) => ListeningScreen(
          lesson: LessonsData.greetings,
          setup: widget.setup,
        ),
      ),
    );

    if (completed == true) {
      await _loadProgress();
    }
  }

  Future<void> _openSpeaking() async {
    await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => SpeakingRulesFlowScreen(
          setup: widget.setup,
        ),
      ),
    );
  }



  Future<void> _openConversation() async {
    if (!_speakingCompleted) return;

    final completed = await Navigator.push<bool>(
      context,
      MaterialPageRoute(
        builder: (_) => ConversationScreen(
          lesson: LessonsData.greetings,
          setup: widget.setup,
        ),
      ),
    );

    if (completed == true) {
      await _loadProgress();
    }
  }

  Future<void> _openLessonTest() async {
    if (!_conversationCompleted) return;

    final completed = await Navigator.push<bool>(
      context,
      MaterialPageRoute(
        builder: (_) => LessonTestScreen(
          lesson: LessonsData.greetings,
          setup: widget.setup,
        ),
      ),
    );

    if (completed == true) {
      await _loadProgress();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: AppColors.background,
        title: Text(
          'Learn ${widget.setup.learningLanguage.name}',
          style: const TextStyle(
            fontWeight: FontWeight.w800,
          ),
        ),
        actions: [
          IconButton(
            onPressed: _loading ? null : _loadProgress,
            tooltip: 'Refresh progress',
            icon: const Icon(Icons.refresh_rounded),
          ),
        ],
      ),
      body: _loading
          ? const Center(
        child: CircularProgressIndicator(
          color: AppColors.primary,
        ),
      )
          : RefreshIndicator(
        color: AppColors.primary,
        onRefresh: _loadProgress,
        child: ListView(
          physics: const AlwaysScrollableScrollPhysics(
            parent: BouncingScrollPhysics(),
          ),
          padding: const EdgeInsets.fromLTRB(
            20,
            12,
            20,
            35,
          ),
          children: [
            _buildCourseHeader(),
            const SizedBox(height: 25),
            _buildUnitHeader(),
            const SizedBox(height: 15),

            _buildLearningCard(),
            const SizedBox(height: 13),

            _buildPracticeCard(),
            const SizedBox(height: 13),

            _buildListeningCard(),
            const SizedBox(height: 13),

            _buildSpeakingCard(),
            const SizedBox(height: 13),

            _buildConversationCard(),
            const SizedBox(height: 13),

            _buildLessonTestCard(),

            if (_testPassed) ...[
              const SizedBox(height: 25),
              _buildNextUnitUnlocked(),
            ],
          ],
        ),
      ),
    );
  }

  Widget _buildCourseHeader() {
    final totalCompleted = [
      _lessonOneCompleted,
      _practiceCompleted,
      _listeningCompleted,
      _speakingCompleted,
      _conversationCompleted,
      _testPassed,
    ].where((completed) => completed).length;

    final progress = totalCompleted / 6;

    return Container(
      padding: const EdgeInsets.all(19),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            Color(0xFF7E232A),
            Color(0xFF3C171B),
            Color(0xFF211113),
          ],
        ),
        borderRadius: BorderRadius.circular(25),
        border: Border.all(
          color: AppColors.primary.withValues(
            alpha: 0.45,
          ),
        ),
        boxShadow: [
          BoxShadow(
            color: AppColors.primary.withValues(
              alpha: 0.12,
            ),
            blurRadius: 25,
          ),
        ],
      ),
      child: Column(
        children: [
          Row(
            children: [
              Container(
                width: 63,
                height: 63,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: Colors.white.withValues(
                    alpha: 0.08,
                  ),
                  borderRadius: BorderRadius.circular(19),
                ),
                child: Text(
                  widget.setup.learningLanguage.flag,
                  style: const TextStyle(fontSize: 37),
                ),
              ),
              const SizedBox(width: 15),
              Expanded(
                child: Column(
                  crossAxisAlignment:
                  CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'BEGINNER COURSE',
                      style: TextStyle(
                        color: AppColors.primaryLight,
                        fontSize: 10,
                        fontWeight: FontWeight.w800,
                        letterSpacing: 1.1,
                      ),
                    ),
                    const SizedBox(height: 5),
                    Text(
                      'Start speaking '
                          '${widget.setup.learningLanguage.name}',
                      style: const TextStyle(
                        fontSize: 17,
                        height: 1.25,
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                    const SizedBox(height: 5),
                    Text(
                      '$totalCompleted of 6 '
                          'activities completed',
                      style: const TextStyle(
                        color: AppColors.textSecondary,
                        fontSize: 11,
                      ),
                    ),
                  ],
                ),
              ),
              if (_testPassed)
                const Icon(
                  Icons.verified_rounded,
                  color: AppColors.success,
                  size: 30,
                ),
            ],
          ),
          const SizedBox(height: 17),
          ClipRRect(
            borderRadius: BorderRadius.circular(20),
            child: LinearProgressIndicator(
              value: progress,
              minHeight: 7,
              backgroundColor:
              Colors.black.withValues(alpha: 0.25),
              valueColor: const AlwaysStoppedAnimation(
                AppColors.primaryLight,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildUnitHeader() {
    return Row(
      children: [
        const Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Unit 1',
                style: TextStyle(
                  color: AppColors.primaryLight,
                  fontSize: 11,
                  fontWeight: FontWeight.w800,
                ),
              ),
              SizedBox(height: 4),
              Text(
                'Greetings & Introduction',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w800,
                ),
              ),
            ],
          ),
        ),
        Icon(
          _testPassed
              ? Icons.check_circle_rounded
              : Icons.waving_hand_rounded,
          color: _testPassed
              ? AppColors.success
              : AppColors.warning,
          size: 30,
        ),
      ],
    );
  }

  Widget _buildLearningCard() {
    return _ActivityCard(
      step: 'STEP 1',
      title: 'Learn Greetings',
      subtitle: _lessonOneCompleted
          ? 'Learning completed • 15 examples'
          : '15 examples • Normal and slow audio',
      icon: _lessonOneCompleted
          ? Icons.check_rounded
          : Icons.school_rounded,
      state: _lessonOneCompleted
          ? _ActivityState.completed
          : _ActivityState.available,
      onTap: _openFirstLesson,
    );
  }

  Widget _buildPracticeCard() {
    final state = _practiceCompleted
        ? _ActivityState.completed
        : _lessonOneCompleted
        ? _ActivityState.available
        : _ActivityState.locked;

    String subtitle;

    if (_practiceCompleted) {
      subtitle = 'Completed • Score $_practiceScore/7';
    } else if (_lessonOneCompleted) {
      subtitle = '7 exercise types • Ready to practice';
    } else {
      subtitle = 'Complete learning to unlock';
    }

    return _ActivityCard(
      step: 'STEP 2',
      title: 'Mixed Practice',
      subtitle: subtitle,
      icon: _practiceCompleted
          ? Icons.check_rounded
          : _lessonOneCompleted
          ? Icons.psychology_rounded
          : Icons.lock_rounded,
      state: state,
      onTap: _lessonOneCompleted ? _openPractice : null,
    );
  }

  Widget _buildListeningCard() {
    final state = _listeningCompleted
        ? _ActivityState.completed
        : _practiceCompleted
        ? _ActivityState.available
        : _ActivityState.locked;

    String subtitle;

    if (_listeningCompleted) {
      subtitle = 'Completed • Score $_listeningScore/5';
    } else if (_practiceCompleted) {
      subtitle = '5 listening exercises • Ready';
    } else {
      subtitle = 'Complete mixed practice to unlock';
    }

    return _ActivityCard(
      step: 'STEP 3',
      title: 'Listening Practice',
      subtitle: subtitle,
      icon: _listeningCompleted
          ? Icons.check_rounded
          : _practiceCompleted
          ? Icons.headphones_rounded
          : Icons.lock_rounded,
      state: state,
      onTap: _practiceCompleted ? _openListening : null,
    );
  }

  Widget _buildSpeakingCard() {
    final state = _speakingCompleted
        ? _ActivityState.completed
        : _listeningCompleted
        ? _ActivityState.available
        : _ActivityState.locked;

    String subtitle;

    if (_speakingCompleted) {
      subtitle =
      'Completed • Average score $_speakingScore%';
    } else if (_listeningCompleted) {
      subtitle = '5 microphone speaking exercises';
    } else {
      subtitle = 'Complete listening practice to unlock';
    }

    return _ActivityCard(
      step: 'STEP 4',
      title: 'Speaking Practice',
      subtitle: subtitle,
      icon: _speakingCompleted
          ? Icons.check_rounded
          : _listeningCompleted
          ? Icons.mic_rounded
          : Icons.lock_rounded,
      state: state,
      onTap: _listeningCompleted ? _openSpeaking : null,
    );
  }

  Widget _buildConversationCard() {
    final state = _conversationCompleted
        ? _ActivityState.completed
        : _speakingCompleted
        ? _ActivityState.available
        : _ActivityState.locked;

    String subtitle;

    if (_conversationCompleted) {
      subtitle =
      'Completed • Score $_conversationScore/5';
    } else if (_speakingCompleted) {
      subtitle = '5 real-life conversation turns';
    } else {
      subtitle = 'Complete speaking practice to unlock';
    }

    return _ActivityCard(
      step: 'STEP 5',
      title: 'Conversation',
      subtitle: subtitle,
      icon: _conversationCompleted
          ? Icons.check_rounded
          : _speakingCompleted
          ? Icons.forum_rounded
          : Icons.lock_rounded,
      state: state,
      onTap:
      _speakingCompleted ? _openConversation : null,
    );
  }

  Widget _buildLessonTestCard() {
    final state = _testPassed
        ? _ActivityState.completed
        : _conversationCompleted
        ? _ActivityState.available
        : _ActivityState.locked;

    String subtitle;

    if (_testPassed) {
      subtitle = 'Passed • Score $_testScore/10';
    } else if (_conversationCompleted) {
      subtitle = '10 mixed questions • 60% required';
    } else {
      subtitle = 'Complete conversation to unlock';
    }

    return _ActivityCard(
      step: 'STEP 6',
      title: 'Lesson Test',
      subtitle: subtitle,
      icon: _testPassed
          ? Icons.check_rounded
          : _conversationCompleted
          ? Icons.emoji_events_rounded
          : Icons.lock_rounded,
      state: state,
      onTap:
      _conversationCompleted ? _openLessonTest : null,
    );
  }

  Widget _buildNextUnitUnlocked() {
    return Container(
      padding: const EdgeInsets.all(19),
      decoration: BoxDecoration(
        color: AppColors.success.withValues(alpha: 0.09),
        borderRadius: BorderRadius.circular(22),
        border: Border.all(
          color: AppColors.success.withValues(alpha: 0.55),
        ),
      ),
      child: const Row(
        children: [
          Icon(
            Icons.lock_open_rounded,
            color: AppColors.success,
            size: 34,
          ),
          SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Unit 2 Unlocked',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w800,
                  ),
                ),
                SizedBox(height: 5),
                Text(
                  'Basic Sentence Rules is now available.',
                  style: TextStyle(
                    color: AppColors.textSecondary,
                    fontSize: 11,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

enum _ActivityState {
  available,
  completed,
  locked,
}

class _ActivityCard extends StatelessWidget {
  final String step;
  final String title;
  final String subtitle;
  final IconData icon;
  final _ActivityState state;
  final VoidCallback? onTap;

  const _ActivityCard({
    required this.step,
    required this.title,
    required this.subtitle,
    required this.icon,
    required this.state,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final completed =
        state == _ActivityState.completed;

    final locked =
        state == _ActivityState.locked;

    final borderColor = completed
        ? AppColors.success
        : locked
        ? AppColors.border
        : AppColors.primary;

    final iconColor = completed
        ? AppColors.success
        : locked
        ? AppColors.textSecondary
        : AppColors.primaryLight;

    final iconBackground = completed
        ? AppColors.success.withValues(alpha: 0.15)
        : locked
        ? const Color(0xFF302225)
        : AppColors.primary.withValues(alpha: 0.15);

    return Opacity(
      opacity: locked ? 0.58 : 1,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(22),
        child: Container(
          padding: const EdgeInsets.all(17),
          decoration: BoxDecoration(
            color: AppColors.card,
            borderRadius: BorderRadius.circular(22),
            border: Border.all(
              color: borderColor,
              width: locked ? 1 : 1.3,
            ),
          ),
          child: Row(
            children: [
              Container(
                width: 58,
                height: 58,
                decoration: BoxDecoration(
                  color: iconBackground,
                  borderRadius: BorderRadius.circular(18),
                ),
                child: Icon(
                  icon,
                  color: iconColor,
                  size: 28,
                ),
              ),
              const SizedBox(width: 15),
              Expanded(
                child: Column(
                  crossAxisAlignment:
                  CrossAxisAlignment.start,
                  children: [
                    Text(
                      step,
                      style: TextStyle(
                        color: completed
                            ? AppColors.success
                            : locked
                            ? AppColors.textSecondary
                            : AppColors.primaryLight,
                        fontSize: 10,
                        fontWeight: FontWeight.w800,
                        letterSpacing: 0.8,
                      ),
                    ),
                    const SizedBox(height: 5),
                    Text(
                      title,
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                    const SizedBox(height: 5),
                    Text(
                      subtitle,
                      style: const TextStyle(
                        color: AppColors.textSecondary,
                        fontSize: 11,
                        height: 1.35,
                      ),
                    ),
                  ],
                ),
              ),
              if (!locked)
                Icon(
                  completed
                      ? Icons.check_circle_rounded
                      : Icons.arrow_forward_ios_rounded,
                  color: completed
                      ? AppColors.success
                      : AppColors.textSecondary,
                  size: completed ? 23 : 16,
                ),
            ],
          ),
        ),
      ),
    );
  }
}
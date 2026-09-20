import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart';
import '../../../core/theme/app_colors.dart';
import '../lessons/models/lesson_model.dart';
import '../lessons/services/lesson_progress_service.dart';
import '../model/onboarding_setup.dart';


class LessonFlowScreen extends StatefulWidget {
  final LessonModel lesson;
  final OnboardingSetup setup;

  const LessonFlowScreen({
    super.key,
    required this.lesson,
    required this.setup,
  });

  @override
  State<LessonFlowScreen> createState() =>
      _LessonFlowScreenState();
}

class _LessonFlowScreenState extends State<LessonFlowScreen> {
  final FlutterTts _flutterTts = FlutterTts();

  bool _started = false;
  bool _loading = true;
  bool _speaking = false;
  int _currentIndex = 0;

  @override
  void initState() {
    super.initState();
    _initializeLesson();
  }

  Future<void> _initializeLesson() async {
    final savedIndex =
    await LessonProgressService.getCurrentExample(
      widget.lesson.id,
    );

    await _flutterTts.setLanguage(
      widget.setup.learningLanguage.speechLocale,
    );

    await _flutterTts.setVolume(1);
    await _flutterTts.setPitch(1);

    _flutterTts.setStartHandler(() {
      if (!mounted) return;

      setState(() {
        _speaking = true;
      });
    });

    _flutterTts.setCompletionHandler(() {
      if (!mounted) return;

      setState(() {
        _speaking = false;
      });
    });

    _flutterTts.setErrorHandler((_) {
      if (!mounted) return;

      setState(() {
        _speaking = false;
      });

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text(
            'This voice is unavailable on your device.',
          ),
        ),
      );
    });

    if (!mounted) return;

    setState(() {
      _currentIndex = savedIndex.clamp(
        0,
        widget.lesson.examples.length - 1,
      );
      _loading = false;
    });
  }

  Future<void> _speak({
    required bool slow,
  }) async {
    final example = widget.lesson.examples[_currentIndex];

    await _flutterTts.stop();
    await _flutterTts.setSpeechRate(slow ? 0.30 : 0.47);

    await _flutterTts.speak(
      example.textFor(
        widget.setup.learningLanguage.code,
      ),
    );
  }

  Future<void> _nextExample() async {
    if (_currentIndex < widget.lesson.examples.length - 1) {
      final nextIndex = _currentIndex + 1;

      setState(() {
        _currentIndex = nextIndex;
      });

      await LessonProgressService.saveCurrentExample(
        widget.lesson.id,
        nextIndex,
      );

      return;
    }

    await _completeLesson();
  }

  Future<void> _previousExample() async {
    if (_currentIndex == 0) return;

    final previousIndex = _currentIndex - 1;

    setState(() {
      _currentIndex = previousIndex;
    });

    await LessonProgressService.saveCurrentExample(
      widget.lesson.id,
      previousIndex,
    );
  }

  Future<void> _completeLesson() async {
    await _flutterTts.stop();

    await LessonProgressService.completeLearning(
      widget.lesson.id,
    );

    if (!mounted) return;

    final closeLesson = await showDialog<bool>(
      context: context,
      barrierDismissible: false,
      builder: (dialogContext) {
        return AlertDialog(
          icon: const Icon(
            Icons.emoji_events_rounded,
            color: AppColors.warning,
            size: 52,
          ),
          title: const Text(
            'Learning Completed!',
            textAlign: TextAlign.center,
          ),
          content: const Text(
            'You completed all 15 examples. '
                'Practice is now unlocked.',
            textAlign: TextAlign.center,
          ),
          actionsAlignment: MainAxisAlignment.center,
          actions: [
            FilledButton(
              onPressed: () {
                Navigator.pop(dialogContext, true);
              },
              child: const Text('Continue'),
            ),
          ],
        );
      },
    );

    if (!mounted) return;

    if (closeLesson == true) {
      Navigator.pop(context, true);
    }
  }

  @override
  void dispose() {
    _flutterTts.stop();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (_loading) {
      return const Scaffold(
        body: Center(
          child: CircularProgressIndicator(
            color: AppColors.primary,
          ),
        ),
      );
    }

    return PopScope(
      onPopInvokedWithResult: (didPop, result) {
        _flutterTts.stop();
      },
      child: Scaffold(
        body: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                Color(0xFF281719),
                AppColors.background,
              ],
            ),
          ),
          child: SafeArea(
            child: _started
                ? _buildExampleScreen()
                : _buildLessonDetails(),
          ),
        ),
      ),
    );
  }

  Widget _buildLessonDetails() {
    return Column(
      children: [
        _buildAppBar('Lesson 1'),
        Expanded(
          child: ListView(
            padding: const EdgeInsets.fromLTRB(22, 10, 22, 28),
            children: [
              Container(
                height: 210,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(28),
                  gradient: const RadialGradient(
                    colors: [
                      Color(0xFF8E252C),
                      Color(0xFF341619),
                      AppColors.card,
                    ],
                  ),
                  border: Border.all(
                    color:
                    AppColors.primary.withValues(alpha: 0.5),
                  ),
                ),
                child: const Icon(
                  Icons.waving_hand_rounded,
                  size: 90,
                  color: AppColors.warning,
                ),
              ),
              const SizedBox(height: 26),
              Text(
                widget.lesson.title,
                style: const TextStyle(
                  fontSize: 28,
                  height: 1.15,
                  fontWeight: FontWeight.w800,
                ),
              ),
              const SizedBox(height: 11),
              Text(
                widget.lesson.description,
                style: const TextStyle(
                  color: AppColors.textSecondary,
                  fontSize: 14,
                  height: 1.55,
                ),
              ),
              const SizedBox(height: 25),
              _informationCard(
                icon: Icons.account_tree_rounded,
                title: 'Simple formula',
                value: widget.lesson.formula,
              ),
              const SizedBox(height: 12),
              _informationCard(
                icon: Icons.style_rounded,
                title: 'Examples',
                value:
                '${widget.lesson.examples.length} practical sentences',
              ),
              const SizedBox(height: 12),
              _informationCard(
                icon: Icons.volume_up_rounded,
                title: 'Audio',
                value: 'Normal and slow pronunciation',
              ),
            ],
          ),
        ),
        _bottomButton(
          title: _currentIndex > 0
              ? 'Continue Example ${_currentIndex + 1}'
              : 'Start Learning',
          onPressed: () {
            setState(() {
              _started = true;
            });
          },
        ),
      ],
    );
  }

  Widget _buildExampleScreen() {
    final example = widget.lesson.examples[_currentIndex];

    final sourceText = example.textFor(
      widget.setup.nativeLanguage.code,
    );

    final targetText = example.textFor(
      widget.setup.learningLanguage.code,
    );

    final progress =
        (_currentIndex + 1) / widget.lesson.examples.length;

    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(12, 8, 20, 10),
          child: Row(
            children: [
              IconButton(
                onPressed: () {
                  setState(() {
                    _started = false;
                  });
                },
                icon: const Icon(Icons.close_rounded),
              ),
              const SizedBox(width: 5),
              Expanded(
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(20),
                  child: LinearProgressIndicator(
                    value: progress,
                    minHeight: 8,
                    backgroundColor: AppColors.card,
                    valueColor: const AlwaysStoppedAnimation(
                      AppColors.primary,
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 13),
              Text(
                '${_currentIndex + 1}/'
                    '${widget.lesson.examples.length}',
                style: const TextStyle(
                  color: AppColors.textSecondary,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ],
          ),
        ),
        Expanded(
          child: ListView(
            padding: const EdgeInsets.fromLTRB(22, 20, 22, 30),
            children: [
              const Text(
                'Listen and learn',
                style: TextStyle(
                  color: AppColors.primaryLight,
                  fontSize: 13,
                  fontWeight: FontWeight.w800,
                ),
              ),
              const SizedBox(height: 13),
              Text(
                sourceText,
                style: const TextStyle(
                  color: AppColors.textSecondary,
                  fontSize: 20,
                  height: 1.35,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(height: 30),
              Container(
                constraints: const BoxConstraints(
                  minHeight: 230,
                ),
                padding: const EdgeInsets.all(24),
                decoration: BoxDecoration(
                  color: AppColors.card,
                  borderRadius: BorderRadius.circular(27),
                  border: Border.all(
                    color:
                    AppColors.primary.withValues(alpha: 0.45),
                  ),
                  boxShadow: [
                    BoxShadow(
                      color:
                      AppColors.primary.withValues(alpha: 0.12),
                      blurRadius: 30,
                    ),
                  ],
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      width: 72,
                      height: 72,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color:
                        AppColors.primary.withValues(alpha: 0.15),
                      ),
                      child: IconButton(
                        onPressed: () => _speak(slow: false),
                        icon: Icon(
                          _speaking
                              ? Icons.graphic_eq_rounded
                              : Icons.volume_up_rounded,
                          color: AppColors.primaryLight,
                          size: 34,
                        ),
                      ),
                    ),
                    const SizedBox(height: 23),
                    Text(
                      targetText,
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        fontSize: 27,
                        height: 1.3,
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20),
              Row(
                children: [
                  Expanded(
                    child: OutlinedButton.icon(
                      onPressed: () => _speak(slow: false),
                      icon: const Icon(Icons.volume_up_rounded),
                      label: const Text('Normal'),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: OutlinedButton.icon(
                      onPressed: () => _speak(slow: true),
                      icon: const Icon(Icons.speed_rounded),
                      label: const Text('Slow'),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 22),
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: AppColors.primary.withValues(alpha: 0.08),
                  borderRadius: BorderRadius.circular(18),
                  border: Border.all(
                    color:
                    AppColors.primary.withValues(alpha: 0.2),
                  ),
                ),
                child: const Row(
                  children: [
                    Icon(
                      Icons.lightbulb_rounded,
                      color: AppColors.warning,
                    ),
                    SizedBox(width: 12),
                    Expanded(
                      child: Text(
                        'Listen first, then repeat the sentence aloud.',
                        style: TextStyle(
                          fontSize: 12,
                          height: 1.45,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        Container(
          padding: const EdgeInsets.fromLTRB(22, 14, 22, 18),
          decoration: const BoxDecoration(
            color: AppColors.background,
            border: Border(
              top: BorderSide(color: AppColors.border),
            ),
          ),
          child: Row(
            children: [
              SizedBox(
                width: 58,
                height: 55,
                child: OutlinedButton(
                  onPressed:
                  _currentIndex == 0 ? null : _previousExample,
                  style: OutlinedButton.styleFrom(
                    padding: EdgeInsets.zero,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(17),
                    ),
                  ),
                  child: const Icon(Icons.arrow_back_rounded),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: SizedBox(
                  height: 55,
                  child: ElevatedButton(
                    onPressed: _nextExample,
                    child: Text(
                      _currentIndex ==
                          widget.lesson.examples.length - 1
                          ? 'Complete Learning'
                          : 'Next Example',
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildAppBar(String title) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(12, 8, 20, 10),
      child: Row(
        children: [
          IconButton(
            onPressed: () => Navigator.pop(context),
            icon: const Icon(Icons.arrow_back_rounded),
          ),
          const SizedBox(width: 5),
          Text(
            title,
            style: const TextStyle(
              fontWeight: FontWeight.w800,
            ),
          ),
        ],
      ),
    );
  }

  Widget _informationCard({
    required IconData icon,
    required String title,
    required String value,
  }) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.card,
        borderRadius: BorderRadius.circular(19),
        border: Border.all(color: AppColors.border),
      ),
      child: Row(
        children: [
          Icon(icon, color: AppColors.primaryLight),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontWeight: FontWeight.w800,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  value,
                  style: const TextStyle(
                    color: AppColors.textSecondary,
                    fontSize: 12,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _bottomButton({
    required String title,
    required VoidCallback onPressed,
  }) {
    return Container(
      padding: const EdgeInsets.fromLTRB(22, 14, 22, 18),
      decoration: const BoxDecoration(
        color: AppColors.background,
        border: Border(
          top: BorderSide(color: AppColors.border),
        ),
      ),
      child: ElevatedButton(
        onPressed: onPressed,
        child: Text(title),
      ),
    );
  }
}
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_tts/flutter_tts.dart';

import '../../../core/theme/app_colors.dart';

import '../../onboarding/lessons/models/lesson_model.dart';
import '../../onboarding/lessons/services/lesson_progress_service.dart';
import '../../onboarding/model/onboarding_setup.dart';
import '../data/listening_data.dart';
import '../models/listening_question.dart';

class ListeningScreen extends StatefulWidget {
  final LessonModel lesson;
  final OnboardingSetup setup;

  const ListeningScreen({
    super.key,
    required this.lesson,
    required this.setup,
  });

  @override
  State<ListeningScreen> createState() =>
      _ListeningScreenState();
}

class _ListeningScreenState extends State<ListeningScreen> {
  final FlutterTts _flutterTts = FlutterTts();
  final TextEditingController _typingController =
  TextEditingController();

  int _currentIndex = 0;
  int _score = 0;

  String? _selectedAnswer;
  bool _answerChecked = false;
  bool _answerCorrect = false;
  bool _showTranscript = false;
  bool _isSpeaking = false;
  bool _isSaving = false;

  ListeningQuestion get _question =>
      ListeningData.questions[_currentIndex];

  LessonExample get _example =>
      widget.lesson.examples[_question.exampleIndex];

  String get _targetSentence => _example.textFor(
    widget.setup.learningLanguage.code,
  );

  @override
  void initState() {
    super.initState();
    _initializeTts();
  }

  Future<void> _initializeTts() async {
    await _flutterTts.setLanguage(
      widget.setup.learningLanguage.speechLocale,
    );

    await _flutterTts.setVolume(1);
    await _flutterTts.setPitch(1);

    _flutterTts.setStartHandler(() {
      if (!mounted) return;

      setState(() {
        _isSpeaking = true;
      });
    });

    _flutterTts.setCompletionHandler(() {
      if (!mounted) return;

      setState(() {
        _isSpeaking = false;
      });
    });

    _flutterTts.setCancelHandler(() {
      if (!mounted) return;

      setState(() {
        _isSpeaking = false;
      });
    });

    _flutterTts.setErrorHandler((message) {
      if (!mounted) return;

      setState(() {
        _isSpeaking = false;
      });

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            'Audio error: $message',
          ),
        ),
      );
    });

    await Future<void>.delayed(
      const Duration(milliseconds: 400),
    );

    if (mounted) {
      await _playAudio(slow: false);
    }
  }

  Future<void> _playAudio({
    required bool slow,
  }) async {
    await _flutterTts.stop();
    await _flutterTts.setSpeechRate(slow ? 0.28 : 0.46);
    await _flutterTts.speak(_targetSentence);
  }

  String _normalize(String text) {
    return text
        .trim()
        .toLowerCase()
        .replaceAll(
      RegExp(r'''[.!?,،。！？¿¡'"’“”]'''),
      '',
    )
        .replaceAll(RegExp(r'\s+'), ' ');
  }

  List<String> _splitWords(String sentence) {
    final cleaned = sentence.trim();
    final words = cleaned.split(RegExp(r'\s+'));

    if (words.length > 1) return words;

    return [cleaned];
  }

  int get _missingWordIndex {
    final words = _splitWords(_targetSentence);

    if (words.length > 2) return 1;

    return 0;
  }

  String get _missingWord {
    final words = _splitWords(_targetSentence);
    return words[_missingWordIndex];
  }

  String get _correctAnswer {
    switch (_question.type) {
      case ListeningQuestionType.chooseSentence:
        return _targetSentence;

      case ListeningQuestionType.missingWord:
        return _missingWord;

      case ListeningQuestionType.typeSentence:
        return _targetSentence;
    }
  }

  bool get _canCheck {
    switch (_question.type) {
      case ListeningQuestionType.chooseSentence:
      case ListeningQuestionType.missingWord:
        return _selectedAnswer != null;

      case ListeningQuestionType.typeSentence:
        return _typingController.text.trim().isNotEmpty;
    }
  }

  Future<void> _checkAnswer() async {
    if (!_canCheck || _answerChecked) return;

    String userAnswer;

    switch (_question.type) {
      case ListeningQuestionType.chooseSentence:
      case ListeningQuestionType.missingWord:
        userAnswer = _selectedAnswer ?? '';

      case ListeningQuestionType.typeSentence:
        userAnswer = _typingController.text;
    }

    final correct =
        _normalize(userAnswer) == _normalize(_correctAnswer);

    if (correct) {
      _score++;

      await HapticFeedback.mediumImpact();
      await SystemSound.play(SystemSoundType.click);
    } else {
      await HapticFeedback.heavyImpact();
      await SystemSound.play(SystemSoundType.alert);
    }

    if (!mounted) return;

    setState(() {
      _answerChecked = true;
      _answerCorrect = correct;
    });
  }

  Future<void> _continue() async {
    if (!_answerChecked) {
      await _checkAnswer();
      return;
    }

    if (_currentIndex < ListeningData.questions.length - 1) {
      await _flutterTts.stop();

      setState(() {
        _currentIndex++;
        _selectedAnswer = null;
        _typingController.clear();
        _answerChecked = false;
        _answerCorrect = false;
        _showTranscript = false;
        _isSpeaking = false;
      });

      await Future<void>.delayed(
        const Duration(milliseconds: 250),
      );

      if (mounted) {
        await _playAudio(slow: false);
      }

      return;
    }

    await _finishListening();
  }

  Future<void> _skip() async {
    if (_answerChecked) return;

    await _flutterTts.stop();
    await HapticFeedback.heavyImpact();
    await SystemSound.play(SystemSoundType.alert);

    if (!mounted) return;

    setState(() {
      _answerChecked = true;
      _answerCorrect = false;
    });
  }

  Future<void> _finishListening() async {
    if (_isSaving) return;

    setState(() {
      _isSaving = true;
    });

    await _flutterTts.stop();

    await LessonProgressService.saveListeningResult(
      lessonId: widget.lesson.id,
      score: _score,
    );

    if (!mounted) return;

    final total = ListeningData.questions.length;
    final percentage = ((_score / total) * 100).round();

    final close = await showDialog<bool>(
      context: context,
      barrierDismissible: false,
      builder: (dialogContext) {
        return AlertDialog(
          icon: Icon(
            percentage >= 60
                ? Icons.headphones_rounded
                : Icons.refresh_rounded,
            color: percentage >= 60
                ? AppColors.success
                : AppColors.primary,
            size: 50,
          ),
          title: Text(
            percentage >= 60
                ? 'Listening Completed!'
                : 'Keep Listening!',
            textAlign: TextAlign.center,
          ),
          content: Text(
            'Your score is $_score/$total ($percentage%).\n'
                'Speaking practice is now unlocked.',
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

    if (close == true) {
      Navigator.pop(context, true);
    }
  }

  @override
  void dispose() {
    _typingController.dispose();
    _flutterTts.stop();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final progress =
        (_currentIndex + 1) / ListeningData.questions.length;

    return PopScope(
      canPop: !_isSaving,
      onPopInvokedWithResult: (didPop, result) {
        _flutterTts.stop();
      },
      child: Scaffold(
        backgroundColor: AppColors.background,
        body: SafeArea(
          child: Column(
            children: [
              _buildHeader(progress),
              Expanded(
                child: ListView(
                  physics: const BouncingScrollPhysics(),
                  padding:
                  const EdgeInsets.fromLTRB(21, 15, 21, 30),
                  children: [
                    const Text(
                      'Listen carefully',
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                    const SizedBox(height: 7),
                    Text(
                      _questionInstruction(),
                      style: const TextStyle(
                        color: AppColors.textSecondary,
                        fontSize: 13,
                      ),
                    ),
                    const SizedBox(height: 25),
                    _buildAudioPlayer(),
                    const SizedBox(height: 25),
                    _buildQuestion(),
                    if (_showTranscript) ...[
                      const SizedBox(height: 18),
                      _buildTranscript(),
                    ],
                    if (_answerChecked) ...[
                      const SizedBox(height: 20),
                      _buildFeedback(),
                    ],
                  ],
                ),
              ),
              _buildBottomActions(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildHeader(double progress) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(12, 10, 20, 9),
      child: Row(
        children: [
          IconButton(
            onPressed:
            _isSaving ? null : () => Navigator.pop(context),
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
                '${ListeningData.questions.length}',
            style: const TextStyle(
              color: AppColors.textSecondary,
              fontWeight: FontWeight.w700,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAudioPlayer() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        gradient: const RadialGradient(
          colors: [
            Color(0xFF74242A),
            Color(0xFF321518),
            AppColors.card,
          ],
        ),
        borderRadius: BorderRadius.circular(27),
        border: Border.all(
          color: AppColors.primary.withValues(alpha: 0.45),
        ),
        boxShadow: [
          BoxShadow(
            color: AppColors.primary.withValues(alpha: 0.13),
            blurRadius: 28,
          ),
        ],
      ),
      child: Column(
        children: [
          Container(
            width: 92,
            height: 92,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: AppColors.primary.withValues(alpha: 0.15),
              border: Border.all(
                color: AppColors.primaryLight,
                width: 1.5,
              ),
              boxShadow: [
                BoxShadow(
                  color: AppColors.primary.withValues(alpha: 0.4),
                  blurRadius: 25,
                ),
              ],
            ),
            child: IconButton(
              onPressed: () => _playAudio(slow: false),
              icon: Icon(
                _isSpeaking
                    ? Icons.graphic_eq_rounded
                    : Icons.volume_up_rounded,
                color: AppColors.primaryLight,
                size: 42,
              ),
            ),
          ),
          const SizedBox(height: 20),
          const Text(
            'Tap to replay',
            style: TextStyle(
              fontWeight: FontWeight.w800,
            ),
          ),
          const SizedBox(height: 5),
          const Text(
            'Listen before choosing your answer',
            style: TextStyle(
              color: AppColors.textSecondary,
              fontSize: 11,
            ),
          ),
          const SizedBox(height: 20),
          Row(
            children: [
              Expanded(
                child: OutlinedButton.icon(
                  onPressed: () => _playAudio(slow: false),
                  icon: const Icon(Icons.play_arrow_rounded),
                  label: const Text('Normal'),
                ),
              ),
              const SizedBox(width: 11),
              Expanded(
                child: OutlinedButton.icon(
                  onPressed: () => _playAudio(slow: true),
                  icon: const Icon(Icons.speed_rounded),
                  label: const Text('Slow'),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildQuestion() {
    switch (_question.type) {
      case ListeningQuestionType.chooseSentence:
        return _buildChooseSentence();

      case ListeningQuestionType.missingWord:
        return _buildMissingWord();

      case ListeningQuestionType.typeSentence:
        return _buildTypingQuestion();
    }
  }

  Widget _buildChooseSentence() {
    final options = _question.optionIndexes.map((index) {
      return widget.lesson.examples[index].textFor(
        widget.setup.learningLanguage.code,
      );
    }).toList();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'What did you hear?',
          style: TextStyle(
            fontSize: 17,
            fontWeight: FontWeight.w800,
          ),
        ),
        const SizedBox(height: 14),
        ...options.map(_buildOption),
      ],
    );
  }

  Widget _buildMissingWord() {
    final words = _splitWords(_targetSentence);
    final displayWords = [...words];

    displayWords[_missingWordIndex] = '_____';

    final optionWords = <String>{
      _missingWord,
      ..._question.optionIndexes
          .where(
            (index) => index != _question.exampleIndex,
      )
          .map(
            (index) => _splitWords(
          widget.lesson.examples[index].textFor(
            widget.setup.learningLanguage.code,
          ),
        ).first,
      ),
    }.toList();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Which word is missing?',
          style: TextStyle(
            fontSize: 17,
            fontWeight: FontWeight.w800,
          ),
        ),
        const SizedBox(height: 15),
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(21),
          decoration: BoxDecoration(
            color: AppColors.card,
            borderRadius: BorderRadius.circular(20),
            border: Border.all(color: AppColors.border),
          ),
          child: Text(
            displayWords.join(' '),
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontSize: 20,
              height: 1.4,
              fontWeight: FontWeight.w800,
            ),
          ),
        ),
        const SizedBox(height: 16),
        Wrap(
          spacing: 10,
          runSpacing: 10,
          children: optionWords.map((word) {
            return ChoiceChip(
              selected: _selectedAnswer == word,
              onSelected: _answerChecked
                  ? null
                  : (_) {
                setState(() {
                  _selectedAnswer = word;
                });
              },
              label: Text(word),
            );
          }).toList(),
        ),
      ],
    );
  }

  Widget _buildTypingQuestion() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Type the sentence you heard',
          style: TextStyle(
            fontSize: 17,
            fontWeight: FontWeight.w800,
          ),
        ),
        const SizedBox(height: 15),
        TextField(
          controller: _typingController,
          enabled: !_answerChecked,
          minLines: 2,
          maxLines: 4,
          onChanged: (_) {
            setState(() {});
          },
          decoration: InputDecoration(
            hintText: 'Type your answer...',
            filled: true,
            fillColor: AppColors.card,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(19),
              borderSide:
              const BorderSide(color: AppColors.border),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(19),
              borderSide:
              const BorderSide(color: AppColors.border),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(19),
              borderSide: const BorderSide(
                color: AppColors.primary,
                width: 1.5,
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildOption(String option) {
    final selected = _selectedAnswer == option;

    Color borderColor = selected
        ? AppColors.primary
        : AppColors.border;

    Color backgroundColor = selected
        ? AppColors.primary.withValues(alpha: 0.13)
        : AppColors.card;

    if (_answerChecked) {
      final isCorrectOption =
          _normalize(option) == _normalize(_correctAnswer);

      if (isCorrectOption) {
        borderColor = AppColors.success;
        backgroundColor =
            AppColors.success.withValues(alpha: 0.12);
      } else if (selected && !_answerCorrect) {
        borderColor = AppColors.error;
        backgroundColor =
            AppColors.error.withValues(alpha: 0.10);
      }
    }

    return Container(
      width: double.infinity,
      margin: const EdgeInsets.only(bottom: 11),
      child: OutlinedButton(
        onPressed: _answerChecked
            ? null
            : () {
          setState(() {
            _selectedAnswer = option;
          });
        },
        style: OutlinedButton.styleFrom(
          alignment: Alignment.centerLeft,
          padding: const EdgeInsets.all(17),
          backgroundColor: backgroundColor,
          side: BorderSide(color: borderColor),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(18),
          ),
        ),
        child: Text(
          option,
          style: const TextStyle(
            color: AppColors.textPrimary,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    );
  }

  Widget _buildTranscript() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.warning.withValues(alpha: 0.08),
        borderRadius: BorderRadius.circular(18),
        border: Border.all(
          color: AppColors.warning.withValues(alpha: 0.25),
        ),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Icon(
            Icons.subtitles_rounded,
            color: AppColors.warning,
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              _targetSentence,
              style: const TextStyle(
                fontSize: 14,
                height: 1.45,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFeedback() {
    final feedbackColor =
    _answerCorrect ? AppColors.success : AppColors.error;

    return Container(
      padding: const EdgeInsets.all(17),
      decoration: BoxDecoration(
        color: feedbackColor.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(19),
        border: Border.all(color: feedbackColor),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(
            _answerCorrect
                ? Icons.check_circle_rounded
                : Icons.cancel_rounded,
            color: feedbackColor,
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              _answerCorrect
                  ? 'Correct! Excellent listening.'
                  : 'Correct answer: $_correctAnswer',
              style: const TextStyle(
                height: 1.4,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBottomActions() {
    return Container(
      padding: const EdgeInsets.fromLTRB(20, 10, 20, 17),
      decoration: const BoxDecoration(
        color: AppColors.background,
        border: Border(
          top: BorderSide(color: AppColors.border),
        ),
      ),
      child: Column(
        children: [
          if (!_answerChecked)
            Row(
              children: [
                TextButton(
                  onPressed: _skip,
                  child: const Text('Skip'),
                ),
                const Spacer(),
                TextButton.icon(
                  onPressed: () {
                    setState(() {
                      _showTranscript = !_showTranscript;
                    });
                  },
                  icon: const Icon(
                    Icons.hearing_disabled_rounded,
                  ),
                  label: const Text('Can’t hear audio'),
                ),
              ],
            ),
          ElevatedButton(
            onPressed:
            (_canCheck || _answerChecked) && !_isSaving
                ? _continue
                : null,
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
                : Text(
              _answerChecked
                  ? _currentIndex ==
                  ListeningData.questions.length - 1
                  ? 'Finish Listening'
                  : 'Continue'
                  : 'Check Answer',
            ),
          ),
        ],
      ),
    );
  }

  String _questionInstruction() {
    switch (_question.type) {
      case ListeningQuestionType.chooseSentence:
        return 'Listen and select the sentence you heard.';

      case ListeningQuestionType.missingWord:
        return 'Listen and choose the missing word.';

      case ListeningQuestionType.typeSentence:
        return 'Listen and type the complete sentence.';
    }
  }
}
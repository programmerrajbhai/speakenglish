import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_tts/flutter_tts.dart';

import '../../../core/theme/app_colors.dart';
import '../../onboarding/lessons/models/lesson_model.dart';
import '../../onboarding/lessons/services/lesson_progress_service.dart';
import '../../onboarding/model/onboarding_setup.dart';
import '../data/practice_data.dart';
import '../models/practice_question.dart';

class PracticeScreen extends StatefulWidget {
  final LessonModel lesson;
  final OnboardingSetup setup;

  const PracticeScreen({
    super.key,
    required this.lesson,
    required this.setup,
  });

  @override
  State<PracticeScreen> createState() =>
      _PracticeScreenState();
}

class _PracticeScreenState extends State<PracticeScreen> {
  final FlutterTts _flutterTts = FlutterTts();
  final TextEditingController _answerController =
  TextEditingController();

  int _currentIndex = 0;
  int _score = 0;

  String? _selectedAnswer;
  bool _answerChecked = false;
  bool _answerCorrect = false;
  bool _showHint = false;
  bool _saving = false;

  List<String> _arrangedWords = [];
  List<String> _remainingWords = [];

  int? _selectedLeftMatch;
  final Map<int, int> _matchedPairs = {};

  PracticeQuestion get _question =>
      PracticeData.questions[_currentIndex];

  LessonExample get _example =>
      widget.lesson.examples[_question.exampleIndex];

  String get _sourceText => _example.textFor(
    widget.setup.nativeLanguage.code,
  );

  String get _targetText => _example.textFor(
    widget.setup.learningLanguage.code,
  );

  @override
  void initState() {
    super.initState();
    _initializeAudio();
    _prepareQuestion();
  }

  Future<void> _initializeAudio() async {
    await _flutterTts.setLanguage(
      widget.setup.learningLanguage.speechLocale,
    );
    await _flutterTts.setVolume(1);
    await _flutterTts.setPitch(1);
    await _flutterTts.setSpeechRate(0.45);
  }

  void _prepareQuestion() {
    _answerController.clear();
    _selectedAnswer = null;
    _answerChecked = false;
    _answerCorrect = false;
    _showHint = false;
    _selectedLeftMatch = null;
    _matchedPairs.clear();
    _arrangedWords = [];

    if (_question.type == PracticeType.wordArrange) {
      final words = _splitWords(_targetText);
      _remainingWords = words.reversed.toList();

      if (_remainingWords.length > 2 &&
          _remainingWords.join(' ') == words.join(' ')) {
        final first = _remainingWords.removeAt(0);
        _remainingWords.add(first);
      }
    } else {
      _remainingWords = [];
    }
  }

  List<String> _splitWords(String sentence) {
    final cleaned = sentence.trim();
    final words = cleaned.split(RegExp(r'\s+'));

    if (words.length > 1) return words;

    return cleaned.characters.toList();
  }

  String _normalize(String value) {
    return value
        .trim()
        .toLowerCase()
        .replaceAll(
      RegExp(r'''[.!?,،。！？¿¡'"’“”]'''),
      '',
    )
        .replaceAll(RegExp(r'\s+'), ' ');
  }

  Future<void> _speak() async {
    await _flutterTts.stop();
    await _flutterTts.speak(_targetText);
  }

  Future<void> _playCorrectSound() async {
    await HapticFeedback.mediumImpact();
    await SystemSound.play(SystemSoundType.click);
  }

  Future<void> _playWrongSound() async {
    await HapticFeedback.heavyImpact();
    await SystemSound.play(SystemSoundType.alert);
  }

  bool get _canCheck {
    switch (_question.type) {
      case PracticeType.multipleChoice:
      case PracticeType.questionAnswer:
        return _selectedAnswer != null;

      case PracticeType.nativeToTarget:
      case PracticeType.targetToNative:
        return _answerController.text.trim().isNotEmpty;

      case PracticeType.fillBlank:
        return _selectedAnswer != null;

      case PracticeType.wordArrange:
        return _remainingWords.isEmpty &&
            _arrangedWords.isNotEmpty;

      case PracticeType.matching:
        return _matchedPairs.length ==
            _question.optionIndexes.length;
    }
  }

  String get _correctAnswer {
    switch (_question.type) {
      case PracticeType.targetToNative:
        return _sourceText;

      case PracticeType.questionAnswer:
        return widget.lesson.examples[6].textFor(
          widget.setup.learningLanguage.code,
        );

      case PracticeType.fillBlank:
        final words = _splitWords(_targetText);
        final missingIndex = words.length > 2 ? 1 : 0;
        return words[missingIndex];

      case PracticeType.multipleChoice:
      case PracticeType.nativeToTarget:
      case PracticeType.wordArrange:
      case PracticeType.matching:
        return _targetText;
    }
  }

  Future<void> _checkAnswer() async {
    if (!_canCheck || _answerChecked) return;

    bool correct;

    switch (_question.type) {
      case PracticeType.multipleChoice:
      case PracticeType.fillBlank:
      case PracticeType.questionAnswer:
        correct = _normalize(_selectedAnswer ?? '') ==
            _normalize(_correctAnswer);

      case PracticeType.nativeToTarget:
      case PracticeType.targetToNative:
        correct = _normalize(_answerController.text) ==
            _normalize(_correctAnswer);

      case PracticeType.wordArrange:
        correct = _normalize(_arrangedWords.join(' ')) ==
            _normalize(_correctAnswer);

      case PracticeType.matching:
        correct = _question.optionIndexes.every(
              (index) => _matchedPairs[index] == index,
        );
    }

    if (correct) {
      await _playCorrectSound();
      _score++;
    } else {
      await _playWrongSound();
    }

    if (!mounted) return;

    setState(() {
      _answerChecked = true;
      _answerCorrect = correct;
    });
  }

  void _selectWord(String word, int index) {
    if (_answerChecked) return;

    setState(() {
      _remainingWords.removeAt(index);
      _arrangedWords.add(word);
    });
  }

  void _removeArrangedWord(String word, int index) {
    if (_answerChecked) return;

    setState(() {
      _arrangedWords.removeAt(index);
      _remainingWords.add(word);
    });
  }

  Future<void> _selectMatchingRight(int rightIndex) async {
    if (_selectedLeftMatch == null ||
        _matchedPairs.containsKey(_selectedLeftMatch)) {
      return;
    }

    final leftIndex = _selectedLeftMatch!;

    if (leftIndex == rightIndex) {
      await HapticFeedback.lightImpact();

      setState(() {
        _matchedPairs[leftIndex] = rightIndex;
        _selectedLeftMatch = null;
      });
    } else {
      await _playWrongSound();

      if (!mounted) return;

      setState(() {
        _selectedLeftMatch = null;
      });
    }
  }

  Future<void> _continue() async {
    if (!_answerChecked) {
      await _checkAnswer();
      return;
    }

    if (_currentIndex < PracticeData.questions.length - 1) {
      setState(() {
        _currentIndex++;
        _prepareQuestion();
      });

      return;
    }

    await _completePractice();
  }

  Future<void> _skipQuestion() async {
    if (_answerChecked) return;

    await _playWrongSound();

    if (!mounted) return;

    setState(() {
      _answerChecked = true;
      _answerCorrect = false;
    });
  }

  Future<void> _completePractice() async {
    if (_saving) return;

    setState(() {
      _saving = true;
    });

    await LessonProgressService.savePracticeResult(
      lessonId: widget.lesson.id,
      score: _score,
    );

    if (!mounted) return;

    final percentage =
    ((_score / PracticeData.questions.length) * 100).round();

    final close = await showDialog<bool>(
      context: context,
      barrierDismissible: false,
      builder: (dialogContext) {
        return AlertDialog(
          icon: Icon(
            percentage >= 70
                ? Icons.emoji_events_rounded
                : Icons.refresh_rounded,
            color: percentage >= 70
                ? AppColors.warning
                : AppColors.primary,
            size: 50,
          ),
          title: Text(
            percentage >= 70
                ? 'Practice Completed!'
                : 'Keep Practicing!',
            textAlign: TextAlign.center,
          ),
          content: Text(
            'Your score is $_score/'
                '${PracticeData.questions.length} ($percentage%).\n'
                'Listening practice is now unlocked.',
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
    _answerController.dispose();
    _flutterTts.stop();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final progress =
        (_currentIndex + 1) / PracticeData.questions.length;

    return PopScope(
      canPop: !_saving,
      child: Scaffold(
        backgroundColor: AppColors.background,
        body: SafeArea(
          child: Column(
            children: [
              _buildHeader(progress),
              Expanded(
                child: ListView(
                  padding:
                  const EdgeInsets.fromLTRB(21, 15, 21, 30),
                  children: [
                    Text(
                      _question.title,
                      style: const TextStyle(
                        fontSize: 23,
                        height: 1.2,
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      _questionTypeName(_question.type),
                      style: const TextStyle(
                        color: AppColors.primaryLight,
                        fontSize: 12,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    const SizedBox(height: 25),
                    _buildQuestionContent(),
                    if (_showHint && !_answerChecked) ...[
                      const SizedBox(height: 18),
                      _buildHint(),
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
            _saving ? null : () => Navigator.pop(context),
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
                '${PracticeData.questions.length}',
            style: const TextStyle(
              color: AppColors.textSecondary,
              fontWeight: FontWeight.w700,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildQuestionContent() {
    switch (_question.type) {
      case PracticeType.multipleChoice:
        return _buildMultipleChoice();

      case PracticeType.nativeToTarget:
        return _buildTypingQuestion(
          prompt: _sourceText,
          hint: _targetText,
        );

      case PracticeType.targetToNative:
        return _buildTypingQuestion(
          prompt: _targetText,
          hint: _sourceText,
          showAudio: true,
        );

      case PracticeType.fillBlank:
        return _buildFillBlank();

      case PracticeType.wordArrange:
        return _buildWordArrange();

      case PracticeType.matching:
        return _buildMatching();

      case PracticeType.questionAnswer:
        return _buildQuestionAnswer();
    }
  }

  Widget _buildPromptCard(
      String text, {
        bool showAudio = false,
      }) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(22),
      decoration: BoxDecoration(
        color: AppColors.card,
        borderRadius: BorderRadius.circular(23),
        border: Border.all(color: AppColors.border),
      ),
      child: Row(
        children: [
          Expanded(
            child: Text(
              text,
              style: const TextStyle(
                fontSize: 20,
                height: 1.35,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
          if (showAudio)
            IconButton.filledTonal(
              onPressed: _speak,
              icon: const Icon(Icons.volume_up_rounded),
            ),
        ],
      ),
    );
  }

  Widget _buildMultipleChoice() {
    final options = _question.optionIndexes
        .map(
          (index) => widget.lesson.examples[index].textFor(
        widget.setup.learningLanguage.code,
      ),
    )
        .toList();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildPromptCard(_sourceText),
        const SizedBox(height: 18),
        ...options.map(_buildOption),
      ],
    );
  }

  Widget _buildTypingQuestion({
    required String prompt,
    required String hint,
    bool showAudio = false,
  }) {
    return Column(
      children: [
        _buildPromptCard(
          prompt,
          showAudio: showAudio,
        ),
        const SizedBox(height: 20),
        TextField(
          controller: _answerController,
          enabled: !_answerChecked,
          minLines: 2,
          maxLines: 4,
          onChanged: (_) => setState(() {}),
          decoration: InputDecoration(
            hintText: 'Write your answer...',
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

  Widget _buildFillBlank() {
    final words = _splitWords(_targetText);
    final missingIndex = words.length > 2 ? 1 : 0;
    final correctWord = words[missingIndex];

    final visibleWords = [...words];
    visibleWords[missingIndex] = '_____';

    final distractors = <String>[
      correctWord,
      ...widget.lesson.examples
          .skip(8)
          .take(3)
          .map(
            (example) => _splitWords(
          example.textFor(
            widget.setup.learningLanguage.code,
          ),
        ).first,
      ),
    ].toSet().toList();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildPromptCard(_sourceText),
        const SizedBox(height: 18),
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(22),
          decoration: BoxDecoration(
            color: AppColors.card,
            borderRadius: BorderRadius.circular(22),
            border: Border.all(color: AppColors.border),
          ),
          child: Text(
            visibleWords.join(' '),
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontSize: 21,
              fontWeight: FontWeight.w800,
            ),
          ),
        ),
        const SizedBox(height: 18),
        Wrap(
          spacing: 10,
          runSpacing: 10,
          children: distractors.map((word) {
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

  Widget _buildWordArrange() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildPromptCard(_sourceText),
        const SizedBox(height: 18),
        Container(
          width: double.infinity,
          constraints: const BoxConstraints(minHeight: 105),
          padding: const EdgeInsets.all(15),
          decoration: BoxDecoration(
            color: AppColors.card,
            borderRadius: BorderRadius.circular(20),
            border: Border.all(color: AppColors.border),
          ),
          child: Wrap(
            spacing: 9,
            runSpacing: 9,
            children: List.generate(
              _arrangedWords.length,
                  (index) {
                final word = _arrangedWords[index];

                return ActionChip(
                  onPressed: () {
                    _removeArrangedWord(word, index);
                  },
                  label: Text(word),
                  avatar: const Icon(
                    Icons.close_rounded,
                    size: 15,
                  ),
                );
              },
            ),
          ),
        ),
        const SizedBox(height: 20),
        Wrap(
          spacing: 9,
          runSpacing: 9,
          children: List.generate(
            _remainingWords.length,
                (index) {
              final word = _remainingWords[index];

              return ActionChip(
                onPressed: () {
                  _selectWord(word, index);
                },
                label: Text(word),
              );
            },
          ),
        ),
      ],
    );
  }

  Widget _buildMatching() {
    final indexes = _question.optionIndexes;
    final rightIndexes = indexes.reversed.toList();

    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          child: Column(
            children: indexes.map((index) {
              final matched = _matchedPairs.containsKey(index);
              final selected = _selectedLeftMatch == index;

              return _matchingTile(
                text: widget.lesson.examples[index].textFor(
                  widget.setup.nativeLanguage.code,
                ),
                selected: selected,
                matched: matched,
                onTap: matched || _answerChecked
                    ? null
                    : () {
                  setState(() {
                    _selectedLeftMatch = index;
                  });
                },
              );
            }).toList(),
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            children: rightIndexes.map((index) {
              final matched =
              _matchedPairs.containsValue(index);

              return _matchingTile(
                text: widget.lesson.examples[index].textFor(
                  widget.setup.learningLanguage.code,
                ),
                selected: false,
                matched: matched,
                onTap: matched || _answerChecked
                    ? null
                    : () => _selectMatchingRight(index),
              );
            }).toList(),
          ),
        ),
      ],
    );
  }

  Widget _matchingTile({
    required String text,
    required bool selected,
    required bool matched,
    required VoidCallback? onTap,
  }) {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.only(bottom: 11),
      child: OutlinedButton(
        onPressed: onTap,
        style: OutlinedButton.styleFrom(
          padding: const EdgeInsets.all(13),
          backgroundColor: matched
              ? AppColors.success.withValues(alpha: 0.16)
              : selected
              ? AppColors.primary.withValues(alpha: 0.16)
              : AppColors.card,
          side: BorderSide(
            color: matched
                ? AppColors.success
                : selected
                ? AppColors.primary
                : AppColors.border,
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
        ),
        child: Text(
          text,
          textAlign: TextAlign.center,
          style: const TextStyle(fontSize: 12),
        ),
      ),
    );
  }

  Widget _buildQuestionAnswer() {
    final options = _question.optionIndexes
        .map(
          (index) => widget.lesson.examples[index].textFor(
        widget.setup.learningLanguage.code,
      ),
    )
        .toList();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildPromptCard(
          _targetText,
          showAudio: true,
        ),
        const SizedBox(height: 18),
        ...options.map(_buildOption),
      ],
    );
  }

  Widget _buildOption(String option) {
    final selected = _selectedAnswer == option;

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
          backgroundColor: selected
              ? AppColors.primary.withValues(alpha: 0.14)
              : AppColors.card,
          side: BorderSide(
            color: selected
                ? AppColors.primary
                : AppColors.border,
          ),
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

  Widget _buildHint() {
    final answer = _correctAnswer;
    final visibleLength =
    answer.length > 3 ? 3 : answer.length;

    return Container(
      padding: const EdgeInsets.all(15),
      decoration: BoxDecoration(
        color: AppColors.warning.withValues(alpha: 0.08),
        borderRadius: BorderRadius.circular(17),
        border: Border.all(
          color: AppColors.warning.withValues(alpha: 0.25),
        ),
      ),
      child: Row(
        children: [
          const Icon(
            Icons.lightbulb_rounded,
            color: AppColors.warning,
          ),
          const SizedBox(width: 11),
          Expanded(
            child: Text(
              'Hint: The answer starts with '
                  '“${answer.substring(0, visibleLength)}...”',
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFeedback() {
    return Container(
      padding: const EdgeInsets.all(17),
      decoration: BoxDecoration(
        color: (_answerCorrect
            ? AppColors.success
            : AppColors.error)
            .withValues(alpha: 0.11),
        borderRadius: BorderRadius.circular(19),
        border: Border.all(
          color: _answerCorrect
              ? AppColors.success
              : AppColors.error,
        ),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(
            _answerCorrect
                ? Icons.check_circle_rounded
                : Icons.cancel_rounded,
            color: _answerCorrect
                ? AppColors.success
                : AppColors.error,
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              _answerCorrect
                  ? 'Correct! Great job.'
                  : 'Correct answer: $_correctAnswer',
              style: const TextStyle(
                fontWeight: FontWeight.w700,
                height: 1.4,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBottomActions() {
    return Container(
      padding: const EdgeInsets.fromLTRB(20, 12, 20, 17),
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
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                TextButton(
                  onPressed: _skipQuestion,
                  child: const Text('Skip'),
                ),
                TextButton.icon(
                  onPressed: () {
                    setState(() {
                      _showHint = !_showHint;
                    });
                  },
                  icon: const Icon(
                    Icons.lightbulb_outline_rounded,
                  ),
                  label: const Text('Hint'),
                ),
              ],
            ),
          ElevatedButton(
            onPressed: (_canCheck || _answerChecked) && !_saving
                ? _continue
                : null,
            style: ElevatedButton.styleFrom(
              disabledBackgroundColor: AppColors.card,
              disabledForegroundColor: AppColors.textSecondary,
            ),
            child: _saving
                ? const SizedBox(
              width: 22,
              height: 22,
              child: CircularProgressIndicator(
                strokeWidth: 2.5,
                color: Colors.white,
              ),
            )
                : Text(
              _answerChecked
                  ? _currentIndex ==
                  PracticeData.questions.length - 1
                  ? 'Finish Practice'
                  : 'Continue'
                  : 'Check Answer',
            ),
          ),
        ],
      ),
    );
  }

  String _questionTypeName(PracticeType type) {
    switch (type) {
      case PracticeType.multipleChoice:
        return 'MULTIPLE CHOICE';
      case PracticeType.nativeToTarget:
        return 'TRANSLATION';
      case PracticeType.targetToNative:
        return 'MEANING';
      case PracticeType.fillBlank:
        return 'FILL IN THE BLANK';
      case PracticeType.wordArrange:
        return 'WORD ARRANGEMENT';
      case PracticeType.matching:
        return 'MATCHING';
      case PracticeType.questionAnswer:
        return 'QUESTION & ANSWER';
    }
  }
}
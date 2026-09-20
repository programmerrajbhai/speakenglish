import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:speech_to_text/speech_recognition_error.dart';
import 'package:speech_to_text/speech_recognition_result.dart';
import 'package:speech_to_text/speech_to_text.dart';
import '../../../core/theme/app_colors.dart';
import '../../onboarding/lessons/models/lesson_model.dart';
import '../../onboarding/lessons/services/lesson_progress_service.dart';
import '../../onboarding/model/onboarding_setup.dart';
import '../data/lesson_test_data.dart';
import '../models/test_question.dart';
import 'lesson_result_screen.dart';

class LessonTestScreen extends StatefulWidget {
  final LessonModel lesson;
  final OnboardingSetup setup;

  const LessonTestScreen({
    super.key,
    required this.lesson,
    required this.setup,
  });

  @override
  State<LessonTestScreen> createState() =>
      _LessonTestScreenState();
}

class _LessonTestScreenState
    extends State<LessonTestScreen> {
  final FlutterTts _flutterTts = FlutterTts();
  final SpeechToText _speech = SpeechToText();

  final TextEditingController _answerController =
  TextEditingController();

  int _currentIndex = 0;
  int _score = 0;

  String? _selectedAnswer;
  String _recognizedText = '';
  String? _speechLocale;
  String? _errorMessage;

  bool _answerChecked = false;
  bool _answerCorrect = false;
  bool _showTranscript = false;
  bool _isListening = false;
  bool _speechInitialized = false;
  bool _initializingSpeech = false;
  bool _isSaving = false;

  TestQuestion get _question =>
      LessonTestData.questions[_currentIndex];

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
    _initializeTts();
  }

  Future<void> _initializeTts() async {
    await _flutterTts.setLanguage(
      widget.setup.learningLanguage.speechLocale,
    );

    await _flutterTts.setVolume(1);
    await _flutterTts.setPitch(1);
    await _flutterTts.setSpeechRate(0.43);
  }

  Future<void> _playAudio() async {
    await _flutterTts.stop();
    await _flutterTts.speak(_targetText);
  }

  Future<bool> _initializeSpeech() async {
    if (_speechInitialized) return true;
    if (_initializingSpeech) return false;

    setState(() {
      _initializingSpeech = true;
      _errorMessage = null;
    });

    final available = await _speech.initialize(
      onStatus: _onSpeechStatus,
      onError: _onSpeechError,
      debugLogging: false,
    );

    if (!mounted) return false;

    if (!available) {
      setState(() {
        _initializingSpeech = false;
        _errorMessage =
        'Microphone permission is required.';
      });

      return false;
    }

    final locales = await _speech.locales();

    final requested =
    widget.setup.learningLanguage.speechLocale
        .replaceAll('_', '-')
        .toLowerCase();

    String? matchedLocale;

    for (final locale in locales) {
      final installed = locale.localeId
          .replaceAll('_', '-')
          .toLowerCase();

      if (installed == requested) {
        matchedLocale = locale.localeId;
        break;
      }
    }

    if (!mounted) return false;

    setState(() {
      _speechInitialized = true;
      _initializingSpeech = false;
      _speechLocale = matchedLocale ??
          widget.setup.learningLanguage.speechLocale;
    });

    return true;
  }

  Future<void> _toggleListening() async {
    if (_answerChecked) return;

    if (_isListening) {
      await _speech.stop();

      if (!mounted) return;

      setState(() {
        _isListening = false;
      });

      return;
    }

    final available = await _initializeSpeech();

    if (!available || !mounted) return;

    setState(() {
      _recognizedText = '';
      _errorMessage = null;
    });

    await _speech.listen(
      onResult: _onSpeechResult,
      localeId: _speechLocale,
      listenFor: const Duration(seconds: 15),
      pauseFor: const Duration(seconds: 3),
    );

    if (!mounted) return;

    setState(() {
      _isListening = _speech.isListening;
    });
  }

  void _onSpeechResult(SpeechRecognitionResult result) {
    if (!mounted) return;

    setState(() {
      _recognizedText = result.recognizedWords;
    });

    if (result.finalResult) {
      setState(() {
        _isListening = false;
      });
    }
  }

  void _onSpeechStatus(String status) {
    if (!mounted) return;

    setState(() {
      _isListening =
          status == 'listening' || _speech.isListening;
    });
  }

  void _onSpeechError(SpeechRecognitionError error) {
    if (!mounted) return;

    setState(() {
      _isListening = false;
      _errorMessage =
      'Could not recognize your voice. Try again.';
    });
  }

  String _correctAnswer() {
    switch (_question.type) {
      case TestQuestionType.targetToNative:
        return _sourceText;

      case TestQuestionType.multipleChoice:
      case TestQuestionType.translationTyping:
      case TestQuestionType.listening:
      case TestQuestionType.speaking:
        return _targetText;
    }
  }

  bool get _canCheck {
    switch (_question.type) {
      case TestQuestionType.multipleChoice:
      case TestQuestionType.targetToNative:
      case TestQuestionType.listening:
        return _selectedAnswer != null;

      case TestQuestionType.translationTyping:
        return _answerController.text.trim().isNotEmpty;

      case TestQuestionType.speaking:
        return _recognizedText.trim().isNotEmpty;
    }
  }

  Future<void> _checkAnswer() async {
    if (!_canCheck || _answerChecked) return;

    bool correct;

    switch (_question.type) {
      case TestQuestionType.multipleChoice:
      case TestQuestionType.targetToNative:
      case TestQuestionType.listening:
        correct = _normalize(
          _selectedAnswer ?? '',
        ) ==
            _normalize(_correctAnswer());

      case TestQuestionType.translationTyping:
        correct = _normalize(
          _answerController.text,
        ) ==
            _normalize(_correctAnswer());

      case TestQuestionType.speaking:
        final accuracy = _calculateSimilarity(
          _recognizedText,
          _correctAnswer(),
        );

        correct = accuracy >= 70;
    }

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

  Future<void> _nextQuestion() async {
    if (!_answerChecked) {
      await _checkAnswer();
      return;
    }

    if (_currentIndex <
        LessonTestData.questions.length - 1) {
      await _speech.stop();
      await _flutterTts.stop();

      setState(() {
        _currentIndex++;
        _selectedAnswer = null;
        _recognizedText = '';
        _answerController.clear();
        _answerChecked = false;
        _answerCorrect = false;
        _showTranscript = false;
        _isListening = false;
        _errorMessage = null;
      });

      return;
    }

    await _finishTest();
  }

  Future<void> _skipQuestion() async {
    if (_answerChecked) return;

    await _speech.stop();
    await HapticFeedback.heavyImpact();
    await SystemSound.play(SystemSoundType.alert);

    if (!mounted) return;

    setState(() {
      _answerChecked = true;
      _answerCorrect = false;
      _isListening = false;
    });
  }

  Future<void> _finishTest() async {
    if (_isSaving) return;

    setState(() {
      _isSaving = true;
    });

    await _speech.stop();
    await _flutterTts.stop();

    final total = LessonTestData.questions.length;

    await LessonProgressService.saveTestResult(
      lessonId: widget.lesson.id,
      score: _score,
      total: total,
    );

    if (!mounted) return;

    final retry = await Navigator.push<bool>(
      context,
      MaterialPageRoute(
        builder: (_) => LessonResultScreen(
          score: _score,
          total: total,
        ),
      ),
    );

    if (!mounted) return;

    if (retry == true) {
      setState(() {
        _currentIndex = 0;
        _score = 0;
        _selectedAnswer = null;
        _recognizedText = '';
        _answerController.clear();
        _answerChecked = false;
        _answerCorrect = false;
        _showTranscript = false;
        _isListening = false;
        _isSaving = false;
        _errorMessage = null;
      });
    } else {
      Navigator.pop(context, true);
    }
  }

  List<String> _questionOptions() {
    final languageCode =
    _question.type == TestQuestionType.targetToNative
        ? widget.setup.nativeLanguage.code
        : widget.setup.learningLanguage.code;

    return _question.optionIndexes.map((index) {
      return widget.lesson.examples[index].textFor(
        languageCode,
      );
    }).toList();
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

  int _calculateSimilarity(
      String spoken,
      String expected,
      ) {
    final first = _normalize(spoken);
    final second = _normalize(expected);

    if (first.isEmpty || second.isEmpty) return 0;
    if (first == second) return 100;

    final firstRunes = first.runes.toList();
    final secondRunes = second.runes.toList();

    final distance = _levenshteinDistance(
      firstRunes,
      secondRunes,
    );

    final maximumLength =
    firstRunes.length > secondRunes.length
        ? firstRunes.length
        : secondRunes.length;

    return ((1 - distance / maximumLength) * 100)
        .clamp(0, 100)
        .round();
  }

  int _levenshteinDistance(
      List<int> first,
      List<int> second,
      ) {
    final previous =
    List<int>.generate(second.length + 1, (i) => i);

    final current =
    List<int>.filled(second.length + 1, 0);

    for (var i = 1; i <= first.length; i++) {
      current[0] = i;

      for (var j = 1; j <= second.length; j++) {
        final substitutionCost =
        first[i - 1] == second[j - 1] ? 0 : 1;

        final deletion = previous[j] + 1;
        final insertion = current[j - 1] + 1;
        final substitution =
            previous[j - 1] + substitutionCost;

        current[j] = [
          deletion,
          insertion,
          substitution,
        ].reduce((a, b) => a < b ? a : b);
      }

      for (var j = 0; j <= second.length; j++) {
        previous[j] = current[j];
      }
    }

    return previous[second.length];
  }

  @override
  void dispose() {
    _answerController.dispose();
    _speech.cancel();
    _flutterTts.stop();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final progress =
        (_currentIndex + 1) /
            LessonTestData.questions.length;

    return PopScope(
      canPop: !_isSaving,
      onPopInvokedWithResult: (didPop, result) {
        _speech.cancel();
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
                  padding:
                  const EdgeInsets.fromLTRB(21, 18, 21, 30),
                  children: [
                    Text(
                      _questionTitle(),
                      style: const TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                    const SizedBox(height: 7),
                    Text(
                      _questionInstruction(),
                      style: const TextStyle(
                        color: AppColors.textSecondary,
                      ),
                    ),
                    const SizedBox(height: 25),
                    _buildQuestion(),
                    if (_errorMessage != null) ...[
                      const SizedBox(height: 16),
                      _buildError(),
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
                '${LessonTestData.questions.length}',
            style: const TextStyle(
              color: AppColors.textSecondary,
              fontWeight: FontWeight.w700,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildQuestion() {
    switch (_question.type) {
      case TestQuestionType.multipleChoice:
        return _buildChoiceQuestion(
          prompt: _sourceText,
        );

      case TestQuestionType.targetToNative:
        return _buildChoiceQuestion(
          prompt: _targetText,
        );

      case TestQuestionType.translationTyping:
        return _buildTypingQuestion();

      case TestQuestionType.listening:
        return _buildListeningQuestion();

      case TestQuestionType.speaking:
        return _buildSpeakingQuestion();
    }
  }

  Widget _buildChoiceQuestion({
    required String prompt,
  }) {
    return Column(
      children: [
        _buildPromptCard(prompt),
        const SizedBox(height: 18),
        ..._questionOptions().map(_buildOption),
      ],
    );
  }

  Widget _buildTypingQuestion() {
    return Column(
      children: [
        _buildPromptCard(_sourceText),
        const SizedBox(height: 18),
        TextField(
          controller: _answerController,
          enabled: !_answerChecked,
          minLines: 2,
          maxLines: 4,
          onChanged: (_) => setState(() {}),
          decoration: InputDecoration(
            hintText: 'Write the translation...',
            filled: true,
            fillColor: AppColors.card,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(19),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildListeningQuestion() {
    return Column(
      children: [
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(25),
          decoration: BoxDecoration(
            color: AppColors.card,
            borderRadius: BorderRadius.circular(24),
            border: Border.all(
              color:
              AppColors.primary.withValues(alpha: 0.4),
            ),
          ),
          child: Column(
            children: [
              IconButton.filled(
                onPressed: _playAudio,
                style: IconButton.styleFrom(
                  fixedSize: const Size(75, 75),
                ),
                icon: const Icon(
                  Icons.volume_up_rounded,
                  size: 35,
                ),
              ),
              const SizedBox(height: 13),
              const Text(
                'Tap to play audio',
                style: TextStyle(
                  fontWeight: FontWeight.w700,
                ),
              ),
              if (_showTranscript) ...[
                const SizedBox(height: 14),
                Text(
                  _targetText,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    color: AppColors.warning,
                  ),
                ),
              ],
            ],
          ),
        ),
        const SizedBox(height: 18),
        ..._questionOptions().map(_buildOption),
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
    );
  }

  Widget _buildSpeakingQuestion() {
    return Column(
      children: [
        _buildPromptCard(_targetText),
        const SizedBox(height: 18),
        OutlinedButton.icon(
          onPressed: _playAudio,
          icon: const Icon(Icons.volume_up_rounded),
          label: const Text('Hear Example'),
        ),
        const SizedBox(height: 25),
        IconButton.filled(
          onPressed:
          _initializingSpeech || _answerChecked
              ? null
              : _toggleListening,
          style: IconButton.styleFrom(
            fixedSize: const Size(95, 95),
            backgroundColor: AppColors.primary,
          ),
          icon: _initializingSpeech
              ? const CircularProgressIndicator(
            color: Colors.white,
          )
              : Icon(
            _isListening
                ? Icons.stop_rounded
                : Icons.mic_rounded,
            color: Colors.white,
            size: 42,
          ),
        ),
        const SizedBox(height: 14),
        Text(
          _isListening
              ? 'Listening...'
              : 'Tap and speak',
        ),
        if (_recognizedText.isNotEmpty) ...[
          const SizedBox(height: 18),
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(15),
            decoration: BoxDecoration(
              color: AppColors.card,
              borderRadius: BorderRadius.circular(17),
            ),
            child: Text(
              'We heard: $_recognizedText',
            ),
          ),
        ],
      ],
    );
  }

  Widget _buildPromptCard(String text) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(21),
      decoration: BoxDecoration(
        color: AppColors.card,
        borderRadius: BorderRadius.circular(21),
        border: Border.all(color: AppColors.border),
      ),
      child: Text(
        text,
        textAlign: TextAlign.center,
        style: const TextStyle(
          fontSize: 20,
          height: 1.4,
          fontWeight: FontWeight.w800,
        ),
      ),
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
              ? AppColors.primary.withValues(alpha: 0.13)
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
          ),
        ),
      ),
    );
  }

  Widget _buildFeedback() {
    final color =
    _answerCorrect ? AppColors.success : AppColors.error;

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: color),
      ),
      child: Row(
        children: [
          Icon(
            _answerCorrect
                ? Icons.check_circle_rounded
                : Icons.cancel_rounded,
            color: color,
          ),
          const SizedBox(width: 11),
          Expanded(
            child: Text(
              _answerCorrect
                  ? 'Correct!'
                  : 'Correct answer: ${_correctAnswer()}',
              style: const TextStyle(
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildError() {
    return Container(
      padding: const EdgeInsets.all(15),
      decoration: BoxDecoration(
        color: AppColors.error.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(17),
        border: Border.all(color: AppColors.error),
      ),
      child: Text(_errorMessage!),
    );
  }

  Widget _buildBottomActions() {
    return Container(
      padding: const EdgeInsets.fromLTRB(20, 9, 20, 17),
      decoration: const BoxDecoration(
        color: AppColors.background,
        border: Border(
          top: BorderSide(color: AppColors.border),
        ),
      ),
      child: Column(
        children: [
          if (!_answerChecked)
            Align(
              alignment: Alignment.centerLeft,
              child: TextButton(
                onPressed: _skipQuestion,
                child: const Text('Skip'),
              ),
            ),
          ElevatedButton(
            onPressed:
            (_canCheck || _answerChecked) && !_isSaving
                ? _nextQuestion
                : null,
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
                  LessonTestData.questions.length -
                      1
                  ? 'View Result'
                  : 'Continue'
                  : 'Check Answer',
            ),
          ),
        ],
      ),
    );
  }

  String _questionTitle() {
    switch (_question.type) {
      case TestQuestionType.multipleChoice:
        return 'Choose the translation';

      case TestQuestionType.targetToNative:
        return 'Choose the meaning';

      case TestQuestionType.translationTyping:
        return 'Write the translation';

      case TestQuestionType.listening:
        return 'What did you hear?';

      case TestQuestionType.speaking:
        return 'Speak the sentence';
    }
  }

  String _questionInstruction() {
    switch (_question.type) {
      case TestQuestionType.multipleChoice:
        return 'Select the correct answer.';

      case TestQuestionType.targetToNative:
        return 'Choose the meaning in your language.';

      case TestQuestionType.translationTyping:
        return 'Type the complete translated sentence.';

      case TestQuestionType.listening:
        return 'Listen carefully and select the sentence.';

      case TestQuestionType.speaking:
        return 'Listen, then speak clearly.';
    }
  }
}
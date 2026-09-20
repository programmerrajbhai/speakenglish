import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:speech_to_text/speech_recognition_error.dart';
import 'package:speech_to_text/speech_recognition_result.dart';
import 'package:speech_to_text/speech_to_text.dart';

import '../../../core/theme/app_colors.dart';
import '../models/speaking_rule_model.dart';
import '../services/speaking_rule_progress_service.dart';

enum _PracticeResult {
  none,
  correct,
  almost,
  wrong,
  skipped,
}

class SpeakingRulePracticeScreen extends StatefulWidget {
  final SpeakingRule rule;
  final String nativeLanguageCode;
  final String learningSpeechLocale;

  const SpeakingRulePracticeScreen({
    super.key,
    required this.rule,
    required this.nativeLanguageCode,
    required this.learningSpeechLocale,
  });

  @override
  State<SpeakingRulePracticeScreen> createState() =>
      _SpeakingRulePracticeScreenState();
}

class _SpeakingRulePracticeScreenState
    extends State<SpeakingRulePracticeScreen> {
  final SpeechToText _speech = SpeechToText();
  final FlutterTts _tts = FlutterTts();

  int _currentIndex = 0;
  int _accuracy = 0;

  bool _isLoading = true;
  bool _isListening = false;
  bool _isInitializingSpeech = false;
  bool _speechInitialized = false;
  bool _isSaving = false;
  bool _showHint = false;

  String? _selectedOption;
  String? _speechLocale;
  String? _errorMessage;

  String _recognizedText = '';

  final List<String> _arrangedWords = [];
  final List<String> _availableWords = [];

  _PracticeResult _result = _PracticeResult.none;

  SpeakingPracticeItem get _practice =>
      widget.rule.practices[_currentIndex];

  bool get _requiresSpeech {
    return switch (_practice.type) {
      SpeakingPracticeType.translateAndSpeak ||
      SpeakingPracticeType.listenAndRepeat ||
      SpeakingPracticeType.pictureSpeaking ||
      SpeakingPracticeType.questionAnswer ||
      SpeakingPracticeType.errorCorrection ||
      SpeakingPracticeType.situationSpeaking ||
      SpeakingPracticeType.conversation =>
      true,
      _ => false,
    };
  }

  @override
  void initState() {
    super.initState();
    _initialize();
  }

  Future<void> _initialize() async {
    await _tts.setLanguage(widget.learningSpeechLocale);
    await _tts.setVolume(1);
    await _tts.setPitch(1);
    await _tts.setSpeechRate(0.43);

    final progress =
    await SpeakingRuleProgressService.getProgress(
      widget.rule.id,
    );

    if (!mounted) return;

    final savedIndex = progress.completed
        ? 0
        : progress.currentPractice.clamp(
      0,
      widget.rule.practices.length - 1,
    );

    setState(() {
      _currentIndex = savedIndex;
      _isLoading = false;
    });

    _preparePractice();
  }

  void _preparePractice() {
    _selectedOption = null;
    _recognizedText = '';
    _accuracy = 0;
    _errorMessage = null;
    _result = _PracticeResult.none;
    _showHint = false;
    _isListening = false;

    _arrangedWords.clear();
    _availableWords
      ..clear()
      ..addAll(_practice.words);

    if (mounted) {
      setState(() {});
    }
  }

  Future<bool> _initializeSpeech() async {
    if (_speechInitialized) return true;
    if (_isInitializingSpeech) return false;

    setState(() {
      _isInitializingSpeech = true;
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
        _isInitializingSpeech = false;
        _errorMessage =
        'Microphone or speech recognition permission was denied.';
      });
      return false;
    }

    final locales = await _speech.locales();
    final requested = widget.learningSpeechLocale
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
      _isInitializingSpeech = false;
      _speechLocale =
          matchedLocale ?? widget.learningSpeechLocale;
    });

    return true;
  }

  Future<void> _toggleListening() async {
    if (_result != _PracticeResult.none) return;

    if (_isListening) {
      await _stopListening();
      return;
    }

    final available = await _initializeSpeech();

    if (!available || !mounted) return;

    await _tts.stop();

    setState(() {
      _recognizedText = '';
      _accuracy = 0;
      _errorMessage = null;
    });

    await _speech.listen(
      onResult: _onSpeechResult,
      localeId: _speechLocale,
      listenFor: const Duration(seconds: 20),
      pauseFor: const Duration(seconds: 3),
    );

    if (!mounted) return;

    setState(() {
      _isListening = _speech.isListening;
    });
  }

  Future<void> _stopListening() async {
    await _speech.stop();

    if (!mounted) return;

    setState(() {
      _isListening = false;
    });

    if (_recognizedText.trim().isNotEmpty) {
      _evaluateSpeech();
    }
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

      _evaluateSpeech();
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

    String message =
        'Could not recognize your voice. Try again.';

    if (error.errorMsg.contains('permission')) {
      message = 'Microphone permission is required.';
    } else if (error.errorMsg.contains('no-speech') ||
        error.errorMsg.contains('speech timeout')) {
      message = 'No speech was detected. Speak slowly.';
    } else if (error.errorMsg.contains('network')) {
      message =
      'Speech recognition needs an internet connection.';
    }

    setState(() {
      _isListening = false;
      _errorMessage = message;
    });
  }

  Future<void> _playTarget({
    bool slow = false,
  }) async {
    await _speech.stop();
    await _tts.stop();

    await _tts.setSpeechRate(slow ? 0.28 : 0.43);

    final text = _practice.question?.trim().isNotEmpty == true
        ? _practice.question!
        : _practice.targetSentence;

    await _tts.speak(text);
  }

  void _selectOption(String option) {
    if (_result != _PracticeResult.none) return;

    setState(() {
      _selectedOption = option;
    });
  }

  void _addWord(String word) {
    if (_result != _PracticeResult.none) return;

    setState(() {
      _availableWords.remove(word);
      _arrangedWords.add(word);
    });
  }

  void _removeWord(String word) {
    if (_result != _PracticeResult.none) return;

    setState(() {
      _arrangedWords.remove(word);
      _availableWords.add(word);
    });
  }

  void _checkNonSpeakingAnswer() {
    if (_result != _PracticeResult.none) return;

    String answer = '';

    if (_practice.type ==
        SpeakingPracticeType.wordOrder) {
      answer = _arrangedWords.join(' ');
    } else {
      answer = _selectedOption ?? '';
    }

    if (answer.trim().isEmpty) {
      setState(() {
        _errorMessage = 'Select or create an answer first.';
      });
      return;
    }

    final correct = _normalize(answer) ==
        _normalize(_practice.targetSentence);

    HapticFeedback.mediumImpact();
    SystemSound.play(
      correct
          ? SystemSoundType.click
          : SystemSoundType.alert,
    );

    setState(() {
      _accuracy = correct ? 100 : 0;
      _result = correct
          ? _PracticeResult.correct
          : _PracticeResult.wrong;
      _errorMessage = null;
    });
  }

  void _evaluateSpeech() {
    if (_recognizedText.trim().isEmpty ||
        _result != _PracticeResult.none) {
      return;
    }

    final accuracy = _calculateSimilarity(
      _recognizedText,
      _practice.targetSentence,
    );

    final _PracticeResult result;

    if (accuracy >= 85) {
      result = _PracticeResult.correct;
      HapticFeedback.mediumImpact();
      SystemSound.play(SystemSoundType.click);
    } else if (accuracy >= 60) {
      result = _PracticeResult.almost;
      HapticFeedback.lightImpact();
      SystemSound.play(SystemSoundType.click);
    } else {
      result = _PracticeResult.wrong;
      HapticFeedback.heavyImpact();
      SystemSound.play(SystemSoundType.alert);
    }

    setState(() {
      _accuracy = accuracy;
      _result = result;
    });
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

    final previous = List<int>.generate(
      secondRunes.length + 1,
          (index) => index,
    );

    final current = List<int>.filled(
      secondRunes.length + 1,
      0,
    );

    for (var i = 1; i <= firstRunes.length; i++) {
      current[0] = i;

      for (var j = 1; j <= secondRunes.length; j++) {
        final cost =
        firstRunes[i - 1] == secondRunes[j - 1]
            ? 0
            : 1;

        final deletion = previous[j] + 1;
        final insertion = current[j - 1] + 1;
        final substitution = previous[j - 1] + cost;

        current[j] = [
          deletion,
          insertion,
          substitution,
        ].reduce((a, b) => a < b ? a : b);
      }

      for (var j = 0; j <= secondRunes.length; j++) {
        previous[j] = current[j];
      }
    }

    final maximumLength =
    firstRunes.length > secondRunes.length
        ? firstRunes.length
        : secondRunes.length;

    return ((1 - previous[secondRunes.length] /
        maximumLength) *
        100)
        .clamp(0, 100)
        .round();
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

  void _retry() {
    _preparePractice();
  }

  Future<void> _skip() async {
    if (_isSaving) return;

    await _speech.stop();

    setState(() {
      _accuracy = 0;
      _result = _PracticeResult.skipped;
      _recognizedText = '';
    });

    HapticFeedback.heavyImpact();
    SystemSound.play(SystemSoundType.alert);
  }

  Future<void> _continue() async {
    if (_result == _PracticeResult.none || _isSaving) {
      return;
    }

    setState(() {
      _isSaving = true;
    });

    final nextIndex = _currentIndex <
        widget.rule.practices.length - 1
        ? _currentIndex + 1
        : _currentIndex;

    if (_result == _PracticeResult.skipped) {
      await SpeakingRuleProgressService.saveSkip(
        ruleId: widget.rule.id,
        practiceId: _practice.id,
        nextPracticeIndex: nextIndex,
      );
    } else {
      await SpeakingRuleProgressService.saveAttempt(
        ruleId: widget.rule.id,
        practiceId: _practice.id,
        accuracy: _accuracy,
        nextPracticeIndex: nextIndex,
      );
    }

    if (!mounted) return;

    if (_currentIndex <
        widget.rule.practices.length - 1) {
      setState(() {
        _currentIndex++;
        _isSaving = false;
      });

      _preparePractice();
      return;
    }

    await _showFinalResult();
  }

  Future<void> _showFinalResult() async {
    final progress =
    await SpeakingRuleProgressService.getProgress(
      widget.rule.id,
    );

    if (!mounted) return;

    final passed = progress.completed;

    final close = await showDialog<bool>(
      context: context,
      barrierDismissible: false,
      builder: (dialogContext) {
        return AlertDialog(
          icon: Icon(
            passed
                ? Icons.emoji_events_rounded
                : Icons.refresh_rounded,
            color: passed
                ? AppColors.success
                : AppColors.warning,
            size: 52,
          ),
          title: Text(
            passed
                ? 'Rule Completed!'
                : 'Practice Again',
            textAlign: TextAlign.center,
          ),
          content: Text(
            'Completed: ${progress.processedCount}/20\n'
                'Answered: ${progress.answeredCount}/20\n'
                'Skipped: ${progress.skippedCount}\n'
                'Average accuracy: ${progress.averageAccuracy}%\n\n'
                '${passed ? 'The next rule is now unlocked.' : 'Complete at least 15 practices with 60% accuracy.'}',
            textAlign: TextAlign.center,
          ),
          actionsAlignment: MainAxisAlignment.center,
          actions: [
            FilledButton(
              onPressed: () {
                Navigator.pop(dialogContext, true);
              },
              child: Text(
                passed ? 'Continue' : 'Back to Rule',
              ),
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
    _speech.cancel();
    _tts.stop();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (_isLoading) {
      return const Scaffold(
        backgroundColor: AppColors.background,
        body: Center(
          child: CircularProgressIndicator(
            color: AppColors.primary,
          ),
        ),
      );
    }

    final progress =
        (_currentIndex + 1) / widget.rule.practices.length;

    return PopScope(
      canPop: !_isSaving,
      onPopInvokedWithResult: (_, __) {
        _speech.cancel();
        _tts.stop();
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
                  padding: const EdgeInsets.fromLTRB(
                    20,
                    15,
                    20,
                    30,
                  ),
                  children: [
                    Text(
                      _practice.instruction,
                      style: const TextStyle(
                        fontSize: 23,
                        fontWeight: FontWeight.w900,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      _practiceTypeName(_practice.type),
                      style: const TextStyle(
                        color: AppColors.primary,
                        fontSize: 12,
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                    const SizedBox(height: 21),
                    _buildQuestionCard(),
                    const SizedBox(height: 18),
                    _buildInteraction(),
                    if (_showHint) ...[
                      const SizedBox(height: 17),
                      _buildHint(),
                    ],
                    if (_recognizedText.isNotEmpty) ...[
                      const SizedBox(height: 17),
                      _buildRecognizedText(),
                    ],
                    if (_errorMessage != null) ...[
                      const SizedBox(height: 17),
                      _buildError(),
                    ],
                    if (_result != _PracticeResult.none) ...[
                      const SizedBox(height: 18),
                      _buildResult(),
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
      padding: const EdgeInsets.fromLTRB(10, 10, 18, 10),
      child: Row(
        children: [
          IconButton(
            onPressed: _isSaving
                ? null
                : () => Navigator.pop(context),
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
          const SizedBox(width: 12),
          Text(
            '${_currentIndex + 1}/20',
            style: const TextStyle(
              color: AppColors.textSecondary,
              fontWeight: FontWeight.w800,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildQuestionCard() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(21),
      decoration: BoxDecoration(
        color: AppColors.card,
        borderRadius: BorderRadius.circular(23),
        border: Border.all(
          color: AppColors.primary.withValues(alpha: 0.35),
        ),
      ),
      child: Column(
        children: [
          if (_practice.question != null) ...[
            const Icon(
              Icons.forum_rounded,
              color: AppColors.primary,
              size: 31,
            ),
            const SizedBox(height: 12),
            Text(
              _practice.question!,
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontSize: 18,
                height: 1.4,
                fontWeight: FontWeight.w800,
              ),
            ),
            const SizedBox(height: 14),
          ],
          Text(
            _practice.nativeText(
              widget.nativeLanguageCode,
            ),
            textAlign: TextAlign.center,
            style: const TextStyle(
              color: AppColors.textSecondary,
              fontSize: 15,
              height: 1.5,
            ),
          ),
          if (_practice.type ==
              SpeakingPracticeType.listenAndRepeat ||
              _practice.question != null) ...[
            const SizedBox(height: 17),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                OutlinedButton.icon(
                  onPressed: () => _playTarget(),
                  icon: const Icon(Icons.volume_up_rounded),
                  label: const Text('Listen'),
                ),
                const SizedBox(width: 9),
                OutlinedButton.icon(
                  onPressed: () => _playTarget(slow: true),
                  icon: const Icon(Icons.slow_motion_video),
                  label: const Text('Slow'),
                ),
              ],
            ),
          ],
        ],
      ),
    );
  }

  Widget _buildInteraction() {
    return switch (_practice.type) {
      SpeakingPracticeType.structureChoice ||
      SpeakingPracticeType.fillBlank =>
          _buildOptions(),
      SpeakingPracticeType.wordOrder =>
          _buildWordArrangement(),
      _ => _buildSpeakingArea(),
    };
  }

  Widget _buildOptions() {
    return Column(
      children: _practice.options.map((option) {
        final selected = option == _selectedOption;

        return Padding(
          padding: const EdgeInsets.only(bottom: 11),
          child: InkWell(
            onTap: () => _selectOption(option),
            borderRadius: BorderRadius.circular(17),
            child: Container(
              width: double.infinity,
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: selected
                    ? AppColors.primary.withValues(alpha: 0.13)
                    : AppColors.card,
                borderRadius: BorderRadius.circular(17),
                border: Border.all(
                  color: selected
                      ? AppColors.primary
                      : AppColors.border,
                  width: selected ? 1.5 : 1,
                ),
              ),
              child: Row(
                children: [
                  Expanded(
                    child: Text(
                      option,
                      style: const TextStyle(
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                  Icon(
                    selected
                        ? Icons.radio_button_checked_rounded
                        : Icons.radio_button_off_rounded,
                    color: selected
                        ? AppColors.primary
                        : AppColors.textSecondary,
                  ),
                ],
              ),
            ),
          ),
        );
      }).toList(),
    );
  }

  Widget _buildWordArrangement() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: double.infinity,
          constraints: const BoxConstraints(minHeight: 84),
          padding: const EdgeInsets.all(13),
          decoration: BoxDecoration(
            color: AppColors.card,
            borderRadius: BorderRadius.circular(18),
            border: Border.all(color: AppColors.border),
          ),
          child: Wrap(
            spacing: 8,
            runSpacing: 8,
            children: _arrangedWords.map((word) {
              return ActionChip(
                onPressed: () => _removeWord(word),
                label: Text(word),
              );
            }).toList(),
          ),
        ),
        const SizedBox(height: 17),
        Wrap(
          spacing: 9,
          runSpacing: 9,
          children: _availableWords.map((word) {
            return ActionChip(
              onPressed: () => _addWord(word),
              backgroundColor:
              AppColors.primary.withValues(alpha: 0.12),
              side: BorderSide(
                color:
                AppColors.primary.withValues(alpha: 0.40),
              ),
              label: Text(word),
            );
          }).toList(),
        ),
      ],
    );
  }

  Widget _buildSpeakingArea() {
    return Column(
      children: [
        AnimatedContainer(
          duration: const Duration(milliseconds: 250),
          width: _isListening ? 132 : 112,
          height: _isListening ? 132 : 112,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: AppColors.primary.withValues(alpha: 0.14),
            boxShadow: [
              BoxShadow(
                color: AppColors.primary.withValues(
                  alpha: _isListening ? 0.55 : 0.25,
                ),
                blurRadius: _isListening ? 40 : 24,
                spreadRadius: _isListening ? 7 : 2,
              ),
            ],
          ),
          child: Center(
            child: IconButton(
              onPressed: _isInitializingSpeech ||
                  _result != _PracticeResult.none
                  ? null
                  : _toggleListening,
              style: IconButton.styleFrom(
                fixedSize: const Size(78, 78),
                backgroundColor: AppColors.primary,
              ),
              icon: _isInitializingSpeech
                  ? const CircularProgressIndicator(
                color: Colors.white,
                strokeWidth: 2.5,
              )
                  : Icon(
                _isListening
                    ? Icons.stop_rounded
                    : Icons.mic_rounded,
                color: Colors.white,
                size: 38,
              ),
            ),
          ),
        ),
        const SizedBox(height: 17),
        Text(
          _isListening
              ? 'Listening... Tap to stop'
              : 'Tap the microphone and speak',
          style: const TextStyle(
            color: AppColors.textSecondary,
            fontWeight: FontWeight.w700,
          ),
        ),
        const SizedBox(height: 12),
        TextButton.icon(
          onPressed: () => _playTarget(),
          icon: const Icon(Icons.volume_up_rounded),
          label: const Text('Hear correct answer'),
        ),
      ],
    );
  }

  Widget _buildHint() {
    return Container(
      padding: const EdgeInsets.all(15),
      decoration: BoxDecoration(
        color: AppColors.warning.withValues(alpha: 0.10),
        borderRadius: BorderRadius.circular(17),
        border: Border.all(
          color: AppColors.warning.withValues(alpha: 0.45),
        ),
      ),
      child: Row(
        children: [
          const Icon(
            Icons.lightbulb_rounded,
            color: AppColors.warning,
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Text(
              _practice.hint,
              style: const TextStyle(height: 1.4),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildRecognizedText() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.card,
        borderRadius: BorderRadius.circular(17),
        border: Border.all(color: AppColors.border),
      ),
      child: Text(
        'We heard:\n$_recognizedText',
        style: const TextStyle(
          fontSize: 15,
          height: 1.5,
          fontWeight: FontWeight.w700,
        ),
      ),
    );
  }

  Widget _buildError() {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: AppColors.error.withValues(alpha: 0.10),
        borderRadius: BorderRadius.circular(17),
        border: Border.all(color: AppColors.error),
      ),
      child: Row(
        children: [
          const Icon(
            Icons.error_outline_rounded,
            color: AppColors.error,
          ),
          const SizedBox(width: 10),
          Expanded(child: Text(_errorMessage!)),
        ],
      ),
    );
  }

  Widget _buildResult() {
    final (color, icon, title) = switch (_result) {
      _PracticeResult.correct => (
      AppColors.success,
      Icons.check_circle_rounded,
      'Correct!',
      ),
      _PracticeResult.almost => (
      AppColors.warning,
      Icons.thumb_up_rounded,
      'Almost correct!',
      ),
      _PracticeResult.wrong => (
      AppColors.error,
      Icons.refresh_rounded,
      'Try again',
      ),
      _PracticeResult.skipped => (
      AppColors.textSecondary,
      Icons.skip_next_rounded,
      'Skipped',
      ),
      _ => (
      AppColors.textSecondary,
      Icons.info_rounded,
      '',
      ),
    };

    return Container(
      padding: const EdgeInsets.all(17),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.10),
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: color),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(icon, color: color),
              const SizedBox(width: 9),
              Expanded(
                child: Text(
                  title,
                  style: TextStyle(
                    color: color,
                    fontWeight: FontWeight.w900,
                  ),
                ),
              ),
              if (_result != _PracticeResult.skipped)
                Text(
                  '$_accuracy%',
                  style: TextStyle(
                    color: color,
                    fontWeight: FontWeight.w900,
                  ),
                ),
            ],
          ),
          const SizedBox(height: 11),
          Text(
            'Correct answer: ${_practice.targetSentence}',
            style: const TextStyle(
              fontWeight: FontWeight.w800,
            ),
          ),
          const SizedBox(height: 7),
          Text(
            _practice.explanation,
            style: const TextStyle(
              color: AppColors.textSecondary,
              fontSize: 12,
              height: 1.5,
            ),
          ),
        ],
      ),
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
          if (_result == _PracticeResult.none)
            Row(
              children: [
                TextButton(
                  onPressed: _isListening ? null : _skip,
                  child: const Text('Skip'),
                ),
                const Spacer(),
                TextButton.icon(
                  onPressed: () {
                    setState(() {
                      _showHint = !_showHint;
                    });
                  },
                  icon: const Icon(Icons.lightbulb_outline),
                  label: const Text('Hint'),
                ),
              ],
            ),
          if (_result == _PracticeResult.wrong ||
              _result == _PracticeResult.almost)
            Row(
              children: [
                Expanded(
                  child: OutlinedButton(
                    onPressed: _retry,
                    child: const Text('Try Again'),
                  ),
                ),
                const SizedBox(width: 11),
                Expanded(
                  child: ElevatedButton(
                    onPressed: _continue,
                    child: const Text('Continue'),
                  ),
                ),
              ],
            )
          else
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: _isSaving
                    ? null
                    : _result == _PracticeResult.none
                    ? (_requiresSpeech
                    ? null
                    : _checkNonSpeakingAnswer)
                    : _continue,
                child: _isSaving
                    ? const SizedBox(
                  width: 21,
                  height: 21,
                  child: CircularProgressIndicator(
                    color: Colors.white,
                    strokeWidth: 2.4,
                  ),
                )
                    : Text(
                  _result == _PracticeResult.none
                      ? 'Check Answer'
                      : _currentIndex == 19
                      ? 'Finish Rule'
                      : 'Continue',
                ),
              ),
            ),
        ],
      ),
    );
  }

  String _practiceTypeName(
      SpeakingPracticeType type,
      ) {
    return switch (type) {
      SpeakingPracticeType.structureChoice =>
      'STRUCTURE CHOICE',
      SpeakingPracticeType.fillBlank =>
      'FILL IN THE BLANK',
      SpeakingPracticeType.wordOrder =>
      'WORD ARRANGEMENT',
      SpeakingPracticeType.translateAndSpeak =>
      'TRANSLATE AND SPEAK',
      SpeakingPracticeType.listenAndRepeat =>
      'LISTEN AND REPEAT',
      SpeakingPracticeType.pictureSpeaking =>
      'PICTURE SPEAKING',
      SpeakingPracticeType.questionAnswer =>
      'QUESTION AND ANSWER',
      SpeakingPracticeType.errorCorrection =>
      'ERROR CORRECTION',
      SpeakingPracticeType.situationSpeaking =>
      'REAL-LIFE SPEAKING',
      SpeakingPracticeType.conversation =>
      'MINI CONVERSATION',
    };
  }
}
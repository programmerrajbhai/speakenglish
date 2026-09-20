import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:speech_to_text/speech_recognition_error.dart';
import 'package:speech_to_text/speech_recognition_result.dart';
import 'package:speech_to_text/speech_to_text.dart';

import '../../../../core/theme/app_colors.dart';
import '../../onboarding/lessons/models/lesson_model.dart';
import '../../onboarding/lessons/services/lesson_progress_service.dart';
import '../../onboarding/model/onboarding_setup.dart';
import '../data/speaking_data.dart';


class SpeakingScreen extends StatefulWidget {
  final LessonModel lesson;
  final OnboardingSetup setup;

  const SpeakingScreen({
    super.key,
    required this.lesson,
    required this.setup,
  });

  @override
  State<SpeakingScreen> createState() =>
      _SpeakingScreenState();
}

enum _SpeakingResult {
  none,
  correct,
  almost,
  tryAgain,
  skipped,
}

class _SpeakingScreenState extends State<SpeakingScreen> {
  final SpeechToText _speech = SpeechToText();
  final FlutterTts _flutterTts = FlutterTts();

  int _currentIndex = 0;
  int _totalScore = 0;
  int _currentAccuracy = 0;

  bool _speechInitialized = false;
  bool _initializingSpeech = false;
  bool _isListening = false;
  bool _isSaving = false;

  String _recognizedText = '';
  String? _recognitionLocale;
  String? _errorMessage;

  _SpeakingResult _result = _SpeakingResult.none;

  int get _exampleIndex =>
      SpeakingData.exampleIndexes[_currentIndex];

  LessonExample get _example =>
      widget.lesson.examples[_exampleIndex];

  String get _targetSentence => _example.textFor(
    widget.setup.learningLanguage.code,
  );

  String get _nativeSentence => _example.textFor(
    widget.setup.nativeLanguage.code,
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
        'Microphone or speech recognition permission was denied.';
      });

      _showPermissionDialog();
      return false;
    }

    final locales = await _speech.locales();
    final requestedLocale =
        widget.setup.learningLanguage.speechLocale;

    String? matchedLocale;

    for (final locale in locales) {
      final installed = locale.localeId
          .replaceAll('_', '-')
          .toLowerCase();

      final requested = requestedLocale
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
      _recognitionLocale =
          matchedLocale ?? requestedLocale;
    });

    return true;
  }

  Future<void> _toggleListening() async {
    if (_result != _SpeakingResult.none) return;

    if (_isListening) {
      await _stopListening();
      return;
    }

    final available = await _initializeSpeech();

    if (!available || !mounted) return;

    await _flutterTts.stop();

    setState(() {
      _recognizedText = '';
      _currentAccuracy = 0;
      _errorMessage = null;
    });

    await _speech.listen(
      onResult: _onSpeechResult,
      localeId: _recognitionLocale,
      listenFor: const Duration(seconds: 15),
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

    final listening =
        status == 'listening' || _speech.isListening;

    setState(() {
      _isListening = listening;
    });
  }

  void _onSpeechError(SpeechRecognitionError error) {
    if (!mounted) return;

    setState(() {
      _isListening = false;
      _errorMessage = _friendlySpeechError(
        error.errorMsg,
      );
    });
  }

  String _friendlySpeechError(String error) {
    if (error.contains('permission')) {
      return 'Microphone permission is required.';
    }

    if (error.contains('no-speech') ||
        error.contains('speech timeout')) {
      return 'No speech was detected. Please try again.';
    }

    if (error.contains('network')) {
      return 'Speech recognition needs an internet connection.';
    }

    return 'Could not recognize your voice. Please try again.';
  }

  Future<void> _playExample() async {
    if (_isListening) {
      await _speech.stop();
    }

    await _flutterTts.stop();
    await _flutterTts.speak(_targetSentence);
  }

  void _evaluateSpeech() {
    if (_recognizedText.trim().isEmpty ||
        _result != _SpeakingResult.none) {
      return;
    }

    final accuracy = _calculateSimilarity(
      _recognizedText,
      _targetSentence,
    );

    _SpeakingResult result;

    if (accuracy >= 85) {
      result = _SpeakingResult.correct;
      HapticFeedback.mediumImpact();
      SystemSound.play(SystemSoundType.click);
    } else if (accuracy >= 60) {
      result = _SpeakingResult.almost;
      HapticFeedback.lightImpact();
      SystemSound.play(SystemSoundType.click);
    } else {
      result = _SpeakingResult.tryAgain;
      HapticFeedback.heavyImpact();
      SystemSound.play(SystemSoundType.alert);
    }

    setState(() {
      _currentAccuracy = accuracy;
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

    final distance = _levenshteinDistance(
      first.runes.toList(),
      second.runes.toList(),
    );

    final maximumLength = first.runes.length >
        second.runes.length
        ? first.runes.length
        : second.runes.length;

    final similarity =
        (1 - (distance / maximumLength)) * 100;

    return similarity.clamp(0, 100).round();
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
    setState(() {
      _recognizedText = '';
      _currentAccuracy = 0;
      _errorMessage = null;
      _result = _SpeakingResult.none;
    });
  }

  Future<void> _skip() async {
    if (_isListening) {
      await _speech.stop();
    }

    await HapticFeedback.heavyImpact();
    await SystemSound.play(SystemSoundType.alert);

    if (!mounted) return;

    setState(() {
      _recognizedText = '';
      _currentAccuracy = 0;
      _result = _SpeakingResult.skipped;
    });
  }

  Future<void> _continue() async {
    if (_result == _SpeakingResult.none) return;

    if (_result == _SpeakingResult.correct ||
        _result == _SpeakingResult.almost) {
      _totalScore += _currentAccuracy;
    }

    if (_currentIndex <
        SpeakingData.exampleIndexes.length - 1) {
      setState(() {
        _currentIndex++;
        _recognizedText = '';
        _currentAccuracy = 0;
        _errorMessage = null;
        _result = _SpeakingResult.none;
        _isListening = false;
      });

      return;
    }

    await _completeSpeaking();
  }

  Future<void> _completeSpeaking() async {
    if (_isSaving) return;

    setState(() {
      _isSaving = true;
    });

    await _speech.stop();
    await _flutterTts.stop();

    final averageScore =
    (_totalScore / SpeakingData.exampleIndexes.length)
        .round();

    await LessonProgressService.saveSpeakingResult(
      lessonId: widget.lesson.id,
      score: averageScore,
    );

    if (!mounted) return;

    final close = await showDialog<bool>(
      context: context,
      barrierDismissible: false,
      builder: (dialogContext) {
        return AlertDialog(
          icon: Icon(
            averageScore >= 70
                ? Icons.record_voice_over_rounded
                : Icons.refresh_rounded,
            color: averageScore >= 70
                ? AppColors.success
                : AppColors.primary,
            size: 52,
          ),
          title: Text(
            averageScore >= 70
                ? 'Speaking Completed!'
                : 'Keep Practicing!',
            textAlign: TextAlign.center,
          ),
          content: Text(
            'Your average speaking score is '
                '$averageScore%.\n'
                'Conversation practice is now unlocked.',
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

  void _showPermissionDialog() {
    showDialog<void>(
      context: context,
      builder: (dialogContext) {
        return AlertDialog(
          icon: const Icon(
            Icons.mic_off_rounded,
            color: AppColors.error,
            size: 45,
          ),
          title: const Text('Microphone access required'),
          content: const Text(
            'Allow microphone and speech recognition access '
                'from your device settings to use speaking practice.',
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(dialogContext);
              },
              child: const Text('Okay'),
            ),
          ],
        );
      },
    );
  }

  @override
  void dispose() {
    _speech.cancel();
    _flutterTts.stop();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final progress =
        (_currentIndex + 1) /
            SpeakingData.exampleIndexes.length;

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
                  physics: const BouncingScrollPhysics(),
                  padding:
                  const EdgeInsets.fromLTRB(21, 15, 21, 30),
                  children: [
                    const Text(
                      'Speak this sentence',
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                    const SizedBox(height: 7),
                    const Text(
                      'Listen first, then tap the microphone and speak.',
                      style: TextStyle(
                        color: AppColors.textSecondary,
                        fontSize: 13,
                      ),
                    ),
                    const SizedBox(height: 23),
                    _buildSentenceCard(),
                    const SizedBox(height: 27),
                    _buildMicrophoneArea(),
                    if (_recognizedText.isNotEmpty) ...[
                      const SizedBox(height: 25),
                      _buildRecognizedText(),
                    ],
                    if (_errorMessage != null) ...[
                      const SizedBox(height: 18),
                      _buildError(),
                    ],
                    if (_result != _SpeakingResult.none) ...[
                      const SizedBox(height: 20),
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
                '${SpeakingData.exampleIndexes.length}',
            style: const TextStyle(
              color: AppColors.textSecondary,
              fontWeight: FontWeight.w700,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSentenceCard() {
    return Container(
      padding: const EdgeInsets.all(21),
      decoration: BoxDecoration(
        color: AppColors.card,
        borderRadius: BorderRadius.circular(24),
        border: Border.all(
          color: AppColors.primary.withValues(alpha: 0.4),
        ),
      ),
      child: Column(
        children: [
          Text(
            _nativeSentence,
            textAlign: TextAlign.center,
            style: const TextStyle(
              color: AppColors.textSecondary,
              fontSize: 15,
              height: 1.4,
            ),
          ),
          const SizedBox(height: 16),
          Text(
            _targetSentence,
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontSize: 24,
              height: 1.3,
              fontWeight: FontWeight.w800,
            ),
          ),
          const SizedBox(height: 19),
          OutlinedButton.icon(
            onPressed: _playExample,
            icon: const Icon(Icons.volume_up_rounded),
            label: const Text('Hear Example'),
          ),
        ],
      ),
    );
  }

  Widget _buildMicrophoneArea() {
    return Column(
      children: [
        AnimatedContainer(
          duration: const Duration(milliseconds: 250),
          width: _isListening ? 132 : 112,
          height: _isListening ? 132 : 112,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            gradient: RadialGradient(
              colors: [
                AppColors.primary.withValues(
                  alpha: _isListening ? 0.65 : 0.35,
                ),
                AppColors.primary.withValues(alpha: 0.08),
              ],
            ),
            boxShadow: [
              BoxShadow(
                color: AppColors.primary.withValues(
                  alpha: _isListening ? 0.6 : 0.3,
                ),
                blurRadius: _isListening ? 42 : 25,
                spreadRadius: _isListening ? 7 : 2,
              ),
            ],
          ),
          child: Center(
            child: IconButton(
              onPressed: _initializingSpeech ||
                  _result != _SpeakingResult.none
                  ? null
                  : _toggleListening,
              style: IconButton.styleFrom(
                fixedSize: const Size(78, 78),
                backgroundColor: AppColors.primary,
              ),
              icon: _initializingSpeech
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
        const SizedBox(height: 18),
        Text(
          _isListening
              ? 'Listening... Tap to stop'
              : 'Tap the microphone to speak',
          style: TextStyle(
            color: _isListening
                ? AppColors.primaryLight
                : AppColors.textSecondary,
            fontWeight: FontWeight.w700,
          ),
        ),
      ],
    );
  }

  Widget _buildRecognizedText() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(17),
      decoration: BoxDecoration(
        color: AppColors.card,
        borderRadius: BorderRadius.circular(19),
        border: Border.all(color: AppColors.border),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'We heard:',
            style: TextStyle(
              color: AppColors.textSecondary,
              fontSize: 11,
              fontWeight: FontWeight.w700,
            ),
          ),
          const SizedBox(height: 7),
          Text(
            _recognizedText,
            style: const TextStyle(
              fontSize: 17,
              height: 1.4,
              fontWeight: FontWeight.w700,
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
      child: Row(
        children: [
          const Icon(
            Icons.error_outline_rounded,
            color: AppColors.error,
          ),
          const SizedBox(width: 11),
          Expanded(
            child: Text(_errorMessage!),
          ),
        ],
      ),
    );
  }

  Widget _buildResult() {
    Color color;
    IconData icon;
    String title;
    String message;

    switch (_result) {
      case _SpeakingResult.correct:
        color = AppColors.success;
        icon = Icons.check_circle_rounded;
        title = 'Correct!';
        message = 'Excellent pronunciation.';

      case _SpeakingResult.almost:
        color = AppColors.warning;
        icon = Icons.thumb_up_alt_rounded;
        title = 'Almost correct!';
        message = 'Good attempt. Try to speak more clearly.';

      case _SpeakingResult.tryAgain:
        color = AppColors.error;
        icon = Icons.refresh_rounded;
        title = 'Try again';
        message = 'Listen to the example and speak slowly.';

      case _SpeakingResult.skipped:
        color = AppColors.textSecondary;
        icon = Icons.skip_next_rounded;
        title = 'Skipped';
        message = 'You can practice this sentence again later.';

      case _SpeakingResult.none:
        color = AppColors.textSecondary;
        icon = Icons.mic_rounded;
        title = '';
        message = '';
    }

    return Container(
      padding: const EdgeInsets.all(17),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(19),
        border: Border.all(color: color),
      ),
      child: Row(
        children: [
          Icon(icon, color: color, size: 29),
          const SizedBox(width: 13),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Text(
                      title,
                      style: TextStyle(
                        color: color,
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                    if (_result != _SpeakingResult.skipped) ...[
                      const Spacer(),
                      Text(
                        '$_currentAccuracy%',
                        style: TextStyle(
                          color: color,
                          fontWeight: FontWeight.w800,
                        ),
                      ),
                    ],
                  ],
                ),
                const SizedBox(height: 5),
                Text(
                  message,
                  style: const TextStyle(
                    fontSize: 12,
                    height: 1.4,
                  ),
                ),
              ],
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
          if (_result == _SpeakingResult.none)
            Align(
              alignment: Alignment.centerLeft,
              child: TextButton(
                onPressed: _isListening ? null : _skip,
                child: const Text('Skip'),
              ),
            ),
          if (_result == _SpeakingResult.tryAgain ||
              _result == _SpeakingResult.almost)
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
            ElevatedButton(
              onPressed: _result == _SpeakingResult.none ||
                  _isSaving
                  ? null
                  : _continue,
              style: ElevatedButton.styleFrom(
                disabledBackgroundColor: AppColors.card,
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
                _currentIndex ==
                    SpeakingData.exampleIndexes.length - 1
                    ? 'Finish Speaking'
                    : 'Continue',
              ),
            ),
        ],
      ),
    );
  }
}
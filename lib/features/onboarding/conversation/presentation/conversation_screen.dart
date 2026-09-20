import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:speech_to_text/speech_recognition_error.dart';
import 'package:speech_to_text/speech_recognition_result.dart';
import 'package:speech_to_text/speech_to_text.dart';
import '../../../../core/theme/app_colors.dart';
import '../../lessons/models/lesson_model.dart';
import '../../lessons/services/lesson_progress_service.dart';
import '../../model/onboarding_setup.dart';
import '../data/conversation_data.dart';
import '../models/conversation_turn.dart';

class ConversationScreen extends StatefulWidget {
  final LessonModel lesson;
  final OnboardingSetup setup;

  const ConversationScreen({
    super.key,
    required this.lesson,
    required this.setup,
  });

  @override
  State<ConversationScreen> createState() =>
      _ConversationScreenState();
}

class _ChatMessage {
  final String text;
  final bool isUser;
  final bool isCorrect;

  const _ChatMessage({
    required this.text,
    required this.isUser,
    this.isCorrect = true,
  });
}

class _ConversationScreenState
    extends State<ConversationScreen> {
  final FlutterTts _flutterTts = FlutterTts();
  final SpeechToText _speech = SpeechToText();
  final ScrollController _scrollController =
  ScrollController();

  final List<_ChatMessage> _messages = [];

  int _currentTurnIndex = 0;
  int _score = 0;

  String? _selectedReply;
  String _recognizedReply = '';
  String? _speechLocale;
  String? _errorMessage;

  bool _answerChecked = false;
  bool _answerCorrect = false;
  bool _showHint = false;
  bool _speechInitialized = false;
  bool _initializingSpeech = false;
  bool _isListening = false;
  bool _isSaving = false;

  ConversationTurn get _currentTurn =>
      ConversationData.turns[_currentTurnIndex];

  String get _tutorText {
    return widget
        .lesson.examples[_currentTurn.tutorExampleIndex]
        .textFor(widget.setup.learningLanguage.code);
  }

  String get _correctReply {
    return widget
        .lesson.examples[_currentTurn.correctReplyIndex]
        .textFor(widget.setup.learningLanguage.code);
  }

  String get _correctNativeReply {
    return widget
        .lesson.examples[_currentTurn.correctReplyIndex]
        .textFor(widget.setup.nativeLanguage.code);
  }

  @override
  void initState() {
    super.initState();
    _initializeTts();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      _speakTutor();
    });
  }

  Future<void> _initializeTts() async {
    await _flutterTts.setLanguage(
      widget.setup.learningLanguage.speechLocale,
    );

    await _flutterTts.setVolume(1);
    await _flutterTts.setPitch(1);
    await _flutterTts.setSpeechRate(0.43);
  }

  Future<void> _speakTutor() async {
    await _flutterTts.stop();
    await _flutterTts.speak(_tutorText);
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

  Future<void> _toggleVoiceReply() async {
    if (_answerChecked) return;

    if (_isListening) {
      await _speech.stop();

      if (!mounted) return;

      setState(() {
        _isListening = false;
      });

      if (_recognizedReply.isNotEmpty) {
        _checkVoiceReply();
      }

      return;
    }

    final available = await _initializeSpeech();

    if (!available || !mounted) return;

    await _flutterTts.stop();

    setState(() {
      _recognizedReply = '';
      _selectedReply = null;
      _errorMessage = null;
    });

    await _speech.listen(
      onResult: _onSpeechResult,
      localeId: _speechLocale,
      listenFor: const Duration(seconds: 12),
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
      _recognizedReply = result.recognizedWords;
    });

    if (result.finalResult) {
      setState(() {
        _isListening = false;
      });

      _checkVoiceReply();
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
      'Could not recognize your voice. Please try again.';
    });
  }

  void _checkVoiceReply() {
    if (_recognizedReply.trim().isEmpty ||
        _answerChecked) {
      return;
    }

    final accuracy = _calculateSimilarity(
      _recognizedReply,
      _correctReply,
    );

    _finishAnswer(
      answer: _recognizedReply,
      correct: accuracy >= 70,
    );
  }

  Future<void> _checkSelectedReply() async {
    if (_selectedReply == null || _answerChecked) {
      return;
    }

    final correct =
        _normalize(_selectedReply!) ==
            _normalize(_correctReply);

    await _finishAnswer(
      answer: _selectedReply!,
      correct: correct,
    );
  }

  Future<void> _finishAnswer({
    required String answer,
    required bool correct,
  }) async {
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

  Future<void> _continueConversation() async {
    if (!_answerChecked) return;

    final userAnswer = _recognizedReply.isNotEmpty
        ? _recognizedReply
        : _selectedReply ?? _correctReply;

    setState(() {
      _messages.add(
        _ChatMessage(
          text: _tutorText,
          isUser: false,
        ),
      );

      _messages.add(
        _ChatMessage(
          text: userAnswer,
          isUser: true,
          isCorrect: _answerCorrect,
        ),
      );
    });

    if (_currentTurnIndex <
        ConversationData.turns.length - 1) {
      setState(() {
        _currentTurnIndex++;
        _selectedReply = null;
        _recognizedReply = '';
        _errorMessage = null;
        _answerChecked = false;
        _answerCorrect = false;
        _showHint = false;
        _isListening = false;
      });

      _scrollToBottom();

      await Future<void>.delayed(
        const Duration(milliseconds: 300),
      );

      if (mounted) {
        await _speakTutor();
      }

      return;
    }

    await _completeConversation();
  }

  Future<void> _skip() async {
    if (_answerChecked) return;

    if (_isListening) {
      await _speech.stop();
    }

    await HapticFeedback.heavyImpact();
    await SystemSound.play(SystemSoundType.alert);

    if (!mounted) return;

    setState(() {
      _selectedReply = _correctReply;
      _recognizedReply = '';
      _answerChecked = true;
      _answerCorrect = false;
      _isListening = false;
    });
  }

  void _retry() {
    setState(() {
      _selectedReply = null;
      _recognizedReply = '';
      _errorMessage = null;
      _answerChecked = false;
      _answerCorrect = false;
    });
  }

  Future<void> _completeConversation() async {
    if (_isSaving) return;

    setState(() {
      _isSaving = true;
    });

    await _speech.stop();
    await _flutterTts.stop();

    await LessonProgressService.saveConversationResult(
      lessonId: widget.lesson.id,
      score: _score,
    );

    if (!mounted) return;

    final total = ConversationData.turns.length;
    final percentage = ((_score / total) * 100).round();

    final close = await showDialog<bool>(
      context: context,
      barrierDismissible: false,
      builder: (dialogContext) {
        return AlertDialog(
          icon: Icon(
            percentage >= 60
                ? Icons.forum_rounded
                : Icons.refresh_rounded,
            color: percentage >= 60
                ? AppColors.success
                : AppColors.primary,
            size: 52,
          ),
          title: Text(
            percentage >= 60
                ? 'Conversation Completed!'
                : 'Keep Practicing!',
            textAlign: TextAlign.center,
          ),
          content: Text(
            'You completed $total conversation turns.\n'
                'Score: $_score/$total ($percentage%).\n\n'
                'The Lesson Test is now unlocked.',
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

  void _scrollToBottom() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!_scrollController.hasClients) return;

      _scrollController.animateTo(
        _scrollController.position.maxScrollExtent,
        duration: const Duration(milliseconds: 350),
        curve: Curves.easeOut,
      );
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

  @override
  void dispose() {
    _speech.cancel();
    _flutterTts.stop();
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final progress =
        (_currentTurnIndex + 1) /
            ConversationData.turns.length;

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
                  controller: _scrollController,
                  padding:
                  const EdgeInsets.fromLTRB(17, 15, 17, 25),
                  children: [
                    ..._messages.map(_buildChatBubble),
                    _buildTutorBubble(_tutorText),
                    const SizedBox(height: 22),
                    _buildReplyArea(),
                    if (_showHint) ...[
                      const SizedBox(height: 15),
                      _buildHint(),
                    ],
                    if (_errorMessage != null) ...[
                      const SizedBox(height: 15),
                      _buildError(),
                    ],
                    if (_answerChecked) ...[
                      const SizedBox(height: 17),
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
      padding: const EdgeInsets.fromLTRB(10, 8, 18, 9),
      child: Row(
        children: [
          IconButton(
            onPressed:
            _isSaving ? null : () => Navigator.pop(context),
            icon: const Icon(Icons.close_rounded),
          ),
          const SizedBox(width: 4),
          Expanded(
            child: Column(
              children: [
                Row(
                  children: [
                    const Text(
                      'Conversation',
                      style: TextStyle(
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                    const Spacer(),
                    Text(
                      '${_currentTurnIndex + 1}/'
                          '${ConversationData.turns.length}',
                      style: const TextStyle(
                        color: AppColors.textSecondary,
                        fontSize: 12,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                ClipRRect(
                  borderRadius: BorderRadius.circular(20),
                  child: LinearProgressIndicator(
                    value: progress,
                    minHeight: 7,
                    backgroundColor: AppColors.card,
                    valueColor: const AlwaysStoppedAnimation(
                      AppColors.primary,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildChatBubble(_ChatMessage message) {
    return Align(
      alignment: message.isUser
          ? Alignment.centerRight
          : Alignment.centerLeft,
      child: Container(
        constraints: const BoxConstraints(
          maxWidth: 290,
        ),
        margin: const EdgeInsets.only(bottom: 12),
        padding: const EdgeInsets.symmetric(
          horizontal: 15,
          vertical: 12,
        ),
        decoration: BoxDecoration(
          color: message.isUser
              ? message.isCorrect
              ? AppColors.primary
              : AppColors.error.withValues(alpha: 0.65)
              : AppColors.card,
          borderRadius: BorderRadius.only(
            topLeft: const Radius.circular(18),
            topRight: const Radius.circular(18),
            bottomLeft:
            Radius.circular(message.isUser ? 18 : 5),
            bottomRight:
            Radius.circular(message.isUser ? 5 : 18),
          ),
        ),
        child: Text(message.text),
      ),
    );
  }

  Widget _buildTutorBubble(String text) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Container(
          width: 39,
          height: 39,
          decoration: const BoxDecoration(
            color: AppColors.primary,
            shape: BoxShape.circle,
          ),
          child: const Icon(
            Icons.smart_toy_rounded,
            color: Colors.white,
            size: 21,
          ),
        ),
        const SizedBox(width: 9),
        Flexible(
          child: Container(
            padding: const EdgeInsets.all(15),
            decoration: BoxDecoration(
              color: AppColors.card,
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(19),
                topRight: Radius.circular(19),
                bottomRight: Radius.circular(19),
                bottomLeft: Radius.circular(5),
              ),
              border: Border.all(color: AppColors.border),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Flexible(
                  child: Text(
                    text,
                    style: const TextStyle(
                      fontSize: 15,
                      height: 1.4,
                    ),
                  ),
                ),
                const SizedBox(width: 8),
                IconButton(
                  onPressed: _speakTutor,
                  visualDensity: VisualDensity.compact,
                  icon: const Icon(
                    Icons.volume_up_rounded,
                    color: AppColors.primaryLight,
                    size: 20,
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildReplyArea() {
    final replies = _currentTurn.replyOptionIndexes
        .map(
          (index) => widget.lesson.examples[index].textFor(
        widget.setup.learningLanguage.code,
      ),
    )
        .toList();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Choose or speak your reply',
          style: TextStyle(
            fontWeight: FontWeight.w800,
          ),
        ),
        const SizedBox(height: 12),
        ...replies.map(_buildReplyOption),
        const SizedBox(height: 7),
        OutlinedButton.icon(
          onPressed: _answerChecked ||
              _initializingSpeech
              ? null
              : _toggleVoiceReply,
          icon: _initializingSpeech
              ? const SizedBox(
            width: 19,
            height: 19,
            child: CircularProgressIndicator(
              strokeWidth: 2,
            ),
          )
              : Icon(
            _isListening
                ? Icons.stop_rounded
                : Icons.mic_rounded,
          ),
          label: Text(
            _isListening
                ? 'Stop Listening'
                : 'Reply with Voice',
          ),
        ),
        if (_recognizedReply.isNotEmpty) ...[
          const SizedBox(height: 12),
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(14),
            decoration: BoxDecoration(
              color: AppColors.card,
              borderRadius: BorderRadius.circular(16),
              border: Border.all(color: AppColors.border),
            ),
            child: Text(
              'We heard: $_recognizedReply',
            ),
          ),
        ],
      ],
    );
  }

  Widget _buildReplyOption(String reply) {
    final selected = _selectedReply == reply;

    return Container(
      width: double.infinity,
      margin: const EdgeInsets.only(bottom: 10),
      child: OutlinedButton(
        onPressed: _answerChecked
            ? null
            : () {
          setState(() {
            _selectedReply = reply;
            _recognizedReply = '';
          });
        },
        style: OutlinedButton.styleFrom(
          alignment: Alignment.centerLeft,
          padding: const EdgeInsets.all(15),
          backgroundColor: selected
              ? AppColors.primary.withValues(alpha: 0.13)
              : AppColors.card,
          side: BorderSide(
            color: selected
                ? AppColors.primary
                : AppColors.border,
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(17),
          ),
        ),
        child: Text(
          reply,
          style: const TextStyle(
            color: AppColors.textPrimary,
          ),
        ),
      ),
    );
  }

  Widget _buildHint() {
    return Container(
      padding: const EdgeInsets.all(15),
      decoration: BoxDecoration(
        color: AppColors.warning.withValues(alpha: 0.08),
        borderRadius: BorderRadius.circular(17),
        border: Border.all(
          color: AppColors.warning.withValues(alpha: 0.3),
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
              'Suggested meaning: $_correctNativeReply',
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildError() {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: AppColors.error.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppColors.error),
      ),
      child: Text(_errorMessage!),
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
        crossAxisAlignment: CrossAxisAlignment.start,
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
                  ? 'Correct reply! Great conversation.'
                  : 'Better reply: $_correctReply',
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
      padding: const EdgeInsets.fromLTRB(18, 9, 18, 16),
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
          if (_answerChecked && !_answerCorrect)
            Row(
              children: [
                Expanded(
                  child: OutlinedButton(
                    onPressed: _retry,
                    child: const Text('Try Again'),
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: ElevatedButton(
                    onPressed: _continueConversation,
                    child: const Text('Continue'),
                  ),
                ),
              ],
            )
          else
            ElevatedButton(
              onPressed: _isSaving
                  ? null
                  : _answerChecked
                  ? _continueConversation
                  : _selectedReply != null
                  ? _checkSelectedReply
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
                    ? _currentTurnIndex ==
                    ConversationData
                        .turns.length -
                        1
                    ? 'Finish Conversation'
                    : 'Continue'
                    : 'Check Reply',
              ),
            ),
        ],
      ),
    );
  }
}
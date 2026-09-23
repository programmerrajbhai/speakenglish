import '../../models/speaking_rule_model.dart';

class SpeakingSeed {
  final String english;
  final String nativeText;
  final String? question;

  const SpeakingSeed(
      this.english,
      this.nativeText, {
        this.question,
      });
}

class SpeakingRuleFactory {
  SpeakingRuleFactory._();

  static SpeakingRule create({
    required int id,
    required String title,
    required String explanation,
    required String formula,
    required String example,
    required List<SpeakingSeed> seeds,
    required List<String> Function(
        int practiceId,
        String correctAnswer,
        ) optionBuilder,
    required String Function(String sentence) hintBuilder,
  }) {
    if (seeds.length != 20) {
      throw StateError(
        'Rule $id must contain exactly 20 practices.',
      );
    }

    return SpeakingRule(
      id: id,
      title: title,
      explanation: explanation,
      formula: formula,
      example: example,
      level: 'Beginner',
      practices: List.generate(
        20,
            (index) {
          final seed = seeds[index];
          final type = _practiceType(index);
          final practiceId = index + 1;

          return SpeakingPracticeItem(
            id: practiceId,
            type: type,
            instruction: _instruction(type),
            targetSentence: seed.english,
            nativeTexts: {
              'bn': seed.nativeText,
              'en': seed.english,
            },
            hint: hintBuilder(seed.english),
            explanation: explanation,
            options: _requiresOptions(type)
                ? optionBuilder(
              practiceId,
              seed.english,
            )
                : const [],
            words: type == SpeakingPracticeType.wordOrder
                ? _arrangementWords(seed.english)
                : const [],
            question: seed.question,
          );
        },
        growable: false,
      ),
    );
  }

  static SpeakingPracticeType _practiceType(int index) {
    if (index <= 1) {
      return SpeakingPracticeType.structureChoice;
    }

    if (index <= 3) {
      return SpeakingPracticeType.fillBlank;
    }

    if (index <= 5) {
      return SpeakingPracticeType.wordOrder;
    }

    if (index <= 9) {
      return SpeakingPracticeType.translateAndSpeak;
    }

    if (index <= 12) {
      return SpeakingPracticeType.listenAndRepeat;
    }

    if (index <= 14) {
      return SpeakingPracticeType.pictureSpeaking;
    }

    if (index <= 16) {
      return SpeakingPracticeType.questionAnswer;
    }

    if (index == 17) {
      return SpeakingPracticeType.errorCorrection;
    }

    if (index == 18) {
      return SpeakingPracticeType.situationSpeaking;
    }

    return SpeakingPracticeType.conversation;
  }

  static String _instruction(
      SpeakingPracticeType type,
      ) {
    return switch (type) {
      SpeakingPracticeType.structureChoice =>
      'Choose the correct sentence.',
      SpeakingPracticeType.fillBlank =>
      'Choose the correct answer.',
      SpeakingPracticeType.wordOrder =>
      'Arrange the words correctly.',
      SpeakingPracticeType.translateAndSpeak =>
      'Read the meaning and speak in English.',
      SpeakingPracticeType.listenAndRepeat =>
      'Listen carefully and repeat.',
      SpeakingPracticeType.pictureSpeaking =>
      'Understand the situation and speak.',
      SpeakingPracticeType.questionAnswer =>
      'Listen to the question and answer.',
      SpeakingPracticeType.errorCorrection =>
      'Correct the sentence and speak.',
      SpeakingPracticeType.situationSpeaking =>
      'Speak according to the situation.',
      SpeakingPracticeType.conversation =>
      'Listen and complete the conversation.',
    };
  }

  static bool _requiresOptions(
      SpeakingPracticeType type,
      ) {
    return type == SpeakingPracticeType.structureChoice ||
        type == SpeakingPracticeType.fillBlank;
  }

  static List<String> _arrangementWords(
      String sentence,
      ) {
    final cleanSentence = sentence.replaceAll(
      RegExp(r'[.!?,]'),
      '',
    );

    return cleanSentence
        .split(RegExp(r'\s+'))
        .reversed
        .toList(growable: false);
  }

  static List<String> arrangeOptions({
    required int practiceId,
    required String correct,
    required String wrongOne,
    required String wrongTwo,
  }) {
    if (practiceId % 3 == 0) {
      return [wrongOne, wrongTwo, correct];
    }

    if (practiceId % 2 == 0) {
      return [wrongOne, correct, wrongTwo];
    }

    return [correct, wrongOne, wrongTwo];
  }
}
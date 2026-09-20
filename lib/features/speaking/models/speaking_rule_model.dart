enum SpeakingPracticeType {
  structureChoice,
  fillBlank,
  wordOrder,
  translateAndSpeak,
  listenAndRepeat,
  pictureSpeaking,
  questionAnswer,
  errorCorrection,
  situationSpeaking,
  conversation,
}

class SpeakingRule {
  final int id;
  final String title;
  final String explanation;
  final String formula;
  final String example;
  final String level;
  final List<SpeakingPracticeItem> practices;

  const SpeakingRule({
    required this.id,
    required this.title,
    required this.explanation,
    required this.formula,
    required this.example,
    required this.level,
    required this.practices,
  });

  bool get isValid => practices.length == 20;
}

class SpeakingPracticeItem {
  final int id;
  final SpeakingPracticeType type;

  /// Instruction shown above the practice.
  final String instruction;

  /// English sentence the learner should produce.
  final String targetSentence;

  /// Meaning/instruction for each native language.
  final Map<String, String> nativeTexts;

  final String hint;
  final String explanation;
  final List<String> options;
  final List<String> words;
  final String? question;
  final String? imageAsset;

  const SpeakingPracticeItem({
    required this.id,
    required this.type,
    required this.instruction,
    required this.targetSentence,
    required this.nativeTexts,
    required this.hint,
    required this.explanation,
    this.options = const [],
    this.words = const [],
    this.question,
    this.imageAsset,
  });

  String nativeText(String languageCode) {
    return nativeTexts[languageCode] ??
        nativeTexts['bn'] ??
        targetSentence;
  }
}
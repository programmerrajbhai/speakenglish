enum PracticeType {
  multipleChoice,
  nativeToTarget,
  targetToNative,
  fillBlank,
  wordArrange,
  matching,
  questionAnswer,
}

class PracticeQuestion {
  final PracticeType type;
  final String title;
  final int exampleIndex;
  final List<int> optionIndexes;

  const PracticeQuestion({
    required this.type,
    required this.title,
    required this.exampleIndex,
    this.optionIndexes = const [],
  });
}
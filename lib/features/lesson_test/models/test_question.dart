enum TestQuestionType {
  multipleChoice,
  targetToNative,
  translationTyping,
  listening,
  speaking,
}

class TestQuestion {
  final String id;
  final TestQuestionType type;
  final int exampleIndex;
  final List<int> optionIndexes;

  const TestQuestion({
    required this.id,
    required this.type,
    required this.exampleIndex,
    this.optionIndexes = const [],
  });
}
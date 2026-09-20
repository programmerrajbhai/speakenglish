enum ListeningQuestionType {
  chooseSentence,
  missingWord,
  typeSentence,
}

class ListeningQuestion {
  final String id;
  final ListeningQuestionType type;
  final int exampleIndex;
  final List<int> optionIndexes;

  const ListeningQuestion({
    required this.id,
    required this.type,
    required this.exampleIndex,
    this.optionIndexes = const [],
  });
}
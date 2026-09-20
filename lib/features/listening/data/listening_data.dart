import '../models/listening_question.dart';

class ListeningData {
  ListeningData._();

  static const List<ListeningQuestion> questions = [
    ListeningQuestion(
      id: 'listening_01',
      type: ListeningQuestionType.chooseSentence,
      exampleIndex: 1,
      optionIndexes: [1, 2, 4, 12],
    ),
    ListeningQuestion(
      id: 'listening_02',
      type: ListeningQuestionType.chooseSentence,
      exampleIndex: 5,
      optionIndexes: [5, 7, 10, 13],
    ),
    ListeningQuestion(
      id: 'listening_03',
      type: ListeningQuestionType.missingWord,
      exampleIndex: 6,
      optionIndexes: [6, 8, 11, 12],
    ),
    ListeningQuestion(
      id: 'listening_04',
      type: ListeningQuestionType.typeSentence,
      exampleIndex: 7,
    ),
    ListeningQuestion(
      id: 'listening_05',
      type: ListeningQuestionType.chooseSentence,
      exampleIndex: 9,
      optionIndexes: [9, 10, 12, 14],
    ),
  ];
}
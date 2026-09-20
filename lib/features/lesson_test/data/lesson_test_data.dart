import '../models/test_question.dart';

class LessonTestData {
  LessonTestData._();

  static const List<TestQuestion> questions = [
    TestQuestion(
      id: 'test_01',
      type: TestQuestionType.multipleChoice,
      exampleIndex: 0,
      optionIndexes: [0, 1, 4, 12],
    ),
    TestQuestion(
      id: 'test_02',
      type: TestQuestionType.multipleChoice,
      exampleIndex: 5,
      optionIndexes: [5, 7, 10, 13],
    ),
    TestQuestion(
      id: 'test_03',
      type: TestQuestionType.targetToNative,
      exampleIndex: 7,
      optionIndexes: [7, 8, 10, 11],
    ),
    TestQuestion(
      id: 'test_04',
      type: TestQuestionType.translationTyping,
      exampleIndex: 1,
    ),
    TestQuestion(
      id: 'test_05',
      type: TestQuestionType.listening,
      exampleIndex: 6,
      optionIndexes: [6, 8, 11, 12],
    ),
    TestQuestion(
      id: 'test_06',
      type: TestQuestionType.multipleChoice,
      exampleIndex: 10,
      optionIndexes: [10, 7, 9, 13],
    ),
    TestQuestion(
      id: 'test_07',
      type: TestQuestionType.listening,
      exampleIndex: 9,
      optionIndexes: [9, 10, 12, 14],
    ),
    TestQuestion(
      id: 'test_08',
      type: TestQuestionType.translationTyping,
      exampleIndex: 11,
    ),
    TestQuestion(
      id: 'test_09',
      type: TestQuestionType.speaking,
      exampleIndex: 8,
    ),
    TestQuestion(
      id: 'test_10',
      type: TestQuestionType.speaking,
      exampleIndex: 14,
    ),
  ];
}
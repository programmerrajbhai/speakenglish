import '../models/practice_question.dart';

class PracticeData {
  PracticeData._();

  static const List<PracticeQuestion> questions = [
    PracticeQuestion(
      type: PracticeType.multipleChoice,
      title: 'Choose the correct translation',
      exampleIndex: 0,
      optionIndexes: [0, 1, 4, 12],
    ),
    PracticeQuestion(
      type: PracticeType.nativeToTarget,
      title: 'Translate into your learning language',
      exampleIndex: 1,
    ),
    PracticeQuestion(
      type: PracticeType.targetToNative,
      title: 'Write the meaning in your language',
      exampleIndex: 5,
    ),
    PracticeQuestion(
      type: PracticeType.fillBlank,
      title: 'Complete the sentence',
      exampleIndex: 6,
    ),
    PracticeQuestion(
      type: PracticeType.wordArrange,
      title: 'Arrange the words correctly',
      exampleIndex: 8,
    ),
    PracticeQuestion(
      type: PracticeType.matching,
      title: 'Match the correct pairs',
      exampleIndex: 0,
      optionIndexes: [0, 1, 4],
    ),
    PracticeQuestion(
      type: PracticeType.questionAnswer,
      title: 'Choose the correct reply',
      exampleIndex: 5,
      optionIndexes: [6, 7, 10, 12],
    ),
  ];
}
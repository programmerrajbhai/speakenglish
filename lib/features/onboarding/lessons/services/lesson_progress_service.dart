import 'package:shared_preferences/shared_preferences.dart';

class LessonProgressService {
  LessonProgressService._();

  static String _learningCompletedKey(String lessonId) {
    return 'lesson_${lessonId}_learn_completed';
  }

  static String _currentExampleKey(String lessonId) {
    return 'lesson_${lessonId}_current_example';
  }

  static String _practiceCompletedKey(String lessonId) {
    return 'lesson_${lessonId}_practice_completed';
  }

  static String _practiceScoreKey(String lessonId) {
    return 'lesson_${lessonId}_practice_score';
  }

  static String _listeningCompletedKey(String lessonId) {
    return 'lesson_${lessonId}_listening_completed';
  }

  static Future<bool> isLearningCompleted(
      String lessonId,
      ) async {
    final preferences = await SharedPreferences.getInstance();

    return preferences.getBool(
      _learningCompletedKey(lessonId),
    ) ??
        false;
  }

  static Future<void> saveCurrentExample(
      String lessonId,
      int index,
      ) async {
    final preferences = await SharedPreferences.getInstance();

    await preferences.setInt(
      _currentExampleKey(lessonId),
      index,
    );
  }

  static Future<int> getCurrentExample(
      String lessonId,
      ) async {
    final preferences = await SharedPreferences.getInstance();

    return preferences.getInt(
      _currentExampleKey(lessonId),
    ) ??
        0;
  }

  static Future<void> completeLearning(
      String lessonId,
      ) async {
    final preferences = await SharedPreferences.getInstance();

    await preferences.setBool(
      _learningCompletedKey(lessonId),
      true,
    );

    await preferences.setInt(
      _currentExampleKey(lessonId),
      0,
    );
  }

  static Future<bool> isPracticeCompleted(
      String lessonId,
      ) async {
    final preferences = await SharedPreferences.getInstance();

    return preferences.getBool(
      _practiceCompletedKey(lessonId),
    ) ??
        false;
  }

  static Future<int> getPracticeScore(
      String lessonId,
      ) async {
    final preferences = await SharedPreferences.getInstance();

    return preferences.getInt(
      _practiceScoreKey(lessonId),
    ) ??
        0;
  }

  static Future<void> savePracticeResult({
    required String lessonId,
    required int score,
  }) async {
    final preferences = await SharedPreferences.getInstance();

    await preferences.setInt(
      _practiceScoreKey(lessonId),
      score,
    );

    await preferences.setBool(
      _practiceCompletedKey(lessonId),
      true,
    );
  }

  static Future<bool> isListeningCompleted(
      String lessonId,
      ) async {
    final preferences = await SharedPreferences.getInstance();

    return preferences.getBool(
      _listeningCompletedKey(lessonId),
    ) ??
        false;
  }

  static Future<void> completeListening(
      String lessonId,
      ) async {
    final preferences = await SharedPreferences.getInstance();

    await preferences.setBool(
      _listeningCompletedKey(lessonId),
      true,
    );
  }
  static String _conversationCompletedKey(
      String lessonId,
      ) {
    return 'lesson_${lessonId}_conversation_completed';
  }

  static String _conversationScoreKey(String lessonId) {
    return 'lesson_${lessonId}_conversation_score';
  }

  static Future<bool> isConversationCompleted(
      String lessonId,
      ) async {
    final preferences = await SharedPreferences.getInstance();

    return preferences.getBool(
      _conversationCompletedKey(lessonId),
    ) ??
        false;
  }

  static Future<int> getConversationScore(
      String lessonId,
      ) async {
    final preferences = await SharedPreferences.getInstance();

    return preferences.getInt(
      _conversationScoreKey(lessonId),
    ) ??
        0;
  }

  static Future<void> saveConversationResult({
    required String lessonId,
    required int score,
  }) async {
    final preferences = await SharedPreferences.getInstance();

    await preferences.setInt(
      _conversationScoreKey(lessonId),
      score,
    );

    await preferences.setBool(
      _conversationCompletedKey(lessonId),
      true,
    );
  }
  static String _testScoreKey(String lessonId) {
    return 'lesson_${lessonId}_test_score';
  }

  static String _testPassedKey(String lessonId) {
    return 'lesson_${lessonId}_test_passed';
  }

  static Future<int> getTestScore(String lessonId) async {
    final preferences = await SharedPreferences.getInstance();

    return preferences.getInt(
      _testScoreKey(lessonId),
    ) ??
        0;
  }

  static Future<bool> isTestPassed(
      String lessonId,
      ) async {
    final preferences = await SharedPreferences.getInstance();

    return preferences.getBool(
      _testPassedKey(lessonId),
    ) ??
        false;
  }

  static Future<void> saveTestResult({
    required String lessonId,
    required int score,
    required int total,
  }) async {
    final preferences = await SharedPreferences.getInstance();

    final passed = score >= (total * 0.60).ceil();

    await preferences.setInt(
      _testScoreKey(lessonId),
      score,
    );

    await preferences.setBool(
      _testPassedKey(lessonId),
      passed,
    );
  }

  static Future<void> resetLesson(
      String lessonId,
      ) async

  {
    final preferences = await SharedPreferences.getInstance();


    await preferences.remove(
      _testScoreKey(lessonId),
    );

    await preferences.remove(
      _testPassedKey(lessonId),
    );


    await preferences.remove(
      _conversationCompletedKey(lessonId),
    );

    await preferences.remove(
      _conversationScoreKey(lessonId),
    );


    await preferences.remove(
      _speakingCompletedKey(lessonId),
    );

    await preferences.remove(
      _speakingScoreKey(lessonId),
    );

    await preferences.remove(
      _listeningScoreKey(lessonId),
    );

    await preferences.remove(
      _learningCompletedKey(lessonId),
    );

    await preferences.remove(
      _currentExampleKey(lessonId),
    );

    await preferences.remove(
      _practiceCompletedKey(lessonId),
    );

    await preferences.remove(
      _practiceScoreKey(lessonId),
    );

    await preferences.remove(
      _listeningCompletedKey(lessonId),
    );
  }



  static String _listeningScoreKey(String lessonId) {
    return 'lesson_${lessonId}_listening_score';
  }

  static Future<int> getListeningScore(
      String lessonId,
      ) async {
    final preferences = await SharedPreferences.getInstance();

    return preferences.getInt(
      _listeningScoreKey(lessonId),
    ) ??
        0;
  }

  static Future<void> saveListeningResult({
    required String lessonId,
    required int score,
  }) async {
    final preferences = await SharedPreferences.getInstance();

    await preferences.setInt(
      _listeningScoreKey(lessonId),
      score,
    );

    await preferences.setBool(
      _listeningCompletedKey(lessonId),
      true,
    );
  }
  static String _speakingCompletedKey(String lessonId) {
    return 'lesson_${lessonId}_speaking_completed';
  }

  static String _speakingScoreKey(String lessonId) {
    return 'lesson_${lessonId}_speaking_score';
  }

  static Future<bool> isSpeakingCompleted(
      String lessonId,
      ) async {
    final preferences = await SharedPreferences.getInstance();

    return preferences.getBool(
      _speakingCompletedKey(lessonId),
    ) ??
        false;
  }

  static Future<int> getSpeakingScore(
      String lessonId,
      ) async {
    final preferences = await SharedPreferences.getInstance();

    return preferences.getInt(
      _speakingScoreKey(lessonId),
    ) ??
        0;
  }

  static Future<void> saveSpeakingResult({
    required String lessonId,
    required int score,
  }) async {
    final preferences = await SharedPreferences.getInstance();

    await preferences.setInt(
      _speakingScoreKey(lessonId),
      score,
    );

    await preferences.setBool(
      _speakingCompletedKey(lessonId),
      true,
    );
  }

}
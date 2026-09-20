import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

class SpeakingRuleProgress {
  final int ruleId;
  final int currentPractice;
  final Set<int> attemptedPracticeIds;
  final Set<int> skippedPracticeIds;
  final Map<int, int> practiceScores;
  final int bestScore;
  final bool completed;

  const SpeakingRuleProgress({
    required this.ruleId,
    required this.currentPractice,
    required this.attemptedPracticeIds,
    required this.skippedPracticeIds,
    required this.practiceScores,
    required this.bestScore,
    required this.completed,
  });

  factory SpeakingRuleProgress.empty(int ruleId) {
    return SpeakingRuleProgress(
      ruleId: ruleId,
      currentPractice: 0,
      attemptedPracticeIds: <int>{},
      skippedPracticeIds: <int>{},
      practiceScores: <int, int>{},
      bestScore: 0,
      completed: false,
    );
  }

  int get attemptedCount => attemptedPracticeIds.length;

  int get skippedCount => skippedPracticeIds.length;

  int get answeredCount {
    return attemptedPracticeIds
        .difference(skippedPracticeIds)
        .length;
  }

  int get processedCount {
    return attemptedPracticeIds.union(skippedPracticeIds).length;
  }

  double get attendancePercentage {
    return (processedCount / 20 * 100).clamp(0, 100);
  }

  double get participationPercentage {
    return (answeredCount / 20 * 100).clamp(0, 100);
  }

  int get averageAccuracy {
    if (practiceScores.isEmpty) return 0;

    final total = practiceScores.values.fold<int>(
      0,
          (sum, score) => sum + score,
    );

    return (total / practiceScores.length).round();
  }

  Map<String, dynamic> toJson() {
    return {
      'ruleId': ruleId,
      'currentPractice': currentPractice,
      'attemptedPracticeIds': attemptedPracticeIds.toList(),
      'skippedPracticeIds': skippedPracticeIds.toList(),
      'practiceScores': practiceScores.map(
            (key, value) => MapEntry(key.toString(), value),
      ),
      'bestScore': bestScore,
      'completed': completed,
    };
  }

  factory SpeakingRuleProgress.fromJson(
      Map<String, dynamic> json,
      ) {
    final rawScores =
        json['practiceScores'] as Map<String, dynamic>? ?? {};

    return SpeakingRuleProgress(
      ruleId: json['ruleId'] as int? ?? 1,
      currentPractice: json['currentPractice'] as int? ?? 0,
      attemptedPracticeIds: _readIntSet(
        json['attemptedPracticeIds'],
      ),
      skippedPracticeIds: _readIntSet(
        json['skippedPracticeIds'],
      ),
      practiceScores: rawScores.map(
            (key, value) => MapEntry(
          int.tryParse(key) ?? 0,
          value is int ? value : 0,
        ),
      )..remove(0),
      bestScore: json['bestScore'] as int? ?? 0,
      completed: json['completed'] as bool? ?? false,
    );
  }

  static Set<int> _readIntSet(dynamic value) {
    if (value is! List) return <int>{};

    return value
        .whereType<num>()
        .map((item) => item.toInt())
        .toSet();
  }
}

class SpeakingRuleProgressService {
  SpeakingRuleProgressService._();

  static const String _progressPrefix =
      'speaking_rule_progress_v1_';

  static String _key(int ruleId) {
    return '$_progressPrefix$ruleId';
  }

  static Future<SpeakingRuleProgress> getProgress(
      int ruleId,
      ) async {
    final preferences = await SharedPreferences.getInstance();
    final savedData = preferences.getString(_key(ruleId));

    if (savedData == null || savedData.trim().isEmpty) {
      return SpeakingRuleProgress.empty(ruleId);
    }

    try {
      final decoded = jsonDecode(savedData);

      if (decoded is! Map<String, dynamic>) {
        return SpeakingRuleProgress.empty(ruleId);
      }

      return SpeakingRuleProgress.fromJson(decoded);
    } catch (_) {
      return SpeakingRuleProgress.empty(ruleId);
    }
  }

  static Future<void> saveAttempt({
    required int ruleId,
    required int practiceId,
    required int accuracy,
    required int nextPracticeIndex,
  }) async {
    final oldProgress = await getProgress(ruleId);

    final attempts = <int>{
      ...oldProgress.attemptedPracticeIds,
      practiceId,
    };

    final skipped = <int>{
      ...oldProgress.skippedPracticeIds,
    }..remove(practiceId);

    final scores = <int, int>{
      ...oldProgress.practiceScores,
    };

    final safeAccuracy = accuracy.clamp(0, 100);
    final previousScore = scores[practiceId] ?? 0;

    // Retry করলে highest score রাখা হবে।
    if (safeAccuracy > previousScore) {
      scores[practiceId] = safeAccuracy;
    }

    final calculatedAverage = _calculateAverage(scores);

    final completed = _canComplete(
      processedCount: attempts.union(skipped).length,
      averageScore: calculatedAverage,
    );

    final updatedProgress = SpeakingRuleProgress(
      ruleId: ruleId,
      currentPractice: nextPracticeIndex.clamp(0, 19),
      attemptedPracticeIds: attempts,
      skippedPracticeIds: skipped,
      practiceScores: scores,
      bestScore: calculatedAverage > oldProgress.bestScore
          ? calculatedAverage
          : oldProgress.bestScore,
      completed: oldProgress.completed || completed,
    );

    await _save(updatedProgress);
  }

  static Future<void> saveSkip({
    required int ruleId,
    required int practiceId,
    required int nextPracticeIndex,
  }) async {
    final oldProgress = await getProgress(ruleId);

    final attempts = <int>{
      ...oldProgress.attemptedPracticeIds,
      practiceId,
    };

    final skipped = <int>{
      ...oldProgress.skippedPracticeIds,
      practiceId,
    };

    final scores = <int, int>{
      ...oldProgress.practiceScores,
    }..remove(practiceId);

    final average = _calculateAverage(scores);

    final completed = _canComplete(
      processedCount: attempts.union(skipped).length,
      averageScore: average,
    );

    final updatedProgress = SpeakingRuleProgress(
      ruleId: ruleId,
      currentPractice: nextPracticeIndex.clamp(0, 19),
      attemptedPracticeIds: attempts,
      skippedPracticeIds: skipped,
      practiceScores: scores,
      bestScore: average > oldProgress.bestScore
          ? average
          : oldProgress.bestScore,
      completed: oldProgress.completed || completed,
    );

    await _save(updatedProgress);
  }

  static Future<void> saveCurrentPractice({
    required int ruleId,
    required int practiceIndex,
  }) async {
    final oldProgress = await getProgress(ruleId);

    final updatedProgress = SpeakingRuleProgress(
      ruleId: oldProgress.ruleId,
      currentPractice: practiceIndex.clamp(0, 19),
      attemptedPracticeIds: oldProgress.attemptedPracticeIds,
      skippedPracticeIds: oldProgress.skippedPracticeIds,
      practiceScores: oldProgress.practiceScores,
      bestScore: oldProgress.bestScore,
      completed: oldProgress.completed,
    );

    await _save(updatedProgress);
  }

  static Future<void> completeRule({
    required int ruleId,
  }) async {
    final oldProgress = await getProgress(ruleId);

    final updatedProgress = SpeakingRuleProgress(
      ruleId: oldProgress.ruleId,
      currentPractice: 19,
      attemptedPracticeIds: oldProgress.attemptedPracticeIds,
      skippedPracticeIds: oldProgress.skippedPracticeIds,
      practiceScores: oldProgress.practiceScores,
      bestScore: oldProgress.bestScore,
      completed: true,
    );

    await _save(updatedProgress);
  }

  static Future<bool> isRuleCompleted(int ruleId) async {
    final progress = await getProgress(ruleId);
    return progress.completed;
  }

  static Future<bool> isRuleUnlocked(int ruleId) async {
    if (ruleId <= 1) return true;

    return isRuleCompleted(ruleId - 1);
  }

  static Future<int> getHighestUnlockedRule({
    int totalRules = 60,
  }) async {
    for (var ruleId = 2; ruleId <= totalRules; ruleId++) {
      final unlocked = await isRuleUnlocked(ruleId);

      if (!unlocked) {
        return ruleId - 1;
      }
    }

    return totalRules;
  }

  static Future<double> getOverallProgress({
    int totalRules = 60,
  }) async {
    var completedRules = 0;

    for (var ruleId = 1; ruleId <= totalRules; ruleId++) {
      if (await isRuleCompleted(ruleId)) {
        completedRules++;
      }
    }

    return completedRules / totalRules;
  }

  static Future<void> resetRule(int ruleId) async {
    final preferences = await SharedPreferences.getInstance();
    await preferences.remove(_key(ruleId));
  }

  static Future<void> resetAllRules({
    int totalRules = 60,
  }) async {
    final preferences = await SharedPreferences.getInstance();

    for (var ruleId = 1; ruleId <= totalRules; ruleId++) {
      await preferences.remove(_key(ruleId));
    }
  }

  static Future<void> _save(
      SpeakingRuleProgress progress,
      ) async {
    final preferences = await SharedPreferences.getInstance();

    await preferences.setString(
      _key(progress.ruleId),
      jsonEncode(progress.toJson()),
    );
  }

  static int _calculateAverage(
      Map<int, int> scores,
      ) {
    if (scores.isEmpty) return 0;

    final total = scores.values.fold<int>(
      0,
          (sum, score) => sum + score,
    );

    return (total / scores.length).round();
  }

  static bool _canComplete({
    required int processedCount,
    required int averageScore,
  }) {
    // অন্তত ১৫টি practice process এবং ৬০% score প্রয়োজন।
    return processedCount >= 15 && averageScore >= 60;
  }
}
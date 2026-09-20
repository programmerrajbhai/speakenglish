import 'package:shared_preferences/shared_preferences.dart';

import '../data/languages_data.dart';
import '../model/language_model.dart';
import '../model/onboarding_setup.dart';


class OnboardingStorage {
  OnboardingStorage._();

  static const String _completedKey = 'onboarding_completed';
  static const String _nativeLanguageKey = 'native_language';
  static const String _learningLanguageKey = 'learning_language';
  static const String _levelKey = 'learning_level';
  static const String _dailyGoalKey = 'daily_goal';

  static Future<void> save(OnboardingSetup setup) async {
    if (setup.level == null || setup.dailyGoal == null) {
      throw StateError('Onboarding setup is incomplete.');
    }

    final preferences = await SharedPreferences.getInstance();

    await preferences.setString(
      _nativeLanguageKey,
      setup.nativeLanguage.code,
    );

    await preferences.setString(
      _learningLanguageKey,
      setup.learningLanguage.code,
    );

    await preferences.setString(
      _levelKey,
      setup.level!,
    );

    await preferences.setInt(
      _dailyGoalKey,
      setup.dailyGoal!,
    );

    await preferences.setBool(_completedKey, true);
  }

  static Future<bool> isCompleted() async {
    final preferences = await SharedPreferences.getInstance();
    return preferences.getBool(_completedKey) ?? false;
  }

  static Future<OnboardingSetup?> load() async {
    final preferences = await SharedPreferences.getInstance();

    final isCompleted =
        preferences.getBool(_completedKey) ?? false;

    if (!isCompleted) return null;

    final nativeCode =
    preferences.getString(_nativeLanguageKey);

    final learningCode =
    preferences.getString(_learningLanguageKey);

    final level = preferences.getString(_levelKey);
    final dailyGoal = preferences.getInt(_dailyGoalKey);

    if (nativeCode == null ||
        learningCode == null ||
        level == null ||
        dailyGoal == null) {
      return null;
    }

    final nativeLanguage = _findLanguage(nativeCode);
    final learningLanguage = _findLanguage(learningCode);

    if (nativeLanguage == null || learningLanguage == null) {
      return null;
    }

    return OnboardingSetup(
      nativeLanguage: nativeLanguage,
      learningLanguage: learningLanguage,
      level: level,
      dailyGoal: dailyGoal,
    );
  }

  static Future<void> reset() async {
    final preferences = await SharedPreferences.getInstance();

    await preferences.remove(_completedKey);
    await preferences.remove(_nativeLanguageKey);
    await preferences.remove(_learningLanguageKey);
    await preferences.remove(_levelKey);
    await preferences.remove(_dailyGoalKey);
  }

  static LanguageModel? _findLanguage(String code) {
    for (final language in LanguagesData.languages) {
      if (language.code == code) {
        return language;
      }
    }

    return null;
  }
}
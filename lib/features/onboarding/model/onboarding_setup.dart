import 'language_model.dart';

class OnboardingSetup {
  final LanguageModel nativeLanguage;
  final LanguageModel learningLanguage;
  final String? level;
  final int? dailyGoal;

  const OnboardingSetup({
    required this.nativeLanguage,
    required this.learningLanguage,
    this.level,
    this.dailyGoal,
  });

  OnboardingSetup copyWith({
    String? level,
    int? dailyGoal,
  }) {
    return OnboardingSetup(
      nativeLanguage: nativeLanguage,
      learningLanguage: learningLanguage,
      level: level ?? this.level,
      dailyGoal: dailyGoal ?? this.dailyGoal,
    );
  }
}
import 'package:flutter/material.dart';

import '../../features/home/presentation/home_screen.dart';
import '../../features/main/presentation/main_navigation_screen.dart';
import '../../features/onboarding/data/languages_data.dart';
import '../../features/onboarding/model/language_model.dart';
import '../../features/onboarding/model/onboarding_setup.dart';

import '../../features/onboarding/presentation/daily_goal_screen.dart';
import '../../features/onboarding/presentation/learning_language_screen.dart';
import '../../features/onboarding/presentation/level_selection_screen.dart';
import '../../features/onboarding/presentation/native_language_screen.dart';
import '../../features/onboarding/presentation/splash_screen.dart';
import '../../features/onboarding/presentation/welcome_screen.dart';

class AppRoutes {
  AppRoutes._();

  static const String splash = '/';
  static const String welcome = '/welcome';
  static const String nativeLanguage = '/native-language';
  static const String learningLanguage = '/learning-language';
  static const String levelSelection = '/level-selection';
  static const String dailyGoal = '/daily-goal';
  static const String home = '/home';

  static Route<dynamic> onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case splash:
        return _buildRoute(const SplashScreen(), settings);

      case welcome:
        return _buildRoute(const WelcomeScreen(), settings);

      case nativeLanguage:
        return _buildRoute(
          const NativeLanguageScreen(),
          settings,
        );

      case learningLanguage:
        final language =
            settings.arguments as LanguageModel? ??
                LanguagesData.languages.first;

        return _buildRoute(
          LearningLanguageScreen(
            nativeLanguage: language,
          ),
          settings,
        );

      case levelSelection:
        final setup = settings.arguments as OnboardingSetup?;

        if (setup == null) {
          return _buildRoute(
            const NativeLanguageScreen(),
            settings,
          );
        }

        return _buildRoute(
          LevelSelectionScreen(setup: setup),
          settings,
        );

      case dailyGoal:
        final setup = settings.arguments as OnboardingSetup?;

        if (setup == null || setup.level == null) {
          return _buildRoute(
            const NativeLanguageScreen(),
            settings,
          );
        }

        return _buildRoute(
          DailyGoalScreen(setup: setup),
          settings,
        );

      case home:
        return _buildRoute(
          const MainNavigationScreen(),
          settings,
        );
      default:
        return _buildRoute(
          const WelcomeScreen(),
          settings,
        );
    }
  }

  static MaterialPageRoute<dynamic> _buildRoute(
      Widget screen,
      RouteSettings settings,
      ) {
    return MaterialPageRoute(
      builder: (_) => screen,
      settings: settings,
    );
  }
}
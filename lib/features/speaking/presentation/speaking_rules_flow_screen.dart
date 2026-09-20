import 'package:flutter/material.dart';
import '../../onboarding/model/onboarding_setup.dart';
import '../models/speaking_rule_model.dart';
import 'speaking_rule_details_screen.dart';
import 'speaking_rule_practice_screen.dart';
import 'speaking_rules_screen.dart';

class SpeakingRulesFlowScreen extends StatelessWidget {
  final OnboardingSetup setup;

  const SpeakingRulesFlowScreen({
    super.key,
    required this.setup,
  });

  @override
  Widget build(BuildContext context) {
    return SpeakingRulesScreen(
      onOpenRule: (SpeakingRule rule) async {
        await Navigator.push<bool>(
          context,
          MaterialPageRoute(
            builder: (detailsContext) {
              return SpeakingRuleDetailsScreen(
                rule: rule,
                onStartPractice: () async {
                  await Navigator.push<bool>(
                    detailsContext,
                    MaterialPageRoute(
                      builder: (_) {
                        return SpeakingRulePracticeScreen(
                          rule: rule,
                          nativeLanguageCode:
                          setup.nativeLanguage.code,
                          learningSpeechLocale:
                          setup.learningLanguage.speechLocale,
                        );
                      },
                    ),
                  );
                },
              );
            },
          ),
        );
      },
    );
  }
}
import 'package:speakenglish/features/speaking/data/rules/speaking_rules_11_15.dart';
import 'package:speakenglish/features/speaking/data/rules/speaking_rules_16_20.dart';
import 'package:speakenglish/features/speaking/data/rules/speaking_rules_21_25.dart';
import 'package:speakenglish/features/speaking/data/rules/speaking_rules_26_30.dart';
import 'package:speakenglish/features/speaking/data/rules/speaking_rules_31_35.dart';
import 'package:speakenglish/features/speaking/data/rules/speaking_rules_36_40.dart';
import 'package:speakenglish/features/speaking/data/rules/speaking_rules_41_45.dart';
import 'package:speakenglish/features/speaking/data/rules/speaking_rules_46_50.dart';
import 'package:speakenglish/features/speaking/data/rules/speaking_rules_51_55.dart';
import 'package:speakenglish/features/speaking/data/rules/speaking_rules_56_60.dart';
import 'package:speakenglish/features/speaking/data/speaking_rules_01_05.dart';
import '../models/speaking_rule_model.dart';
import 'rules/speaking_rules_06_10.dart';

class SpeakingRulesRepository {
  SpeakingRulesRepository._();

  static final List<SpeakingRule> rules = [
    ...SpeakingRules01To05.rules,
    ...SpeakingRules06To10.rules,
    ...SpeakingRules11To15.rules,
    ...SpeakingRules16To20.rules,
    ...SpeakingRules21To25.rules,
    ...SpeakingRules26To30.rules,
    ...SpeakingRules31To35.rules,
    ...SpeakingRules36To40.rules,
    ...SpeakingRules41To45.rules,
    ...SpeakingRules46To50.rules,
    ...SpeakingRules51To55.rules,
    ...SpeakingRules56To60.rules,

  ];

  static SpeakingRule findById(int ruleId) {
    final rule = findByIdOrNull(ruleId);

    if (rule == null) {
      throw StateError(
        'Speaking Rule $ruleId content was not found.',
      );
    }

    return rule;
  }

  static SpeakingRule? findByIdOrNull(int ruleId) {
    for (final rule in rules) {
      if (rule.id == ruleId) {
        return rule;
      }
    }

    return null;
  }

  static bool hasContent(int ruleId) {
    return findByIdOrNull(ruleId) != null;
  }

  static List<String> validate() {
    final errors = <String>[];
    final ruleIds = <int>{};

    for (final rule in rules) {
      if (!ruleIds.add(rule.id)) {
        errors.add(
          'Duplicate Speaking Rule ID: ${rule.id}',
        );
      }

      if (rule.practices.length != 20) {
        errors.add(
          'Rule ${rule.id} contains '
              '${rule.practices.length} practices.',
        );
      }

      final practiceIds = <int>{};

      for (final practice in rule.practices) {
        if (!practiceIds.add(practice.id)) {
          errors.add(
            'Rule ${rule.id} contains duplicate '
                'Practice ID ${practice.id}.',
          );
        }

        if (practice.targetSentence.trim().isEmpty) {
          errors.add(
            'Rule ${rule.id}, Practice ${practice.id} '
                'has an empty target sentence.',
          );
        }

        if (practice.nativeTexts['bn']
            ?.trim()
            .isEmpty ??
            true) {
          errors.add(
            'Rule ${rule.id}, Practice ${practice.id} '
                'has no Bangla instruction.',
          );
        }

        final requiresOptions =
            practice.type ==
                SpeakingPracticeType.structureChoice ||
                practice.type ==
                    SpeakingPracticeType.fillBlank;

        if (requiresOptions &&
            !practice.options.contains(
              practice.targetSentence,
            )) {
          errors.add(
            'Rule ${rule.id}, Practice ${practice.id} '
                'does not contain its correct option.',
          );
        }

        if (practice.type ==
            SpeakingPracticeType.wordOrder &&
            practice.words.isEmpty) {
          errors.add(
            'Rule ${rule.id}, Practice ${practice.id} '
                'has no arrangement words.',
          );
        }
      }
    }

    return errors;
  }
}
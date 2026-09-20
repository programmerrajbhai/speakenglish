import 'package:flutter/material.dart';

import '../../../core/theme/app_colors.dart';

class LessonResultScreen extends StatelessWidget {
  final int score;
  final int total;

  const LessonResultScreen({
    super.key,
    required this.score,
    required this.total,
  });

  bool get passed => score >= (total * 0.60).ceil();

  int get percentage {
    return ((score / total) * 100).round();
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      child: Scaffold(
        backgroundColor: AppColors.background,
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(
              24,
              30,
              24,
              24,
            ),
            child: Column(
              children: [
                const Spacer(),
                Container(
                  width: 145,
                  height: 145,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: (passed
                        ? AppColors.success
                        : AppColors.primary)
                        .withValues(alpha: 0.13),
                    border: Border.all(
                      color: passed
                          ? AppColors.success
                          : AppColors.primary,
                      width: 2,
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: (passed
                            ? AppColors.success
                            : AppColors.primary)
                            .withValues(alpha: 0.25),
                        blurRadius: 40,
                      ),
                    ],
                  ),
                  child: Icon(
                    passed
                        ? Icons.emoji_events_rounded
                        : Icons.refresh_rounded,
                    color: passed
                        ? AppColors.warning
                        : AppColors.primaryLight,
                    size: 76,
                  ),
                ),
                const SizedBox(height: 30),
                Text(
                  passed
                      ? 'Unit 1 Completed!'
                      : 'Keep Practicing!',
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    fontSize: 29,
                    fontWeight: FontWeight.w800,
                  ),
                ),
                const SizedBox(height: 12),
                Text(
                  passed
                      ? 'Great work! The next unit is now unlocked.'
                      : 'You need at least 60% to unlock the next unit.',
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    color: AppColors.textSecondary,
                    fontSize: 14,
                    height: 1.5,
                  ),
                ),
                const SizedBox(height: 35),
                Container(
                  padding: const EdgeInsets.all(23),
                  decoration: BoxDecoration(
                    color: AppColors.card,
                    borderRadius: BorderRadius.circular(24),
                    border: Border.all(
                      color: AppColors.border,
                    ),
                  ),
                  child: Row(
                    mainAxisAlignment:
                    MainAxisAlignment.spaceAround,
                    children: [
                      _ResultValue(
                        value: '$score/$total',
                        label: 'Score',
                      ),
                      Container(
                        width: 1,
                        height: 45,
                        color: AppColors.border,
                      ),
                      _ResultValue(
                        value: '$percentage%',
                        label: 'Accuracy',
                      ),
                      Container(
                        width: 1,
                        height: 45,
                        color: AppColors.border,
                      ),
                      _ResultValue(
                        value: passed ? 'Passed' : 'Failed',
                        label: 'Result',
                      ),
                    ],
                  ),
                ),
                const Spacer(),
                if (!passed) ...[
                  OutlinedButton.icon(
                    onPressed: () {
                      Navigator.pop(context, true);
                    },
                    icon: const Icon(Icons.refresh_rounded),
                    label: const Text('Retry Test'),
                  ),
                  const SizedBox(height: 12),
                ],
                ElevatedButton(
                  onPressed: () {
                    Navigator.pop(context, false);
                  },
                  child: Text(
                    passed
                        ? 'Continue Learning'
                        : 'Back to Unit',
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _ResultValue extends StatelessWidget {
  final String value;
  final String label;

  const _ResultValue({
    required this.value,
    required this.label,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          value,
          style: const TextStyle(
            color: AppColors.primaryLight,
            fontSize: 19,
            fontWeight: FontWeight.w800,
          ),
        ),
        const SizedBox(height: 5),
        Text(
          label,
          style: const TextStyle(
            color: AppColors.textSecondary,
            fontSize: 10,
          ),
        ),
      ],
    );
  }
}
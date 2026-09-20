import 'package:flutter/material.dart';

import '../../../core/theme/app_colors.dart';
import '../model/onboarding_setup.dart';

class SettingsScreen extends StatelessWidget {
  final OnboardingSetup setup;
  final Future<void> Function() onResetCourse;

  const SettingsScreen({
    super.key,
    required this.setup,
    required this.onResetCourse,
  });

  Future<void> _confirmReset(BuildContext context) async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (dialogContext) {
        return AlertDialog(
          title: const Text('Change course?'),
          content: const Text(
            'Your selected language and onboarding setup '
                'will be reset.',
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(dialogContext, false);
              },
              child: const Text('Cancel'),
            ),
            FilledButton(
              onPressed: () {
                Navigator.pop(dialogContext, true);
              },
              child: const Text('Change'),
            ),
          ],
        );
      },
    );

    if (confirmed == true) {
      await onResetCourse();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: const Text(
          'Settings',
          style: TextStyle(fontWeight: FontWeight.w800),
        ),
      ),
      body: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          ListTile(
            tileColor: AppColors.card,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(18),
            ),
            leading: const Icon(
              Icons.translate_rounded,
              color: AppColors.primary,
            ),
            title: const Text('Current course'),
            subtitle: Text(
              '${setup.nativeLanguage.name} → '
                  '${setup.learningLanguage.name}',
            ),
            trailing: const Icon(Icons.chevron_right_rounded),
            onTap: () => _confirmReset(context),
          ),
          const SizedBox(height: 13),
          ListTile(
            tileColor: AppColors.card,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(18),
            ),
            leading: const Icon(
              Icons.schedule_rounded,
              color: AppColors.primary,
            ),
            title: const Text('Daily goal'),
            subtitle: Text('${setup.dailyGoal} minutes daily'),
          ),
        ],
      ),
    );
  }
}
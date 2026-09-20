import 'package:flutter/material.dart';

import '../../../core/theme/app_colors.dart';

import '../model/onboarding_setup.dart';

class ProgressScreen extends StatelessWidget {
  final OnboardingSetup setup;

  const ProgressScreen({
    super.key,
    required this.setup,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: const Text(
          'Your Progress',
          style: TextStyle(fontWeight: FontWeight.w800),
        ),
      ),
      body: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          _progressCard(
            'Daily goal',
            '0 / ${setup.dailyGoal} minutes',
            Icons.track_changes_rounded,
          ),
          _progressCard(
            'Current streak',
            '0 days',
            Icons.local_fire_department_rounded,
          ),
          _progressCard(
            'Total XP',
            '0 XP',
            Icons.bolt_rounded,
          ),
          _progressCard(
            'Completed lessons',
            '0 lessons',
            Icons.check_circle_rounded,
          ),
        ],
      ),
    );
  }

  Widget _progressCard(
      String title,
      String value,
      IconData icon,
      ) {
    return Container(
      margin: const EdgeInsets.only(bottom: 14),
      padding: const EdgeInsets.all(19),
      decoration: BoxDecoration(
        color: AppColors.card,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: AppColors.border),
      ),
      child: Row(
        children: [
          Icon(icon, color: AppColors.primary, size: 30),
          const SizedBox(width: 15),
          Expanded(
            child: Text(
              title,
              style: const TextStyle(
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
          Text(
            value,
            style: const TextStyle(
              color: AppColors.primaryLight,
              fontWeight: FontWeight.w800,
            ),
          ),
        ],
      ),
    );
  }
}
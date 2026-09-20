import 'package:flutter/material.dart';

import '../../../core/theme/app_colors.dart';
import '../data/speaking_rules_repository.dart';
import '../models/speaking_rule_model.dart';
import '../services/speaking_rule_progress_service.dart';

class SpeakingRulesScreen extends StatefulWidget {
  final Future<void> Function(SpeakingRule rule) onOpenRule;

  const SpeakingRulesScreen({
    super.key,
    required this.onOpenRule,
  });

  @override
  State<SpeakingRulesScreen> createState() =>
      _SpeakingRulesScreenState();
}

class _SpeakingRulesScreenState
    extends State<SpeakingRulesScreen> {
  bool _isLoading = true;

  final Map<int, SpeakingRuleProgress> _progress = {};
  final Map<int, bool> _unlockedRules = {};

  @override
  void initState() {
    super.initState();
    _loadProgress();
  }

  Future<void> _loadProgress() async {
    if (mounted) {
      setState(() {
        _isLoading = true;
      });
    }

    final progressMap = <int, SpeakingRuleProgress>{};
    final unlockedMap = <int, bool>{};

    for (final rule in SpeakingRulesRepository.rules) {
      progressMap[rule.id] =
      await SpeakingRuleProgressService.getProgress(rule.id);

      unlockedMap[rule.id] =
      await SpeakingRuleProgressService.isRuleUnlocked(rule.id);
    }

    if (!mounted) return;

    setState(() {
      _progress
        ..clear()
        ..addAll(progressMap);

      _unlockedRules
        ..clear()
        ..addAll(unlockedMap);

      _isLoading = false;
    });
  }

  Future<void> _openRule(SpeakingRule rule) async {
    final unlocked = _unlockedRules[rule.id] ?? false;

    if (!unlocked) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            'Complete Rule ${rule.id - 1} to unlock this rule.',
          ),
        ),
      );
      return;
    }

    await widget.onOpenRule(rule);

    if (!mounted) return;
    await _loadProgress();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: AppColors.background,
        elevation: 0,
        title: const Text(
          'Speaking Rules',
          style: TextStyle(
            fontWeight: FontWeight.w800,
          ),
        ),
      ),
      body: _isLoading
          ? const Center(
        child: CircularProgressIndicator(
          color: AppColors.primary,
        ),
      )
          : RefreshIndicator(
        color: AppColors.primary,
        onRefresh: _loadProgress,
        child: CustomScrollView(
          physics: const AlwaysScrollableScrollPhysics(
            parent: BouncingScrollPhysics(),
          ),
          slivers: [
            SliverToBoxAdapter(
              child: _buildHeader(),
            ),
            SliverPadding(
              padding: const EdgeInsets.fromLTRB(
                18,
                8,
                18,
                35,
              ),
              sliver: SliverList.separated(
                itemCount:
                SpeakingRulesRepository.rules.length,
                separatorBuilder: (_, __) =>
                const SizedBox(height: 14),
                itemBuilder: (context, index) {
                  final rule =
                  SpeakingRulesRepository.rules[index];

                  return _buildRuleCard(rule);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader() {
    final rules = SpeakingRulesRepository.rules;

    final completedCount = rules.where((rule) {
      return _progress[rule.id]?.completed ?? false;
    }).length;

    final percentage = rules.isEmpty
        ? 0.0
        : completedCount / rules.length;

    return Container(
      margin: const EdgeInsets.fromLTRB(18, 10, 18, 22),
      padding: const EdgeInsets.all(21),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            AppColors.primary.withValues(alpha: 0.30),
            AppColors.card,
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(25),
        border: Border.all(
          color: AppColors.primary.withValues(alpha: 0.40),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Row(
            children: [
              ContainerIcon(
                icon: Icons.record_voice_over_rounded,
              ),
              SizedBox(width: 13),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Speak English Step by Step',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                    SizedBox(height: 5),
                    Text(
                      'Learn rules, listen and practice speaking.',
                      style: TextStyle(
                        color: AppColors.textSecondary,
                        fontSize: 12,
                        height: 1.4,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 21),
          Row(
            children: [
              Text(
                '$completedCount/${rules.length} Rules',
                style: const TextStyle(
                  fontWeight: FontWeight.w700,
                ),
              ),
              const Spacer(),
              Text(
                '${(percentage * 100).round()}%',
                style: const TextStyle(
                  color: AppColors.primary,
                  fontWeight: FontWeight.w800,
                ),
              ),
            ],
          ),
          const SizedBox(height: 9),
          ClipRRect(
            borderRadius: BorderRadius.circular(20),
            child: LinearProgressIndicator(
              value: percentage,
              minHeight: 9,
              backgroundColor:
              AppColors.background.withValues(alpha: 0.7),
              valueColor: const AlwaysStoppedAnimation(
                AppColors.primary,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildRuleCard(SpeakingRule rule) {
    final progress = _progress[rule.id] ??
        SpeakingRuleProgress.empty(rule.id);

    final unlocked = _unlockedRules[rule.id] ?? false;
    final completed = progress.completed;

    final practiceProgress =
    (progress.processedCount / 20).clamp(0.0, 1.0);

    Color statusColor;
    IconData statusIcon;
    String buttonText;

    if (!unlocked) {
      statusColor = AppColors.textSecondary;
      statusIcon = Icons.lock_rounded;
      buttonText = 'Locked';
    } else if (completed) {
      statusColor = AppColors.success;
      statusIcon = Icons.check_circle_rounded;
      buttonText = 'Practice Again';
    } else if (progress.processedCount > 0) {
      statusColor = AppColors.warning;
      statusIcon = Icons.play_circle_fill_rounded;
      buttonText = 'Continue';
    } else {
      statusColor = AppColors.primary;
      statusIcon = Icons.play_circle_fill_rounded;
      buttonText = 'Start Rule';
    }

    return Opacity(
      opacity: unlocked ? 1 : 0.62,
      child: InkWell(
        borderRadius: BorderRadius.circular(23),
        onTap: () => _openRule(rule),
        child: Container(
          padding: const EdgeInsets.all(18),
          decoration: BoxDecoration(
            color: AppColors.card,
            borderRadius: BorderRadius.circular(23),
            border: Border.all(
              color: completed
                  ? AppColors.success.withValues(alpha: 0.55)
                  : unlocked
                  ? AppColors.border
                  : AppColors.border.withValues(alpha: 0.50),
            ),
          ),
          child: Column(
            children: [
              Row(
                children: [
                  Container(
                    width: 52,
                    height: 52,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      color: statusColor.withValues(alpha: 0.13),
                      borderRadius: BorderRadius.circular(17),
                    ),
                    child: unlocked
                        ? Text(
                      '${rule.id}',
                      style: TextStyle(
                        color: statusColor,
                        fontSize: 19,
                        fontWeight: FontWeight.w900,
                      ),
                    )
                        : Icon(
                      Icons.lock_rounded,
                      color: statusColor,
                    ),
                  ),
                  const SizedBox(width: 14),
                  Expanded(
                    child: Column(
                      crossAxisAlignment:
                      CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Expanded(
                              child: Text(
                                'Rule ${rule.id}',
                                style: const TextStyle(
                                  color: AppColors.textSecondary,
                                  fontSize: 11,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                            ),
                            _buildLevelBadge(rule.level),
                          ],
                        ),
                        const SizedBox(height: 5),
                        Text(
                          rule.title,
                          style: const TextStyle(
                            fontSize: 17,
                            fontWeight: FontWeight.w800,
                          ),
                        ),
                        const SizedBox(height: 5),
                        Text(
                          rule.formula,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(
                            color: AppColors.textSecondary,
                            fontSize: 12,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 17),
              Row(
                children: [
                  _smallInformation(
                    Icons.task_alt_rounded,
                    '${progress.processedCount}/20',
                  ),
                  const SizedBox(width: 15),
                  _smallInformation(
                    Icons.graphic_eq_rounded,
                    '${progress.bestScore}%',
                  ),
                  const Spacer(),
                  Icon(
                    statusIcon,
                    color: statusColor,
                    size: 19,
                  ),
                  const SizedBox(width: 6),
                  Text(
                    buttonText,
                    style: TextStyle(
                      color: statusColor,
                      fontSize: 12,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 13),
              ClipRRect(
                borderRadius: BorderRadius.circular(20),
                child: LinearProgressIndicator(
                  value: practiceProgress,
                  minHeight: 7,
                  backgroundColor: AppColors.background,
                  valueColor: AlwaysStoppedAnimation(
                    completed
                        ? AppColors.success
                        : AppColors.primary,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildLevelBadge(String level) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 9,
        vertical: 4,
      ),
      decoration: BoxDecoration(
        color: AppColors.primary.withValues(alpha: 0.11),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Text(
        level,
        style: const TextStyle(
          color: AppColors.primary,
          fontSize: 10,
          fontWeight: FontWeight.w800,
        ),
      ),
    );
  }

  Widget _smallInformation(
      IconData icon,
      String value,
      ) {
    return Row(
      children: [
        Icon(
          icon,
          size: 16,
          color: AppColors.textSecondary,
        ),
        const SizedBox(width: 5),
        Text(
          value,
          style: const TextStyle(
            color: AppColors.textSecondary,
            fontSize: 12,
            fontWeight: FontWeight.w700,
          ),
        ),
      ],
    );
  }
}

class ContainerIcon extends StatelessWidget {
  final IconData icon;

  const ContainerIcon({
    super.key,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 51,
      height: 51,
      decoration: BoxDecoration(
        color: AppColors.primary.withValues(alpha: 0.16),
        borderRadius: BorderRadius.circular(17),
      ),
      child: Icon(
        icon,
        color: AppColors.primary,
        size: 28,
      ),
    );
  }
}
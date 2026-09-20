import 'package:flutter/material.dart';

import '../../../core/theme/app_colors.dart';
import '../models/speaking_rule_model.dart';
import '../services/speaking_rule_progress_service.dart';

class SpeakingRuleDetailsScreen extends StatefulWidget {
  final SpeakingRule rule;
  final Future<void> Function() onStartPractice;

  const SpeakingRuleDetailsScreen({
    super.key,
    required this.rule,
    required this.onStartPractice,
  });

  @override
  State<SpeakingRuleDetailsScreen> createState() =>
      _SpeakingRuleDetailsScreenState();
}

class _SpeakingRuleDetailsScreenState
    extends State<SpeakingRuleDetailsScreen> {
  SpeakingRuleProgress? _progress;
  bool _isLoading = true;
  bool _isOpening = false;

  @override
  void initState() {
    super.initState();
    _loadProgress();
  }

  Future<void> _loadProgress() async {
    final progress =
    await SpeakingRuleProgressService.getProgress(
      widget.rule.id,
    );

    if (!mounted) return;

    setState(() {
      _progress = progress;
      _isLoading = false;
    });
  }

  Future<void> _startPractice() async {
    if (_isOpening) return;

    setState(() {
      _isOpening = true;
    });

    try {
      await widget.onStartPractice();

      if (!mounted) return;
      await _loadProgress();
    } finally {
      if (mounted) {
        setState(() {
          _isOpening = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final progress = _progress ??
        SpeakingRuleProgress.empty(widget.rule.id);

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: AppColors.background,
        elevation: 0,
        title: Text(
          'Rule ${widget.rule.id}',
          style: const TextStyle(
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
          : SafeArea(
        top: false,
        child: Column(
          children: [
            Expanded(
              child: ListView(
                physics: const BouncingScrollPhysics(),
                padding: const EdgeInsets.fromLTRB(
                  20,
                  10,
                  20,
                  30,
                ),
                children: [
                  _buildHeroCard(progress),
                  const SizedBox(height: 18),
                  _buildRuleExplanation(),
                  const SizedBox(height: 16),
                  _buildFormulaCard(),
                  const SizedBox(height: 16),
                  _buildExampleCard(),
                  const SizedBox(height: 23),
                  const Text(
                    'What you will practice',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                  const SizedBox(height: 13),
                  _buildPracticeTypes(),
                  const SizedBox(height: 18),
                  _buildCompletionRequirement(),
                ],
              ),
            ),
            _buildBottomButton(progress),
          ],
        ),
      ),
    );
  }

  Widget _buildHeroCard(
      SpeakingRuleProgress progress,
      ) {
    final practiceProgress =
    (progress.processedCount / 20).clamp(0.0, 1.0);

    return Container(
      padding: const EdgeInsets.all(22),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            AppColors.primary.withValues(alpha: 0.34),
            AppColors.card,
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(27),
        border: Border.all(
          color: AppColors.primary.withValues(alpha: 0.42),
        ),
      ),
      child: Column(
        children: [
          Container(
            width: 68,
            height: 68,
            decoration: BoxDecoration(
              color: AppColors.primary.withValues(alpha: 0.18),
              shape: BoxShape.circle,
            ),
            child: const Icon(
              Icons.record_voice_over_rounded,
              color: AppColors.primary,
              size: 34,
            ),
          ),
          const SizedBox(height: 15),
          Text(
            widget.rule.title,
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontSize: 25,
              fontWeight: FontWeight.w900,
            ),
          ),
          const SizedBox(height: 7),
          Text(
            '${widget.rule.level} • 20 Practices',
            style: const TextStyle(
              color: AppColors.textSecondary,
              fontSize: 13,
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: 22),
          Row(
            children: [
              Text(
                '${progress.processedCount}/20 completed',
                style: const TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w700,
                ),
              ),
              const Spacer(),
              Text(
                '${progress.bestScore}% score',
                style: const TextStyle(
                  color: AppColors.primary,
                  fontSize: 12,
                  fontWeight: FontWeight.w800,
                ),
              ),
            ],
          ),
          const SizedBox(height: 9),
          ClipRRect(
            borderRadius: BorderRadius.circular(20),
            child: LinearProgressIndicator(
              value: practiceProgress,
              minHeight: 9,
              backgroundColor: AppColors.background,
              valueColor: AlwaysStoppedAnimation(
                progress.completed
                    ? AppColors.success
                    : AppColors.primary,
              ),
            ),
          ),
          if (progress.completed) ...[
            const SizedBox(height: 15),
            const Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.check_circle_rounded,
                  color: AppColors.success,
                  size: 20,
                ),
                SizedBox(width: 7),
                Text(
                  'Rule Completed',
                  style: TextStyle(
                    color: AppColors.success,
                    fontWeight: FontWeight.w800,
                  ),
                ),
              ],
            ),
          ],
        ],
      ),
    );
  }

  Widget _buildRuleExplanation() {
    return _informationCard(
      icon: Icons.menu_book_rounded,
      title: 'Easy Explanation',
      child: Text(
        widget.rule.explanation,
        style: const TextStyle(
          fontSize: 14,
          height: 1.6,
        ),
      ),
    );
  }

  Widget _buildFormulaCard() {
    return _informationCard(
      icon: Icons.account_tree_rounded,
      title: 'Sentence Structure',
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 15,
        ),
        decoration: BoxDecoration(
          color: AppColors.primary.withValues(alpha: 0.10),
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: AppColors.primary.withValues(alpha: 0.30),
          ),
        ),
        child: Text(
          widget.rule.formula,
          textAlign: TextAlign.center,
          style: const TextStyle(
            color: AppColors.primary,
            fontSize: 16,
            fontWeight: FontWeight.w900,
          ),
        ),
      ),
    );
  }

  Widget _buildExampleCard() {
    return _informationCard(
      icon: Icons.lightbulb_rounded,
      title: 'Example',
      child: Row(
        children: [
          Expanded(
            child: Text(
              widget.rule.example,
              style: const TextStyle(
                fontSize: 17,
                height: 1.5,
                fontWeight: FontWeight.w800,
              ),
            ),
          ),
          const SizedBox(width: 10),
          Container(
            width: 43,
            height: 43,
            decoration: BoxDecoration(
              color: AppColors.primary.withValues(alpha: 0.12),
              shape: BoxShape.circle,
            ),
            child: const Icon(
              Icons.volume_up_rounded,
              color: AppColors.primary,
            ),
          ),
        ],
      ),
    );
  }

  Widget _informationCard({
    required IconData icon,
    required String title,
    required Widget child,
  }) {
    return Container(
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: AppColors.card,
        borderRadius: BorderRadius.circular(21),
        border: Border.all(
          color: AppColors.border,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(
                icon,
                color: AppColors.primary,
                size: 21,
              ),
              const SizedBox(width: 9),
              Text(
                title,
                style: const TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w800,
                ),
              ),
            ],
          ),
          const SizedBox(height: 14),
          child,
        ],
      ),
    );
  }

  Widget _buildPracticeTypes() {
    const items = [
      _PracticeInformation(
        Icons.rule_rounded,
        'Structure Choice',
        '2 practices',
      ),
      _PracticeInformation(
        Icons.edit_note_rounded,
        'Fill in the Blank',
        '2 practices',
      ),
      _PracticeInformation(
        Icons.sort_by_alpha_rounded,
        'Word Arrangement',
        '2 practices',
      ),
      _PracticeInformation(
        Icons.translate_rounded,
        'Translate & Speak',
        '4 practices',
      ),
      _PracticeInformation(
        Icons.headphones_rounded,
        'Listen & Repeat',
        '3 practices',
      ),
      _PracticeInformation(
        Icons.image_rounded,
        'Picture Speaking',
        '2 practices',
      ),
      _PracticeInformation(
        Icons.question_answer_rounded,
        'Question & Answer',
        '2 practices',
      ),
      _PracticeInformation(
        Icons.auto_fix_high_rounded,
        'Error Correction',
        '1 practice',
      ),
      _PracticeInformation(
        Icons.public_rounded,
        'Real-life Situation',
        '1 practice',
      ),
      _PracticeInformation(
        Icons.forum_rounded,
        'Mini Conversation',
        '1 practice',
      ),
    ];

    return Container(
      decoration: BoxDecoration(
        color: AppColors.card,
        borderRadius: BorderRadius.circular(21),
        border: Border.all(color: AppColors.border),
      ),
      child: Column(
        children: List.generate(items.length, (index) {
          final item = items[index];

          return Column(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 14,
                ),
                child: Row(
                  children: [
                    Container(
                      width: 39,
                      height: 39,
                      decoration: BoxDecoration(
                        color: AppColors.primary
                            .withValues(alpha: 0.11),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Icon(
                        item.icon,
                        color: AppColors.primary,
                        size: 20,
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Text(
                        item.title,
                        style: const TextStyle(
                          fontSize: 13,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                    Text(
                      item.count,
                      style: const TextStyle(
                        color: AppColors.textSecondary,
                        fontSize: 11,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              ),
              if (index != items.length - 1)
                const Divider(
                  height: 1,
                  color: AppColors.border,
                ),
            ],
          );
        }),
      ),
    );
  }

  Widget _buildCompletionRequirement() {
    return Container(
      padding: const EdgeInsets.all(17),
      decoration: BoxDecoration(
        color: AppColors.warning.withValues(alpha: 0.09),
        borderRadius: BorderRadius.circular(19),
        border: Border.all(
          color: AppColors.warning.withValues(alpha: 0.45),
        ),
      ),
      child: const Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(
            Icons.info_outline_rounded,
            color: AppColors.warning,
          ),
          SizedBox(width: 11),
          Expanded(
            child: Text(
              'Complete at least 15 practices and achieve '
                  '60% speaking accuracy to unlock the next rule.',
              style: TextStyle(
                fontSize: 12,
                height: 1.5,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBottomButton(
      SpeakingRuleProgress progress,
      ) {
    String text;

    if (progress.completed) {
      text = 'Practice Again';
    } else if (progress.processedCount > 0) {
      text =
      'Continue from ${progress.currentPractice + 1}/20';
    } else {
      text = 'Start 20 Practices';
    }

    return Container(
      padding: const EdgeInsets.fromLTRB(20, 11, 20, 17),
      decoration: const BoxDecoration(
        color: AppColors.background,
        border: Border(
          top: BorderSide(color: AppColors.border),
        ),
      ),
      child: SizedBox(
        width: double.infinity,
        child: ElevatedButton.icon(
          onPressed: _isOpening ? null : _startPractice,
          icon: _isOpening
              ? const SizedBox(
            width: 19,
            height: 19,
            child: CircularProgressIndicator(
              color: Colors.white,
              strokeWidth: 2.3,
            ),
          )
              : const Icon(Icons.play_arrow_rounded),
          label: Text(
            _isOpening ? 'Opening...' : text,
          ),
        ),
      ),
    );
  }
}

class _PracticeInformation {
  final IconData icon;
  final String title;
  final String count;

  const _PracticeInformation(
      this.icon,
      this.title,
      this.count,
      );
}
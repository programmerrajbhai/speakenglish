import 'package:flutter/material.dart';

import '../data/speaking_rules_catalog.dart';
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
  static const Color _background = Color(0xFF10090B);
  static const Color _surface = Color(0xFF1D1215);
  static const Color _surfaceLight = Color(0xFF28191D);
  static const Color _primary = Color(0xFFFF4757);
  static const Color _success = Color(0xFF35D889);
  static const Color _warning = Color(0xFFFFB84D);
  static const Color _secondaryText = Color(0xFFB9AAAE);

  final Map<int, SpeakingRuleProgress> _progress = {};
  final Map<int, bool> _unlockedRules = {};

  bool _isLoading = true;
  int _selectedStage = 1;

  @override
  void initState() {
    super.initState();
    _loadProgress();
  }

  SpeakingRule? _contentFor(int ruleId) {
    return SpeakingRulesRepository.findByIdOrNull(ruleId);
  }

  Future<void> _loadProgress() async {
    if (mounted) {
      setState(() {
        _isLoading = true;
      });
    }

    final progressMap = <int, SpeakingRuleProgress>{};
    final unlockedMap = <int, bool>{};

    for (final catalogRule in SpeakingRulesCatalog.rules) {
      progressMap[catalogRule.id] =
      await SpeakingRuleProgressService.getProgress(
        catalogRule.id,
      );

      // Content থাকা সব Rule শুরু থেকেই unlocked।
      unlockedMap[catalogRule.id] =
          _contentFor(catalogRule.id) != null;
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

  Future<void> _openRule(
      SpeakingRuleCatalogItem catalogRule,
      ) async {
    final content = _contentFor(catalogRule.id);

    if (content == null) {
      _showMessage(
        'Rule ${catalogRule.id} content is coming soon.',
      );
      return;
    }

    await widget.onOpenRule(content);

    if (!mounted) return;
    await _loadProgress();
  }

  void _showMessage(String message) {
    ScaffoldMessenger.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(
        SnackBar(
          content: Text(message),
          behavior: SnackBarBehavior.floating,
          backgroundColor: _surfaceLight,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(14),
          ),
        ),
      );
  }

  @override
  Widget build(BuildContext context) {
    final stageRules = SpeakingRulesCatalog.rules
        .where((rule) => rule.stage == _selectedStage)
        .toList(growable: false);

    return Scaffold(
      backgroundColor: _background,
      body: Stack(
        children: [
          const _RoadmapBackground(),
          SafeArea(
            child: Column(
              children: [
                _buildAppBar(),
                Expanded(
                  child: _isLoading
                      ? const Center(
                    child: CircularProgressIndicator(
                      color: _primary,
                    ),
                  )
                      : RefreshIndicator(
                    color: _primary,
                    backgroundColor: _surfaceLight,
                    onRefresh: _loadProgress,
                    child: ListView(
                      cacheExtent: 900,
                      keyboardDismissBehavior:
                      ScrollViewKeyboardDismissBehavior
                          .onDrag,
                      physics:
                      const BouncingScrollPhysics(
                        parent:
                        AlwaysScrollableScrollPhysics(),
                      ),
                      padding: const EdgeInsets.fromLTRB(
                        18,
                        8,
                        18,
                        36,
                      ),
                      children: [
                        _buildJourneyHeader(),
                        const SizedBox(height: 20),
                        _buildStageSelector(),
                        const SizedBox(height: 22),
                        _buildStageHeader(),
                        const SizedBox(height: 16),
                        ...List.generate(
                          stageRules.length,
                              (index) {
                            return _buildRoadmapItem(
                              stageRules[index],
                              index,
                              stageRules.length,
                            );
                          },
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAppBar() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(7, 6, 17, 8),
      child: Row(
        children: [
          IconButton(
            tooltip: 'Back',
            onPressed: () => Navigator.pop(context),
            icon: const Icon(
              Icons.arrow_back_rounded,
              color: Colors.white,
            ),
          ),
          const SizedBox(width: 3),
          const Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Speaking Roadmap',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 19,
                    fontWeight: FontWeight.w900,
                    letterSpacing: -0.3,
                  ),
                ),
                SizedBox(height: 2),
                Text(
                  '60 rules • Beginner to confident speaker',
                  style: TextStyle(
                    color: _secondaryText,
                    fontSize: 10,
                  ),
                ),
              ],
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(
              horizontal: 11,
              vertical: 7,
            ),
            decoration: BoxDecoration(
              color: _primary.withValues(alpha: 0.13),
              borderRadius: BorderRadius.circular(20),
              border: Border.all(
                color: _primary.withValues(alpha: 0.28),
              ),
            ),
            child: const Row(
              children: [
                Icon(
                  Icons.local_fire_department_rounded,
                  color: Color(0xFFFF826A),
                  size: 17,
                ),
                SizedBox(width: 5),
                Text(
                  '60',
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w900,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildJourneyHeader() {
    final completedCount =
        SpeakingRulesCatalog.rules.where((rule) {
          return _progress[rule.id]?.completed ?? false;
        }).length;

    final availableCount =
    SpeakingRulesRepository.rules.length.clamp(0, 60);

    final overallProgress =
    (completedCount / 60).clamp(0.0, 1.0);

    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(25),
        border: Border.all(
          color: _primary.withValues(alpha: 0.34),
        ),
        gradient: const LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            Color(0xFF351A21),
            Color(0xFF211216),
            Color(0xFF151013),
          ],
        ),
        boxShadow: [
          BoxShadow(
            color: _primary.withValues(alpha: 0.10),
            blurRadius: 28,
          ),
        ],
      ),
      child: Column(
        children: [
          Row(
            children: [
              Container(
                width: 57,
                height: 57,
                decoration: BoxDecoration(
                  color: _primary.withValues(alpha: 0.14),
                  borderRadius: BorderRadius.circular(18),
                  border: Border.all(
                    color: _primary.withValues(alpha: 0.30),
                  ),
                ),
                child: const Icon(
                  Icons.record_voice_over_rounded,
                  color: Color(0xFFFF7A84),
                  size: 29,
                ),
              ),
              const SizedBox(width: 13),
              const Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Your speaking journey',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 17,
                        fontWeight: FontWeight.w900,
                      ),
                    ),
                    SizedBox(height: 5),
                    Text(
                      'Learn English step by step with rules and real speaking practice.',
                      style: TextStyle(
                        color: _secondaryText,
                        fontSize: 11,
                        height: 1.4,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 19),
          Row(
            children: [
              Text(
                '$completedCount/60 completed',
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 11,
                  fontWeight: FontWeight.w800,
                ),
              ),
              const Spacer(),
              Text(
                '$availableCount playable',
                style: const TextStyle(
                  color: _secondaryText,
                  fontSize: 10,
                ),
              ),
            ],
          ),
          const SizedBox(height: 9),
          ClipRRect(
            borderRadius: BorderRadius.circular(20),
            child: LinearProgressIndicator(
              value: overallProgress,
              minHeight: 9,
              backgroundColor:
              Colors.black.withValues(alpha: 0.28),
              valueColor:
              const AlwaysStoppedAnimation(_primary),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStageSelector() {
    return SizedBox(
      height: 43,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        cacheExtent: 500,
        physics: const BouncingScrollPhysics(),
        itemCount: 6,
        separatorBuilder: (_, __) =>
        const SizedBox(width: 9),
        itemBuilder: (context, index) {
          final stage = index + 1;
          final selected = stage == _selectedStage;

          return ChoiceChip(
            selected: selected,
            showCheckmark: false,
            onSelected: (_) {
              if (_selectedStage == stage) return;

              setState(() {
                _selectedStage = stage;
              });
            },
            label: Text(
              'Stage $stage',
              style: TextStyle(
                color:
                selected ? Colors.white : _secondaryText,
                fontSize: 11,
                fontWeight: FontWeight.w800,
              ),
            ),
            selectedColor: _primary,
            backgroundColor: _surface,
            side: BorderSide(
              color: selected
                  ? _primary
                  : Colors.white.withValues(alpha: 0.11),
            ),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(14),
            ),
          );
        },
      ),
    );
  }

  Widget _buildStageHeader() {
    final stageIndex = _selectedStage - 1;

    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: 43,
          height: 43,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: _primary.withValues(alpha: 0.12),
            borderRadius: BorderRadius.circular(14),
            border: Border.all(
              color: _primary.withValues(alpha: 0.20),
            ),
          ),
          child: Text(
            '$_selectedStage',
            style: const TextStyle(
              color: _primary,
              fontSize: 17,
              fontWeight: FontWeight.w900,
            ),
          ),
        ),
        const SizedBox(width: 11),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                SpeakingRulesCatalog
                    .stageTitles[stageIndex],
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                  fontWeight: FontWeight.w900,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                SpeakingRulesCatalog
                    .stageSubtitles[stageIndex],
                style: const TextStyle(
                  color: _secondaryText,
                  fontSize: 10,
                  height: 1.35,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildRoadmapItem(
      SpeakingRuleCatalogItem rule,
      int index,
      int totalItems,
      ) {
    final progress = _progress[rule.id] ??
        SpeakingRuleProgress.empty(rule.id);

    final contentAvailable = _contentFor(rule.id) != null;

    // Content থাকা Rule শুরু থেকেই unlocked।
    final unlocked =
        _unlockedRules[rule.id] ?? contentAvailable;

    final completed = progress.completed;
    final started = progress.processedCount > 0;

    final Color statusColor;
    final IconData statusIcon;
    final String statusText;

    if (!contentAvailable) {
      statusColor = _secondaryText;
      statusIcon = Icons.schedule_rounded;
      statusText = 'Coming soon';
    } else if (completed) {
      statusColor = _success;
      statusIcon = Icons.check_rounded;
      statusText = 'Completed';
    } else if (started) {
      statusColor = _warning;
      statusIcon = Icons.play_arrow_rounded;
      statusText = 'Continue';
    } else {
      statusColor = _primary;
      statusIcon = Icons.play_arrow_rounded;
      statusText = 'Start';
    }

    final titleColor = contentAvailable
        ? Colors.white
        : Colors.white.withValues(alpha: 0.48);

    final subtitleColor = contentAvailable
        ? _secondaryText
        : _secondaryText.withValues(alpha: 0.44);

    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          width: 47,
          child: Column(
            children: [
              GestureDetector(
                onTap: () => _openRule(rule),
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 200),
                  width: 47,
                  height: 47,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    color:
                    statusColor.withValues(alpha: 0.14),
                    shape: BoxShape.circle,
                    border: Border.all(
                      color:
                      statusColor.withValues(alpha: 0.65),
                      width: 1.4,
                    ),
                    boxShadow:
                    contentAvailable && unlocked
                        ? [
                      BoxShadow(
                        color: statusColor.withValues(
                          alpha: 0.18,
                        ),
                        blurRadius: 15,
                      ),
                    ]
                        : null,
                  ),
                  child: completed
                      ? Icon(
                    Icons.check_rounded,
                    color: statusColor,
                    size: 23,
                  )
                      : Text(
                    '${rule.id}',
                    style: TextStyle(
                      color: statusColor,
                      fontSize: 14,
                      fontWeight: FontWeight.w900,
                    ),
                  ),
                ),
              ),
              if (index != totalItems - 1)
                Container(
                  width: 2,
                  height: 103,
                  margin:
                  const EdgeInsets.symmetric(vertical: 5),
                  decoration: BoxDecoration(
                    color: completed
                        ? _success.withValues(alpha: 0.38)
                        : Colors.white.withValues(alpha: 0.08),
                    borderRadius: BorderRadius.circular(20),
                  ),
                ),
            ],
          ),
        ),
        const SizedBox(width: 10),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.only(bottom: 13),
            child: Material(
              color: Colors.transparent,
              child: InkWell(
                onTap: () => _openRule(rule),
                borderRadius: BorderRadius.circular(20),
                child: Ink(
                  padding: const EdgeInsets.all(15),
                  decoration: BoxDecoration(
                    color: completed
                        ? _success.withValues(alpha: 0.055)
                        : _surface,
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(
                      color: completed
                          ? _success.withValues(alpha: 0.40)
                          : contentAvailable
                          ? _primary.withValues(alpha: 0.23)
                          : Colors.white
                          .withValues(alpha: 0.075),
                    ),
                  ),
                  child: Column(
                    crossAxisAlignment:
                    CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Expanded(
                            child: Text(
                              rule.title,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                color: titleColor,
                                fontSize: 14,
                                fontWeight: FontWeight.w900,
                              ),
                            ),
                          ),
                          const SizedBox(width: 8),
                          Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 8,
                              vertical: 4,
                            ),
                            decoration: BoxDecoration(
                              color: statusColor.withValues(
                                alpha: 0.11,
                              ),
                              borderRadius:
                              BorderRadius.circular(20),
                            ),
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Icon(
                                  statusIcon,
                                  color: statusColor,
                                  size: 13,
                                ),
                                const SizedBox(width: 4),
                                Text(
                                  statusText,
                                  style: TextStyle(
                                    color: statusColor,
                                    fontSize: 9,
                                    fontWeight: FontWeight.w800,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 6),
                      Text(
                        rule.subtitle,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          color: subtitleColor,
                          fontSize: 10,
                          height: 1.35,
                        ),
                      ),
                      const SizedBox(height: 12),
                      Row(
                        children: [
                          _buildSmallInformation(
                            Icons.task_alt_rounded,
                            '${progress.processedCount}/20',
                          ),
                          const SizedBox(width: 13),
                          _buildSmallInformation(
                            Icons.graphic_eq_rounded,
                            '${progress.bestScore}%',
                          ),
                          const Spacer(),
                          Text(
                            rule.level,
                            style: TextStyle(
                              color: statusColor,
                              fontSize: 9,
                              fontWeight: FontWeight.w800,
                            ),
                          ),
                        ],
                      ),
                      if (started || completed) ...[
                        const SizedBox(height: 10),
                        ClipRRect(
                          borderRadius:
                          BorderRadius.circular(20),
                          child: LinearProgressIndicator(
                            value:
                            (progress.processedCount / 20)
                                .clamp(0.0, 1.0),
                            minHeight: 5,
                            backgroundColor: Colors.black
                                .withValues(alpha: 0.25),
                            valueColor: AlwaysStoppedAnimation(
                              completed ? _success : _primary,
                            ),
                          ),
                        ),
                      ],
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildSmallInformation(
      IconData icon,
      String text,
      ) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(
          icon,
          color: _secondaryText,
          size: 14,
        ),
        const SizedBox(width: 5),
        Text(
          text,
          style: const TextStyle(
            color: _secondaryText,
            fontSize: 9,
            fontWeight: FontWeight.w700,
          ),
        ),
      ],
    );
  }
}

class _RoadmapBackground extends StatelessWidget {
  const _RoadmapBackground();

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          color: _SpeakingRulesScreenState._background,
        ),
        Positioned(
          top: -140,
          left: -80,
          right: -80,
          child: Container(
            height: 300,
            decoration: BoxDecoration(
              gradient: RadialGradient(
                colors: [
                  const Color(0xFF792833)
                      .withValues(alpha: 0.38),
                  Colors.transparent,
                ],
              ),
            ),
          ),
        ),
        Positioned(
          bottom: -110,
          right: -110,
          child: Container(
            width: 270,
            height: 270,
            decoration: BoxDecoration(
              gradient: RadialGradient(
                colors: [
                  const Color(0xFF763CFF)
                      .withValues(alpha: 0.08),
                  Colors.transparent,
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
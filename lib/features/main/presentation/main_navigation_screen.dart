import 'package:flutter/material.dart';

import '../../../core/routes/app_routes.dart';
import '../../../core/theme/app_colors.dart';
import '../../home/presentation/home_screen.dart';
import '../../onboarding/model/onboarding_setup.dart';
import '../../onboarding/presentation/ai_tutor_screen.dart';
import '../../onboarding/presentation/learn_screen.dart';
import '../../onboarding/presentation/progress_screen.dart';
import '../../onboarding/presentation/settings_screen.dart';
import '../../onboarding/services/onboarding_storage.dart';


class MainNavigationScreen extends StatefulWidget {
  const MainNavigationScreen({super.key});

  @override
  State<MainNavigationScreen> createState() =>
      _MainNavigationScreenState();
}

class _MainNavigationScreenState
    extends State<MainNavigationScreen> {
  OnboardingSetup? _setup;
  bool _isLoading = true;
  int _currentIndex = 0;

  @override
  void initState() {
    super.initState();
    _loadSetup();
  }

  Future<void> _loadSetup() async {
    final setup = await OnboardingStorage.load();

    if (!mounted) return;

    if (setup == null) {
      Navigator.pushNamedAndRemoveUntil(
        context,
        AppRoutes.welcome,
            (route) => false,
      );
      return;
    }

    setState(() {
      _setup = setup;
      _isLoading = false;
    });
  }

  void _changeTab(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  Future<void> _resetOnboarding() async {
    await OnboardingStorage.reset();

    if (!mounted) return;

    Navigator.pushNamedAndRemoveUntil(
      context,
      AppRoutes.welcome,
          (route) => false,
    );
  }

  @override
  Widget build(BuildContext context) {
    if (_isLoading || _setup == null) {
      return const Scaffold(
        body: Center(
          child: CircularProgressIndicator(
            color: AppColors.primary,
          ),
        ),
      );
    }

    final setup = _setup!;

    final screens = [
      HomeScreen(
        setup: setup,
        onOpenLearn: () => _changeTab(1),
        onOpenTutor: () => _changeTab(2),
        onOpenProgress: () => _changeTab(3),
      ),
      LearnScreen(setup: setup),
      AiTutorScreen(setup: setup),
      ProgressScreen(setup: setup),
      SettingsScreen(
        setup: setup,
        onResetCourse: _resetOnboarding,
      ),
    ];

    return Scaffold(
      body: IndexedStack(
        index: _currentIndex,
        children: screens,
      ),
      bottomNavigationBar: NavigationBar(
        selectedIndex: _currentIndex,
        onDestinationSelected: _changeTab,
        backgroundColor: const Color(0xFF170D0F),
        indicatorColor:
        AppColors.primary.withValues(alpha: 0.18),
        labelBehavior:
        NavigationDestinationLabelBehavior.alwaysShow,
        destinations: const [
          NavigationDestination(
            icon: Icon(Icons.home_outlined),
            selectedIcon: Icon(
              Icons.home_rounded,
              color: AppColors.primary,
            ),
            label: 'Home',
          ),
          NavigationDestination(
            icon: Icon(Icons.school_outlined),
            selectedIcon: Icon(
              Icons.school_rounded,
              color: AppColors.primary,
            ),
            label: 'Learn',
          ),
          NavigationDestination(
            icon: Icon(Icons.smart_toy_outlined),
            selectedIcon: Icon(
              Icons.smart_toy_rounded,
              color: AppColors.primary,
            ),
            label: 'Tutor',
          ),
          NavigationDestination(
            icon: Icon(Icons.bar_chart_outlined),
            selectedIcon: Icon(
              Icons.bar_chart_rounded,
              color: AppColors.primary,
            ),
            label: 'Progress',
          ),
          NavigationDestination(
            icon: Icon(Icons.settings_outlined),
            selectedIcon: Icon(
              Icons.settings_rounded,
              color: AppColors.primary,
            ),
            label: 'Settings',
          ),
        ],
      ),
    );
  }
}
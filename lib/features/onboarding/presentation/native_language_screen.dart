import 'package:flutter/material.dart';

import '../../../core/routes/app_routes.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/widgets/language_card.dart';
import '../data/languages_data.dart';
import '../model/language_model.dart';


class NativeLanguageScreen extends StatefulWidget {
  const NativeLanguageScreen({super.key});

  @override
  State<NativeLanguageScreen> createState() =>
      _NativeLanguageScreenState();
}

class _NativeLanguageScreenState extends State<NativeLanguageScreen> {
  final TextEditingController _searchController = TextEditingController();

  LanguageModel? _selectedLanguage;
  String _searchText = '';

  List<LanguageModel> get _filteredLanguages {
    final query = _searchText.trim().toLowerCase();

    if (query.isEmpty) {
      return LanguagesData.languages;
    }

    return LanguagesData.languages.where((language) {
      return language.name.toLowerCase().contains(query) ||
          language.nativeName.toLowerCase().contains(query);
    }).toList();
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  void _continue() {
    final selectedLanguage = _selectedLanguage;

    if (selectedLanguage == null) return;

    Navigator.pushNamed(
      context,
      AppRoutes.learningLanguage,
      arguments: selectedLanguage,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Color(0xFF251719),
              AppColors.background,
            ],
          ),
        ),
        child: SafeArea(
          child: Column(
            children: [
              _buildHeader(),
              Expanded(
                child: ListView(
                  padding: const EdgeInsets.fromLTRB(22, 8, 22, 120),
                  children: [
                    _buildSearchField(),
                    const SizedBox(height: 22),
                    Text(
                      '${_filteredLanguages.length} languages',
                      style: const TextStyle(
                        color: AppColors.textSecondary,
                        fontSize: 13,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(height: 12),
                    ..._filteredLanguages.map(
                          (language) => LanguageCard(
                        language: language,
                        isSelected:
                        _selectedLanguage?.code == language.code,
                        onTap: () {
                          setState(() {
                            _selectedLanguage = language;
                          });
                        },
                      ),
                    ),
                  ],
                ),
              ),
              _buildBottomButton(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(22, 14, 22, 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              IconButton(
                onPressed: () => Navigator.pop(context),
                style: IconButton.styleFrom(
                  backgroundColor: AppColors.card,
                ),
                icon: const Icon(Icons.arrow_back_rounded),
              ),
              const Spacer(),
              const Text(
                'Step 1 of 4',
                style: TextStyle(
                  color: AppColors.textSecondary,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
          const SizedBox(height: 22),
          const Text(
            'Which language\ndo you speak?',
            style: TextStyle(
              fontSize: 31,
              height: 1.12,
              fontWeight: FontWeight.w800,
              letterSpacing: -0.7,
            ),
          ),
          const SizedBox(height: 10),
          const Text(
            'We will use this language to explain your lessons.',
            style: TextStyle(
              color: AppColors.textSecondary,
              fontSize: 14,
              height: 1.5,
            ),
          ),
          const SizedBox(height: 20),
          _buildProgressBar(),
        ],
      ),
    );
  }

  Widget _buildProgressBar() {
    return ClipRRect(
      borderRadius: BorderRadius.circular(20),
      child: const LinearProgressIndicator(
        value: 0.25,
        minHeight: 6,
        backgroundColor: AppColors.card,
        valueColor: AlwaysStoppedAnimation(AppColors.primary),
      ),
    );
  }

  Widget _buildSearchField() {
    return TextField(
      controller: _searchController,
      onChanged: (value) {
        setState(() {
          _searchText = value;
        });
      },
      decoration: InputDecoration(
        hintText: 'Search language',
        hintStyle: const TextStyle(
          color: AppColors.textSecondary,
        ),
        prefixIcon: const Icon(
          Icons.search_rounded,
          color: AppColors.textSecondary,
        ),
        suffixIcon: _searchText.isNotEmpty
            ? IconButton(
          onPressed: () {
            _searchController.clear();
            setState(() {
              _searchText = '';
            });
          },
          icon: const Icon(Icons.close_rounded),
        )
            : null,
        filled: true,
        fillColor: AppColors.card,
        contentPadding: const EdgeInsets.symmetric(vertical: 18),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(18),
          borderSide: const BorderSide(color: AppColors.border),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(18),
          borderSide: const BorderSide(color: AppColors.border),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(18),
          borderSide: const BorderSide(
            color: AppColors.primary,
            width: 1.5,
          ),
        ),
      ),
    );
  }

  Widget _buildBottomButton() {
    return Container(
      padding: const EdgeInsets.fromLTRB(22, 14, 22, 18),
      decoration: BoxDecoration(
        color: AppColors.background.withValues(alpha: 0.96),
        border: const Border(
          top: BorderSide(color: AppColors.border),
        ),
      ),
      child: ElevatedButton(
        onPressed: _selectedLanguage == null ? null : _continue,
        style: ElevatedButton.styleFrom(
          disabledBackgroundColor: AppColors.card,
          disabledForegroundColor: AppColors.textSecondary,
        ),
        child: const Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Continue'),
            SizedBox(width: 9),
            Icon(Icons.arrow_forward_rounded),
          ],
        ),
      ),
    );
  }
}
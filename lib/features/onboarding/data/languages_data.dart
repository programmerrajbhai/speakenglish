import '../model/language_model.dart';

class LanguagesData {
  LanguagesData._();

  static const List<LanguageModel> languages = [
    LanguageModel(
      code: 'bn',
      name: 'Bangla',
      nativeName: 'বাংলা',
      flag: '🇧🇩',
      speechLocale: 'bn-BD',
    ),
    LanguageModel(
      code: 'en',
      name: 'English',
      nativeName: 'English',
      flag: '🇺🇸',
      speechLocale: 'en-US',
    ),
    LanguageModel(
      code: 'hi',
      name: 'Hindi',
      nativeName: 'हिन्दी',
      flag: '🇮🇳',
      speechLocale: 'hi-IN',
    ),
    LanguageModel(
      code: 'es',
      name: 'Spanish',
      nativeName: 'Español',
      flag: '🇪🇸',
      speechLocale: 'es-ES',
    ),
    LanguageModel(
      code: 'ar',
      name: 'Arabic',
      nativeName: 'العربية',
      flag: '🇸🇦',
      speechLocale: 'ar-SA',
    ),
    LanguageModel(
      code: 'zh',
      name: 'Mandarin Chinese',
      nativeName: '普通话',
      flag: '🇨🇳',
      speechLocale: 'zh-CN',
    ),
    LanguageModel(
      code: 'ja',
      name: 'Japanese',
      nativeName: '日本語',
      flag: '🇯🇵',
      speechLocale: 'ja-JP',
    ),
    LanguageModel(
      code: 'ko',
      name: 'Korean',
      nativeName: '한국어',
      flag: '🇰🇷',
      speechLocale: 'ko-KR',
    ),
    LanguageModel(
      code: 'fr',
      name: 'French',
      nativeName: 'Français',
      flag: '🇫🇷',
      speechLocale: 'fr-FR',
    ),
    LanguageModel(
      code: 'de',
      name: 'German',
      nativeName: 'Deutsch',
      flag: '🇩🇪',
      speechLocale: 'de-DE',
    ),
    LanguageModel(
      code: 'pt',
      name: 'Portuguese',
      nativeName: 'Português',
      flag: '🇧🇷',
      speechLocale: 'pt-BR',
    ),
    LanguageModel(
      code: 'ta',
      name: 'Tamil',
      nativeName: 'தமிழ்',
      flag: '🇮🇳',
      speechLocale: 'ta-IN',
    ),
  ];
}
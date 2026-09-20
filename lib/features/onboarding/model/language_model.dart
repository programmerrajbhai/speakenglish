class LanguageModel {
  final String code;
  final String name;
  final String nativeName;
  final String flag;
  final String speechLocale;
  final bool isAvailable;

  const LanguageModel({
    required this.code,
    required this.name,
    required this.nativeName,
    required this.flag,
    required this.speechLocale,
    this.isAvailable = true,
  });
}
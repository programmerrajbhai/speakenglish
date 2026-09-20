class LessonExample {
  final String id;
  final Map<String, String> translations;

  const LessonExample({
    required this.id,
    required this.translations,
  });

  String textFor(String languageCode) {
    return translations[languageCode] ??
        translations['en'] ??
        '';
  }
}

class LessonModel {
  final String id;
  final String title;
  final String description;
  final String formula;
  final List<LessonExample> examples;

  const LessonModel({
    required this.id,
    required this.title,
    required this.description,
    required this.formula,
    required this.examples,
  });
}
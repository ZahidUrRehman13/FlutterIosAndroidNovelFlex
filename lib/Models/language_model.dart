
class LanguageModel {
  final String flag;
  final String name;
  final String languageCode;

  LanguageModel(
    this.flag,
    this.name,
    this.languageCode,
  );

  static List<LanguageModel> languageList() {
    return <LanguageModel>[
      LanguageModel("πΊπΈ", "English", 'en'),
      LanguageModel("π¦πͺ", "Arabic", 'ar'),
    ];
  }
}

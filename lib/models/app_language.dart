enum AppLanguage { zh, en }

class L10n {
  const L10n({required this.zh, required this.en});

  final String zh;
  final String en;

  String text(AppLanguage lang) {
    switch (lang) {
      case AppLanguage.zh:
        return zh;
      case AppLanguage.en:
        return en;
    }
  }
}

class TranslationsState {
  final Map<String, String> translations;
  final bool isLoading;
  final bool hasError;

  TranslationsState({
    required this.translations,
    this.isLoading = false,
    this.hasError = false,
  });

  TranslationsState copyWith({
    Map<String, String>? translations,
    bool? isLoading,
    bool? hasError,
  }) {
    return TranslationsState(
      translations: translations ?? this.translations,
      isLoading: isLoading ?? this.isLoading,
      hasError: hasError ?? this.hasError,
    );
  }
}

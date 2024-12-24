import 'dart:ui';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:support/core/utils/locale_utils.dart';
import 'translations_state.dart';

class TranslationsCubit extends Cubit<TranslationsState> {
  TranslationsCubit() : super(TranslationsState(translations: {}));

  Future<void> loadTranslationsFromCubit(Locale locale) async {
    emit(state.copyWith(isLoading: true, hasError: false));
    try {
      final translations = await LocaleUtils.loadTranslations(locale.languageCode);
      emit(state.copyWith(translations: translations, isLoading: false));
    } catch (error) {
      emit(state.copyWith(isLoading: false, hasError: true));
    }
  }
}

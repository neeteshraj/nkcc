import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:support/core/utils/translation_utils.dart';
import 'translations_state.dart';

class TranslationsCubit extends Cubit<TranslationsState> {
  TranslationsCubit() : super(TranslationsState(translations: {}));

  Future<void> loadTranslationsFromCubit(BuildContext context) async {
    emit(state.copyWith(isLoading: true, hasError: false));
    try {
      final translations = await loadTranslations(context);
      emit(state.copyWith(translations: translations, isLoading: false));
    } catch (error) {
      emit(state.copyWith(isLoading: false, hasError: true));
    }
  }
}

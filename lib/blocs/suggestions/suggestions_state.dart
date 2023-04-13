part of 'suggestions_bloc.dart';

@immutable
abstract class SuggestionsState {}

class SuggestionsInitialState extends SuggestionsState {}

class SuggestionLoadingState extends SuggestionsState {}

class SuggestionSuccessState extends SuggestionsState {
  final List<Map<String, dynamic>> suggestions;

  SuggestionSuccessState({required this.suggestions});
}

class SuggestionFailureState extends SuggestionsState {
  final String message;

  SuggestionFailureState({
    this.message =
        'Something went wrong, Please check your connection and try again!.',
  });
}

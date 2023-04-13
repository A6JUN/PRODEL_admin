part of 'suggestions_bloc.dart';

@immutable
abstract class SuggestionsEvent {}

class ChangeSuggestionStatusEvent extends SuggestionsEvent {
  final int suggestionId;

  ChangeSuggestionStatusEvent({required this.suggestionId});
}

class GetAllSuggestionEvent extends SuggestionsEvent {
  final String? query;

  GetAllSuggestionEvent({this.query});
}

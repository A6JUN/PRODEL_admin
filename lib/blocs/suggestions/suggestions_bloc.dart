import 'package:bloc/bloc.dart';
import 'package:logger/logger.dart';
import 'package:meta/meta.dart';
import 'package:prodel_admin/util/iterable_extension.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

part 'suggestions_event.dart';
part 'suggestions_state.dart';

class SuggestionsBloc extends Bloc<SuggestionsEvent, SuggestionsState> {
  SuggestionsBloc() : super(SuggestionsInitialState()) {
    on<SuggestionsEvent>((event, emit) async {
      emit(SuggestionLoadingState());
      SupabaseClient supabaseClient = Supabase.instance.client;
      SupabaseQueryBuilder queryTable = supabaseClient.from('feedbacks');
      SupabaseQueryBuilder subQueryTable = supabaseClient.from('profiles');
      List<Map<String, dynamic>> suggestionWithProfileList = [];
      Map<String, dynamic> suggestionWithProfileMap = {};
      try {
        if (event is GetAllSuggestionEvent) {
          List<dynamic> temp = event.query != null
              ? await queryTable
                  .select()
                  .ilike('name', '%${event.query}%')
                  .order("name", ascending: true)
              : await queryTable.select().order('id', ascending: false);

          List<User> users =
              await supabaseClient.auth.admin.listUsers(perPage: 1000);

          List<Map<String, dynamic>> suggestions = temp.map((e) {
            Map<String, dynamic> element = e as Map<String, dynamic>;

            User? user =
                users.firstOrNull((user) => user.id == element['user_id']);

            element['status'] =
                user != null ? user.userMetadata!['status'] : '';
            element['email'] = user != null ? user.email : '';

            return element;
          }).toList();

          for (Map<String, dynamic> suggestion in suggestions) {
            Map<String, dynamic> profile = await subQueryTable
                .select()
                .eq('user_id', suggestion['user_id'])
                .single();
            suggestionWithProfileMap = {
              'suggestion': suggestion,
              'profile': profile
            };

            suggestionWithProfileList.add(suggestionWithProfileMap);
          }

          emit(SuggestionSuccessState(
            suggestions: suggestionWithProfileList,
          ));
        } else if (event is ChangeSuggestionStatusEvent) {
          await queryTable.update({
            'status': 'completed',
          }).eq(
            'id',
            event.suggestionId,
          );
          add(GetAllSuggestionEvent());
        }
      } catch (e, s) {
        Logger().e('$e\n$s');
        emit(SuggestionFailureState(message: e.toString()));
      }
    });
  }
}

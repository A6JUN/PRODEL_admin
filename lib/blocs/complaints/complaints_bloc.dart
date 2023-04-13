import 'package:bloc/bloc.dart';
import 'package:logger/logger.dart';
import 'package:meta/meta.dart';
import 'package:prodel_admin/util/iterable_extension.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

part 'complaints_event.dart';
part 'complaints_state.dart';

class ComplaintsBloc extends Bloc<ComplaintsEvent, ComplaintsState> {
  ComplaintsBloc() : super(ComplaintsInitialState()) {
    on<ComplaintsEvent>((event, emit) async {
      emit(ComplaintsLoadingState());
      SupabaseClient supabaseClient = Supabase.instance.client;
      SupabaseQueryBuilder queryTable = supabaseClient.from('complaints');
      SupabaseQueryBuilder subQueryTable = supabaseClient.from('profiles');
      List<Map<String, dynamic>> complaintWithProfileList = [];
      Map<String, dynamic> complaintWithProfileMap = {};
      try {
        if (event is GetAllComplaintsEvent) {
          List<dynamic> temp = event.query != null
              ? await queryTable
                  .select()
                  .ilike('name', '%${event.query}%')
                  .order("name", ascending: true)
              : await queryTable.select().order('id', ascending: false);

          List<User> users =
              await supabaseClient.auth.admin.listUsers(perPage: 1000);

          List<Map<String, dynamic>> complaints = temp.map((e) {
            Map<String, dynamic> element = e as Map<String, dynamic>;

            User? user =
                users.firstOrNull((user) => user.id == element['user_id']);

            element['status'] =
                user != null ? user.userMetadata!['status'] : '';
            element['email'] = user != null ? user.email : '';

            return element;
          }).toList();

          for (Map<String, dynamic> complaint in complaints) {
            Map<String, dynamic> profile = await subQueryTable
                .select()
                .eq('user_id', complaint['user_id'])
                .single();
            complaintWithProfileMap = {
              'complaint': complaint,
              'profile': profile
            };

            complaintWithProfileList.add(complaintWithProfileMap);
          }

          emit(ComplaintsSuccessState(
            complaints: complaintWithProfileList,
          ));
        } else if (event is ChangeComplaintStatusEvent) {
          await queryTable.update({
            'status': 'completed',
          }).eq(
            'id',
            event.complaintId,
          );
          add(GetAllComplaintsEvent());
        }
      } catch (e, s) {
        Logger().e('$e\n$s');
        emit(ComplaintFailureState(message: e.toString()));
      }
    });
  }
}

import 'package:bloc/bloc.dart';
import 'package:logger/logger.dart';
import 'package:meta/meta.dart';
import 'package:prodel_admin/util/iterable_extension.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

part 'customer_event.dart';
part 'customer_state.dart';

class CustomerBloc extends Bloc<CustomerEvent, CustomerState> {
  CustomerBloc() : super(CustomerInitialState()) {
    on<CustomerEvent>((event, emit) async {
      emit(CustomerLoadingState());
      SupabaseClient supabaseClient = Supabase.instance.client;
      SupabaseQueryBuilder queryTable = supabaseClient.from('profiles');
      try {
        if (event is GetAllCustomersEvent) {
          List<dynamic> temp = event.query != null
              ? await queryTable
                  .select()
                  .ilike('name', '%${event.query}%')
                  .order("name", ascending: true)
              : await queryTable.select().order('id', ascending: false);

          List<User> users =
              await supabaseClient.auth.admin.listUsers(perPage: 1000);

          List<Map<String, dynamic>> customers = temp.map((e) {
            Map<String, dynamic> element = e as Map<String, dynamic>;

            User? user =
                users.firstOrNull((user) => user.id == element['user_id']);

            element['status'] =
                user != null ? user.userMetadata!['status'] : '';
            element['email'] = user != null ? user.email : '';

            return element;
          }).toList();

          emit(CustomerSuccessState(customers: customers));
        }
      } catch (e, s) {
        Logger().e('$e\n$s');
        emit(CustomerFailureState(message: e.toString()));
      }
    });
  }
}

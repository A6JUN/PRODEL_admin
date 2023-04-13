import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:logger/logger.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

part 'service_area_event.dart';
part 'service_area_state.dart';

class ServiceAreaBloc extends Bloc<ServiceAreaEvent, ServiceAreaState> {
  ServiceAreaBloc() : super(ServiceAreaInitialState()) {
    on<ServiceAreaEvent>((event, emit) async {
      emit(ServiceAreaLoadinState());
      SupabaseClient supabaseClient = Supabase.instance.client;
      SupabaseQueryBuilder queryTable = supabaseClient.from('service_areas');
      try {
        if (event is GetAllServiceAreaEvent) {
          List<dynamic> temp = event.query != null
              ? await queryTable
                  .select()
                  .ilike('name', '%${event.query}%')
                  .order("name", ascending: true)
              : await queryTable.select().order('id', ascending: false);

          List<Map<String, dynamic>> areas =
              temp.map((e) => e as Map<String, dynamic>).toList();

          emit(ServiceAreaSuccessState(serviceAreas: areas));
        } else if (event is AddServiceAreaEvent) {
          await queryTable.insert({
            'name': event.areaName,
          });
          add(GetAllServiceAreaEvent());
        } else if (event is DeleteServiceAreaEvent) {
          await queryTable.delete().eq('id', event.areaId);
          add(GetAllServiceAreaEvent());
        }
      } catch (e, s) {
        Logger().e('$e\n$s');
        emit(ServiceAreaFailureState(message: e.toString()));
      }
    });
  }
}

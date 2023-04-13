import 'package:bloc/bloc.dart';
import 'package:logger/logger.dart';
import 'package:meta/meta.dart';
import 'package:prodel_admin/util/iterable_extension.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

part 'shop_event.dart';
part 'shop_state.dart';

class ShopBloc extends Bloc<ShopEvent, ShopState> {
  ShopBloc() : super(ShopInitialState()) {
    on<ShopEvent>((event, emit) async {
      emit(ShopLoadingState());
      SupabaseClient supabaseClient = Supabase.instance.client;
      SupabaseQueryBuilder queryTable = supabaseClient.from('shops');
      SupabaseQueryBuilder subQueryTable = supabaseClient.from('service_areas');
      List<Map<String, dynamic>> shopWithServiceAreaList = [];
      Map<String, dynamic> shopWithAreaMap = {};
      try {
        if (event is GetAllShopEvent) {
          List<dynamic> temp = event.query != null
              ? await queryTable
                  .select()
                  .ilike('name', '%${event.query}%')
                  .order("name", ascending: true)
              : await queryTable.select().order('id', ascending: false);

          List<User> users =
              await supabaseClient.auth.admin.listUsers(perPage: 1000);

          List<Map<String, dynamic>> shops = temp.map((e) {
            Map<String, dynamic> element = e as Map<String, dynamic>;

            User? user =
                users.firstOrNull((user) => user.id == element['user_id']);

            element['status'] =
                user != null ? user.userMetadata!['status'] : '';
            element['email'] = user != null ? user.email : '';

            return element;
          }).toList();

          for (Map<String, dynamic> shop in shops) {
            Map<String, dynamic> area = await subQueryTable
                .select()
                .eq('id', shop['service_area_id'])
                .single();
            shopWithAreaMap = {'shop': shop, 'area': area};

            shopWithServiceAreaList.add(shopWithAreaMap);
          }

          emit(ShopSuccessState(
            shops: shopWithServiceAreaList,
          ));
        } else if (event is AddShopEvent) {
          UserResponse userDetails = await supabaseClient.auth.admin.createUser(
            AdminUserAttributes(
              email: event.email,
              password: event.password,
              userMetadata: {
                'status': 'active',
              },
              emailConfirm: true,
            ),
          );
          if (userDetails.user != null) {
            await queryTable.insert({
              'user_id': userDetails.user!.id,
              'name': event.name,
              'address_line': event.address,
              'place': event.place,
              'city': event.city,
              'pin': event.pin,
              'service_area_id': event.serviceAreaId,
            });
            add(GetAllShopEvent());
          } else {
            emit(ShopFailureState());
          }
        } else if (event is EditShopEvent) {
          AdminUserAttributes attributes =
              AdminUserAttributes(email: event.email);

          if (event.password != null) {
            attributes.password = event.password;
          }

          UserResponse userDetails =
              await supabaseClient.auth.admin.updateUserById(
            event.userId,
            attributes: attributes,
          );
          if (userDetails.user != null) {
            await queryTable.update({
              'name': event.name,
              'address_line': event.address,
              'place': event.place,
              'city': event.city,
              'pin': event.pin,
              'service_area_id': event.serviceAreaId,
            }).eq('user_id', event.userId);
            add(GetAllShopEvent());
          } else {
            emit(ShopFailureState());
          }
        } else if (event is DeleteShopEvent) {
          await queryTable.delete().eq('user_id', event.userId);
          await supabaseClient.auth.admin.deleteUser(event.userId);
          add(GetAllShopEvent());
        } else if (event is ChangeShopStatusEvent) {
          await supabaseClient.auth.admin.updateUserById(
            event.userId,
            attributes: AdminUserAttributes(
              userMetadata: {
                'status': event.status,
              },
              banDuration: event.status == 'active' ? 'none' : '1000h0m',
            ),
          );
          add(GetAllShopEvent());
        }
      } catch (e, s) {
        Logger().e('$e\n$s');
        emit(ShopFailureState(message: e.toString()));
      }
    });
  }
}

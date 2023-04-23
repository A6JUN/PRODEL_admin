import 'package:bloc/bloc.dart';
import 'package:logger/logger.dart';
import 'package:meta/meta.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

part 'manage_order_event.dart';
part 'manage_order_state.dart';

class ManageOrderBloc extends Bloc<ManageOrderEvent, ManageOrderState> {
  ManageOrderBloc() : super(ManageOrderInitialState()) {
    on<ManageOrderEvent>((event, emit) async {
      emit(ManageOrderLoadingState());
      SupabaseClient supabaseClient = Supabase.instance.client;
      SupabaseQueryBuilder queryTable = supabaseClient.from('orders');
      SupabaseQueryBuilder orderItemTable = supabaseClient.from('order_items');
      SupabaseQueryBuilder cartsTable = supabaseClient.from('carts');
      SupabaseQueryBuilder productsTable = supabaseClient.from('products');
      SupabaseQueryBuilder shopsTable = supabaseClient.from('shops');
      SupabaseQueryBuilder profilesTable = supabaseClient.from('profiles');

      try {
        if (event is GetAllOrderEvent) {
          List<dynamic> orders = await queryTable
              .select('*')
              .eq('status', event.status)
              .order('created_at');

          for (int i = 0; i < orders.length; i++) {
            orders[i]['items'] = await orderItemTable
                .select('*')
                .eq('order_id', orders[i]['id']);

            orders[i]['shop'] = await shopsTable
                .select('*')
                .eq('user_id', orders[i]['shop_id'])
                .single();

            orders[i]['user'] = await profilesTable
                .select('*')
                .eq('user_id', orders[i]['user_id'])
                .single();

            for (int j = 0; j < orders[i]['items'].length; j++) {
              orders[i]['items'][j]['product'] = (await supabaseClient.rpc(
                'get_products',
                params: {
                  'search_product_id': orders[i]['items'][j]['product_id'],
                },
              ))[0];
            }
          }

          Logger().w(orders);

          emit(ManageOrderSuccessState(orders: orders));
        } else if (event is CreateOrderEvent) {
          List<dynamic> cartItems = await cartsTable
              .select('*')
              .eq('user_id', supabaseClient.auth.currentUser!.id);

          int total = 0;

          for (int i = 0; i < cartItems.length; i++) {
            cartItems[i]['product'] = await productsTable
                .select('*')
                .eq('id', cartItems[i]['product_id'])
                .single();

            total += (cartItems[i]['product']['discounted_price'] *
                cartItems[i]['quantity']) as int;
          }

          Map<String, dynamic> insertOrderDetails = {
            'order_type': event.type,
            'user_id': supabaseClient.auth.currentUser!.id,
            'shop_id': cartItems[0]['shop_id'],
            'total': total,
          };

          if (event.type == 'delivery' && event.address != null) {
            insertOrderDetails['address'] = event.address!['address'];
            insertOrderDetails['pin'] = event.address!['pin'];
          }

          Map<String, dynamic> orderDetails =
              await queryTable.insert(insertOrderDetails).select().single();

          List<Map<String, dynamic>> orderItems = [];

          for (int i = 0; i < cartItems.length; i++) {
            orderItems.add({
              'order_id': orderDetails['id'],
              'product_id': cartItems[i]['product_id'],
              'quantity': cartItems[i]['quantity'],
              'price': cartItems[i]['product']['discounted_price'],
            });
          }

          await orderItemTable.insert(orderItems);

          await cartsTable
              .delete()
              .eq('user_id', supabaseClient.auth.currentUser!.id);

          add(GetAllOrderEvent(status: 'pending'));
        } else if (event is HandleOrderEvent) {
          await queryTable.update(
            {'status': event.status},
          ).eq('id', event.orderId);
          String getStatus = 'pending';
          if (event.status == 'complete') {
            getStatus = 'packed';
          }
          add(GetAllOrderEvent(status: getStatus));
        }
      } catch (e, s) {
        Logger().e('$e\n$s');
        emit(ManageOrderFailureState(message: e.toString()));
      }
    });
  }
}

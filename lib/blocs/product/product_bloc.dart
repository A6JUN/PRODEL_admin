import 'package:bloc/bloc.dart';
import 'package:logger/logger.dart';
import 'package:meta/meta.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

part 'product_event.dart';
part 'product_state.dart';

class ProductBloc extends Bloc<ProductEvent, ProductState> {
  ProductBloc() : super(ProductInitialState()) {
    on<ProductEvent>((event, emit) async {
      emit(ProductLoadingState());
      SupabaseClient supabaseClient = Supabase.instance.client;
      SupabaseQueryBuilder queryTable = supabaseClient.from('products');
      SupabaseQueryBuilder subQueryTable = supabaseClient.from('shops');
      SupabaseQueryBuilder thirdQueryTable =
          supabaseClient.from('product_images');
      SupabaseQueryBuilder fourthQueryTable =
          supabaseClient.from('service_areas');
      SupabaseQueryBuilder fifthQueryTable =
          supabaseClient.from('product_categories');

      List<Map<String, dynamic>> products = [];
      List<Map<String, dynamic>> imageList = [];
      try {
        if (event is GetAllProductsEvent) {
          List<dynamic> temp = event.query != null
              ? await queryTable
                  .select()
                  .ilike('name', '%${event.query}%')
                  .ilike('category_id', '%${event.categoryId}%')
                  .ilike('shop_id', '%${event.shopId}%')
                  .order("name", ascending: true)
              : await queryTable.select().order('id', ascending: false);

          List<Map<String, dynamic>> productsTemp =
              temp.map((e) => e as Map<String, dynamic>).toList();

          for (Map<String, dynamic> product in productsTemp) {
            String categoryName = await fifthQueryTable
                .select()
                .eq(
                  'id',
                  product['category_id'],
                )
                .single();

            product['category'] = categoryName;

            Map<String, dynamic> shop = await subQueryTable
                .select()
                .eq('user_id', product['shop_id'])
                .single();

            Map<String, dynamic> image =
                await thirdQueryTable.select().eq('product_id', product['id']);
            imageList.add(image);

            String area = await fourthQueryTable
                .select()
                .eq('id', shop['service_area_id'])
                .single();

            shop['service_area'] = area;

            Map<String, dynamic> temp = {
              'product': product,
              'shop': shop,
              'images': imageList,
            };

            products.add(temp);
          }

          emit(ProductSuccessState(
            products: products,
          ));
        } else if (event is ChangeProductStatusEvent) {
          await queryTable.update({
            'status': event.status,
          }).eq(
            'id',
            event.productId,
          );

          add(GetAllProductsEvent());
        }
      } catch (e, s) {
        Logger().e('$e\n$s');
        emit(ProductFailureState(message: e.toString()));
      }
    });
  }
}

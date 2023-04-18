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
      try {
        if (event is GetAllProductsEvent) {
          List<dynamic> temp = (await supabaseClient.rpc(
                'get_products',
                params: {
                  'search_category_id': event.categoryId,
                  'search_query': event.query,
                },
              )) ??
              [];

          List<Map<String, dynamic>> products = temp.map((e) {
            Map<String, dynamic> product = e as Map<String, dynamic>;
            List<dynamic> tempImages = product['images'];
            List<Map<String, dynamic>> images = tempImages
                .map((image) => image as Map<String, dynamic>)
                .toList();
            product['images'] = images;
            return product;
          }).toList();

          Logger().wtf(products);

          emit(
            ProductSuccessState(
              products: products,
            ),
          );
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

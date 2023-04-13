import 'package:bloc/bloc.dart';
import 'package:logger/logger.dart';
import 'package:meta/meta.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

part 'product_category_event.dart';
part 'product_category_state.dart';

class ProductCategoryBloc
    extends Bloc<ProductCategoryEvent, ProductCategoryState> {
  ProductCategoryBloc() : super(ProductCategoryInitialState()) {
    on<ProductCategoryEvent>((event, emit) async {
      emit(ProductCategoryLoadingState());
      SupabaseClient supabaseClient = Supabase.instance.client;
      SupabaseQueryBuilder queryTable =
          supabaseClient.from('product_categories');
      try {
        if (event is GetAllProductCategoryEvent) {
          List<dynamic> temp = event.query != null
              ? await queryTable
                  .select()
                  .ilike('name', '%${event.query}%')
                  .order("name", ascending: true)
              : await queryTable.select().order('id', ascending: false);

          List<Map<String, dynamic>> categories =
              temp.map((e) => e as Map<String, dynamic>).toList();

          emit(ProductCategorySuccessState(productCategories: categories));
        } else if (event is AddProductCategoryEvent) {
          await queryTable.insert({
            'name': event.productCategoryName,
          });
          add(GetAllProductCategoryEvent());
        } else if (event is DeleteProductCategoryEvent) {
          await queryTable.delete().eq(
                'id',
                event.productCategoryId,
              );
          add(GetAllProductCategoryEvent());
        }
      } catch (e, s) {
        Logger().e('$e\n$s');
        emit(ProductCategoryFailureState(message: e.toString()));
      }
    });
  }
}

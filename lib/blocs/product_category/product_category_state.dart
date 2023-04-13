part of 'product_category_bloc.dart';

@immutable
abstract class ProductCategoryState {}

class ProductCategoryInitialState extends ProductCategoryState {}

class ProductCategoryLoadingState extends ProductCategoryState {}

class ProductCategorySuccessState extends ProductCategoryState {
  final List<Map<String, dynamic>> productCategories;

  ProductCategorySuccessState({required this.productCategories});
}

class ProductCategoryFailureState extends ProductCategoryState {
  final String message;

  ProductCategoryFailureState({
    this.message =
        'Something went wrong, Please check your connection and try again!.',
  });
}

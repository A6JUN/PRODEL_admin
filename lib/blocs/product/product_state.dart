part of 'product_bloc.dart';

@immutable
abstract class ProductState {}

class ProductInitialState extends ProductState {}

class ProductLoadingState extends ProductState {}

class ProductSuccessState extends ProductState {
  final List<Map<String, dynamic>> products;

  ProductSuccessState({required this.products});
}

class ProductFailureState extends ProductState {
  final String message;

  ProductFailureState({
    this.message =
        'Something went wrong, Please check your connection and try again!.',
  });
}

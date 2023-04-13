part of 'shop_bloc.dart';

@immutable
abstract class ShopState {}

class ShopInitialState extends ShopState {}

class ShopLoadingState extends ShopState {}

class ShopSuccessState extends ShopState {
  final List<Map<String, dynamic>> shops;

  ShopSuccessState({required this.shops});
}

class ShopFailureState extends ShopState {
  final String message;

  ShopFailureState({
    this.message =
        'Something went wrong, Please check your connection and try again!.',
  });
}

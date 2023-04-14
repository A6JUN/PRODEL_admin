part of 'product_bloc.dart';

@immutable
abstract class ProductEvent {}

class GetAllProductsEvent extends ProductEvent {
  final String? query;
  final int? categoryId, shopId;

  GetAllProductsEvent({
    this.query,
    this.categoryId,
    this.shopId,
  });
}

class ChangeProductStatusEvent extends ProductEvent {
  final int productId;
  final String status;

  ChangeProductStatusEvent({
    required this.productId,
    required this.status,
  });
}

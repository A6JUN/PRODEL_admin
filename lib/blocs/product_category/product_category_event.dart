part of 'product_category_bloc.dart';

@immutable
abstract class ProductCategoryEvent {}

class AddProductCategoryEvent extends ProductCategoryEvent {
  final String productCategoryName;

  AddProductCategoryEvent({required this.productCategoryName});
}

class DeleteProductCategoryEvent extends ProductCategoryEvent {
  final int productCategoryId;

  DeleteProductCategoryEvent({required this.productCategoryId});
}

class GetAllProductCategoryEvent extends ProductCategoryEvent {
  final String? query;
  final int? id;

  GetAllProductCategoryEvent({
    this.query,
    this.id,
  });
}

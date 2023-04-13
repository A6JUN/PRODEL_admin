part of 'shop_bloc.dart';

@immutable
abstract class ShopEvent {}

class AddShopEvent extends ShopEvent {
  final String name, address, place, city, email, password;
  final int pin, serviceAreaId;

  AddShopEvent({
    required this.name,
    required this.address,
    required this.place,
    required this.city,
    required this.pin,
    required this.serviceAreaId,
    required this.email,
    required this.password,
  });
}

class EditShopEvent extends ShopEvent {
  final String name, address, place, city, email, userId;
  final String? password;
  final int pin, serviceAreaId;

  EditShopEvent({
    required this.name,
    required this.address,
    required this.place,
    required this.city,
    required this.email,
    this.password,
    required this.pin,
    required this.serviceAreaId,
    required this.userId,
  });
}

class ChangeShopStatusEvent extends ShopEvent {
  final String userId, status;

  ChangeShopStatusEvent({
    required this.userId,
    required this.status,
  });
}

class DeleteShopEvent extends ShopEvent {
  final String userId;

  DeleteShopEvent({required this.userId});
}

class GetAllShopEvent extends ShopEvent {
  final String? query;

  GetAllShopEvent({
    this.query,
  });
}

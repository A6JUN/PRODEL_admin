part of 'manage_order_bloc.dart';

@immutable
abstract class ManageOrderEvent {}

class CreateOrderEvent extends ManageOrderEvent {
  final String type;
  final Map<String, dynamic>? address;

  CreateOrderEvent({required this.type, this.address});
}

class HandleOrderEvent extends ManageOrderEvent {
  final int orderId;
  final String status;

  HandleOrderEvent({
    required this.orderId,
    required this.status,
  });
}

class GetAllOrderEvent extends ManageOrderEvent {
  final String status;

  GetAllOrderEvent({required this.status});
}

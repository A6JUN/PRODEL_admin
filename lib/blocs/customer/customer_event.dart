part of 'customer_bloc.dart';

@immutable
abstract class CustomerEvent {}

class GetAllCustomersEvent extends CustomerEvent {
  final String? query;

  GetAllCustomersEvent({this.query});
}

part of 'manage_order_bloc.dart';

@immutable
abstract class ManageOrderState {}

class ManageOrderInitialState extends ManageOrderState {}

class ManageOrderLoadingState extends ManageOrderState {}

class ManageOrderSuccessState extends ManageOrderState {
  final List<dynamic> orders;

  ManageOrderSuccessState({required this.orders});
}

class ManageOrderFailureState extends ManageOrderState {
  final String message;

  ManageOrderFailureState({
    this.message =
        'Something went wrong, Please check your connection and try again!.',
  });
}

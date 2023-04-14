part of 'customer_bloc.dart';

@immutable
abstract class CustomerState {}

class CustomerInitialState extends CustomerState {}

class CustomerLoadingState extends CustomerState {}

class CustomerSuccessState extends CustomerState {
  final List<Map<String, dynamic>> customers;

  CustomerSuccessState({required this.customers});
}

class CustomerFailureState extends CustomerState {
  final String message;

  CustomerFailureState({
    this.message =
        'Something went wrong, Please check your connection and try again!.',
  });
}

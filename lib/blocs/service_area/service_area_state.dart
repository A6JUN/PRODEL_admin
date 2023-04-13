part of 'service_area_bloc.dart';

@immutable
abstract class ServiceAreaState {}

class ServiceAreaInitialState extends ServiceAreaState {}

class ServiceAreaLoadinState extends ServiceAreaState {}

class ServiceAreaSuccessState extends ServiceAreaState {
  final List<Map<String, dynamic>> serviceAreas;

  ServiceAreaSuccessState({required this.serviceAreas});
}

class ServiceAreaFailureState extends ServiceAreaState {
  final String message;

  ServiceAreaFailureState({
    this.message =
        'Something went wrong, Please check your connection and try again!.',
  });
}

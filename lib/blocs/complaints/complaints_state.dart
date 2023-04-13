part of 'complaints_bloc.dart';

@immutable
abstract class ComplaintsState {}

class ComplaintsInitialState extends ComplaintsState {}

class ComplaintsLoadingState extends ComplaintsState {}

class ComplaintsSuccessState extends ComplaintsState {
  final List<Map<String, dynamic>> complaints;

  ComplaintsSuccessState({required this.complaints});
}

class ComplaintFailureState extends ComplaintsState {
  final String message;

  ComplaintFailureState({
    this.message =
        'Something went wrong, Please check your connection and try again!.',
  });
}

part of 'complaints_bloc.dart';

@immutable
abstract class ComplaintsEvent {}

class ChangeComplaintStatusEvent extends ComplaintsEvent {
  final int complaintId;

  ChangeComplaintStatusEvent({required this.complaintId});
}

class GetAllComplaintsEvent extends ComplaintsEvent {
  final String? query;

  GetAllComplaintsEvent({this.query});
}

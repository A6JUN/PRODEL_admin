part of 'service_area_bloc.dart';

@immutable
abstract class ServiceAreaEvent {}

class AddServiceAreaEvent extends ServiceAreaEvent {
  final String areaName;

  AddServiceAreaEvent({required this.areaName});
}

class DeleteServiceAreaEvent extends ServiceAreaEvent {
  final int areaId;

  DeleteServiceAreaEvent({required this.areaId});
}

class GetAllServiceAreaEvent extends ServiceAreaEvent {
  final String? query;

  GetAllServiceAreaEvent({this.query});
}

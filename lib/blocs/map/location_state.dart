part of 'location_cubit.dart';

@immutable
abstract class LocationState {}

class LocationInitial extends LocationState {}

class LocationLoaded extends LocationState {
  final String location;

  LocationLoaded(this.location);
}

class LocationFailed extends LocationState {}
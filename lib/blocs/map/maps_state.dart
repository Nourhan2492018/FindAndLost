part of 'maps_cubit.dart';

@immutable
abstract class MapsState {}

class MapsInitial extends MapsState {}

class PlacesLoaded extends MapsState {
  final List<dynamic> places;
  PlacesLoaded(this.places);
}

class PlaceLocationLoaded extends MapsState {
  final Place place;
  PlaceLocationLoaded(this.place);
}
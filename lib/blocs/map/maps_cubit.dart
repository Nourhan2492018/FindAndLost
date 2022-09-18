import 'package:bloc/bloc.dart';
import 'package:find_and_lost/models/place/places_suggestation.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:meta/meta.dart';

import '../../models/place/place.dart';
import '../../repository/maps_repo.dart';

part 'maps_state.dart';

class MapsCubit extends Cubit<MapsState> {
  final MapRepo mapsRepo;

  MapsCubit(this.mapsRepo) : super(MapsInitial());

  void emitPlaceSuggestions(String place, String sessionToken, LatLng orgin) {
    mapsRepo.fetchSuggestations(place, sessionToken, orgin).then((suggestions) {
      emit(PlacesLoaded(suggestions));
    });
  }

  void emitPlaceLocation(String placeId, String sessionToken) {
    mapsRepo.getPlaceLocation(placeId, sessionToken).then((place) {
      emit(PlaceLocationLoaded(place));
    });
  }
}

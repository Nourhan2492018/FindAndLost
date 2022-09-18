import 'dart:async';
import 'package:find_and_lost/models/place/place.dart';
import 'package:find_and_lost/models/place/places_suggestation.dart';
import 'package:find_and_lost/src/app_color.dart';
import 'package:find_and_lost/views/google_map/helpers/location_helper.dart';
import 'package:find_and_lost/views/google_map/helpers/place_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:material_floating_search_bar/material_floating_search_bar.dart';
import 'package:uuid/uuid.dart';

import '../../blocs/map/maps_cubit.dart';

class MapView extends StatefulWidget {
  const MapView({Key? key}) : super(key: key);

  @override
  State<MapView> createState() => _MapViewState();
}

class _MapViewState extends State<MapView> {
  @override
  List<dynamic> places = [];
  FloatingSearchBarController controller = FloatingSearchBarController();

  // The position is filled with the current position of the user.
  static Position? position;
  Completer<GoogleMapController> _mapController = Completer();

  // variables for getPlaces
  Set<Marker> markers = Set<Marker>();
  late PlacesSuggestion placeSuggestation =
      PlacesSuggestion(description: 'x', placeId: 'x');
  late Place selectedPlace;
  late Marker searchedPlaceMarker;
  late CameraPosition goToSearchedForPlace;
  late String Address;

  static final CameraPosition _currentLocationOfCameraPosition = CameraPosition(
    bearing: 0.0,
    zoom: 17,
    tilt: 0.0,
    target: LatLng(position!.latitude, position!.longitude),
  );

  bool visibleFloatingButton = true;

  void buildCameraNewPosition() {
    goToSearchedForPlace = CameraPosition(
      bearing: 0,
      tilt: 0,
      target: LatLng(
        selectedPlace.result.geometry.location.lat,
        selectedPlace.result.geometry.location.lng,
      ),
      zoom: 15,
    );
  }

  Future<void> getUsersCurrentLocation() async {
    await LocationHelper.getCurrentLocation();
    position = await Geolocator.getLastKnownPosition()
        .whenComplete(() => setState(() {}));
  }

  // the floating button action.
  Future<void> _goToUsersCurrentLocation() async {
    final GoogleMapController controller = await _mapController.future;
    controller.animateCamera(
        CameraUpdate.newCameraPosition(_currentLocationOfCameraPosition));
  }

  // Get the current position of the user using Geolocator.
  initState() {
    super.initState();
    getUsersCurrentLocation();
  }

  Widget BuildOfFloatingSearchBar() {
    final isPortrait =
        MediaQuery.of(context).orientation == Orientation.portrait;
    return FloatingSearchBar(
      controller: controller,
      elevation: 6,
      hintStyle: TextStyle(
          fontSize: 16,
        color: AppColor.txtShade,
      ),
      queryStyle: TextStyle(fontSize: 18),
      hint: 'Search here',
      borderRadius: BorderRadius.circular(25),
      border: BorderSide(
          style: BorderStyle.none,
      ),
      margins: EdgeInsets.fromLTRB(20, 70, 20, 0),
      padding: EdgeInsets.fromLTRB(2, 0, 2, 0),
      height: 52,
      iconColor: AppColor.defaultColor,
      scrollPadding: const EdgeInsets.only(bottom: 56),
      transitionDuration: const Duration(milliseconds: 500),
      transitionCurve: Curves.easeInOut,
      physics: const BouncingScrollPhysics(),
      axisAlignment: isPortrait ? 0.0 : -1.0,
      openAxisAlignment: 0.0,
      width: isPortrait ? 600 : 500,
      debounceDelay: const Duration(milliseconds: 300),
      onQueryChanged: (query) {
        getPlacesSuggestations(
            query, context, LatLng(position!.latitude, position!.latitude));
      },
      onFocusChanged: (_) {
        visibleFloatingButton = !visibleFloatingButton;
        setState(() {});
      },
      transition: CircularFloatingSearchBarTransition(),
      leadingActions: [
        FloatingSearchBarAction(
          showIfOpened: false,
          child: CircularButton(
              icon: Icon(Icons.place, color: Colors.black.withOpacity(0.6)),
              onPressed: () {}),
        ),
      ],
      builder: (context, transition) {
        return ClipRRect(
          borderRadius: BorderRadius.circular(8),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              buildSuggestationBloc(),
              buildSelectedLocationBloc(),
            ],
          ),
        );
      },
    );
  }

  Widget buildSelectedLocationBloc() {
    return BlocListener<MapsCubit, MapsState>(
      listener: (context, state) {
        if (state is PlaceLocationLoaded) {
          selectedPlace = state.place;
          goToUserSearchedForLocation();
        }
      },
      child: Container(),
    );
  }

  Future<void> goToUserSearchedForLocation() async {
    buildCameraNewPosition();
    final GoogleMapController controller = await _mapController.future;
    controller
        .animateCamera(CameraUpdate.newCameraPosition(goToSearchedForPlace));
    buildSerchedPlaceMarker();
  }

  void buildSerchedPlaceMarker() {
    searchedPlaceMarker = Marker(
        markerId: const MarkerId('2'),
        position: goToSearchedForPlace.target,
        onTap: () {},
        infoWindow: InfoWindow(
          title: '${placeSuggestation.description}',
        ),
        icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueAzure));
    addMarkerToMarkerAndUpdateUI(searchedPlaceMarker);
  }

  void addMarkerToMarkerAndUpdateUI(Marker searchedPlaceMarker) {
    setState(() {
      markers.add(searchedPlaceMarker);
    });
  }

  void getPlacesSuggestations(
      String query, BuildContext context, LatLng origin) {
    final sessionToken = Uuid().v4();
    BlocProvider.of<MapsCubit>(context)
        .emitPlaceSuggestions(query, sessionToken, origin);
  }

  Widget buildSuggestationBloc() {
    return BlocBuilder<MapsCubit, MapsState>(builder: (context, state) {
      if (state is PlacesLoaded) {
        places = state.places;

        if (places.length != 0)
          return BuildPlacesList();

        // محتاجه تتظبط
        else
          return Padding(
            padding: const EdgeInsets.only(top: 30),
            child: Text('No places found ...',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
          );
      } else
        return Container();
    });
  }

  Widget BuildPlacesList() {
    return ListView.builder(
      itemBuilder: (context, index) {
        return InkWell(
            onTap: () async {

              placeSuggestation = places[index];
              controller.close();
              getSelectedPlaceLocation();
            },
            child: PlaceItem(
              suggestion: places[index],
            ));
      },
      itemCount: places.length,
      shrinkWrap: true,
      physics: const ClampingScrollPhysics(),
    );
  }

  void getSelectedPlaceLocation() {
    final sessionToken = Uuid().v4();
    BlocProvider.of<MapsCubit>(context)
        .emitPlaceLocation(placeSuggestation.placeId, sessionToken);
  }

  Widget buildMap(BuildContext context) {
    return GoogleMap(
      mapType: MapType.normal,
      initialCameraPosition: _currentLocationOfCameraPosition,
      myLocationEnabled: true,
      zoomControlsEnabled: false,
      myLocationButtonEnabled: false,
      onMapCreated: (GoogleMapController controller) {
        _mapController.complete(controller);
      },
      markers: markers,
    );
  }

  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: [
          position != null
              ? buildMap(context)
              : const Center(
                  child: CircularProgressIndicator(),
                ),
          BuildOfFloatingSearchBar(),
          Visibility(
            visible: visibleFloatingButton,
            child: Positioned(
              child: Container(
                height: 50,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(25),
                  color: AppColor.defaultColor,
                ),
                child: MaterialButton(
                  onPressed: () {
                    Navigator.pop(
                        context,
                        placeSuggestation.description != 'x'
                            ? placeSuggestation.description.split(',')[0]
                            : getAddressFromLatLng(position!));
                  },
                  child: Text("Confirm Location"),
                  textColor: AppColor.secondaryColor,
                ),
              ),
              bottom: MediaQuery.of(context).size.height * 0.055,
              right: MediaQuery.of(context).size.width * 0.1,
              left: MediaQuery.of(context).size.width * 0.1,
            ),
          ),
        ],
      ),
      floatingActionButton: Visibility(
        visible: visibleFloatingButton,
        child: Padding(
          padding: const EdgeInsets.only(bottom: 100),
          child: FloatingActionButton(
            backgroundColor: AppColor.secondaryColor,
            onPressed: () {
              _goToUsersCurrentLocation();
            },
            child: const Icon(
              Icons.my_location,
              color: AppColor.defaultColor,
            ),
          ),
        ),
      ),
    );
  }

  Future<String> getAddressFromLatLng(Position position) async {
    List<Placemark> placemarks =
        await placemarkFromCoordinates(position.latitude, position.longitude);
    Placemark placemark = placemarks[0];
    print(placemark);
    return Address = '${placemark.subAdministrativeArea}';
  }
}

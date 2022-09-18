import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'location_state.dart';

class LocationCubit extends Cubit<LocationState> {
  final String location;
  LocationCubit(this.location) : super(LocationInitial());

  void emitLocation() {
    location == null? emit(LocationFailed()): emit(LocationLoaded(location));
  }
}

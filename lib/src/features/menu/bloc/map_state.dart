part of 'map_bloc.dart';

class MapState {}

class MapInitial extends MapState {}

class MapLoading extends MapState {}

class MapLoaded extends MapState {
  final List<CoffeeLocation> locations;

  MapLoaded(this.locations);
  List<Object?> get props => [locations];
}

class MapError extends MapState {
  final String error;

  MapError(this.error);

  @override
  List<Object?> get props => [error];
}

class MapSelected extends MapState {
  final CoffeeLocation selectedLocation;

  MapSelected(this.selectedLocation);

  List<Object?> get props => [selectedLocation];
}

class MapLoadedWithSavedLocation extends MapState {
  final List<PlacemarkMapObject> placemarks;
  final CoffeeLocation savedLocation;

  MapLoadedWithSavedLocation(
      {required this.placemarks, required this.savedLocation});
}

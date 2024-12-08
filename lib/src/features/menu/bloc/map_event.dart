part of 'map_bloc.dart';

class MapEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class LoadLocations extends MapEvent {}

class LocationSelected extends MapEvent {
  final CoffeeLocation location;

  LocationSelected(this.location);
  @override
  List<Object?> get props => [location];
}

class SaveLocation extends MapEvent {
  final CoffeeLocation location;
  SaveLocation(this.location);
}

class LoadSavedLocation extends MapEvent {}

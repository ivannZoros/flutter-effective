import 'package:empty_project/api/api_service.dart';
import 'package:empty_project/src/features/menu/models/location.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:yandex_mapkit/yandex_mapkit.dart';
import 'package:equatable/equatable.dart';

part 'map_event.dart';
part 'map_state.dart';

class MapBloc extends Bloc<MapEvent, MapState> {
  final ApiService _apiService;

  MapBloc(this._apiService) : super(MapInitial()) {
    on<LoadLocations>(_onLoadLocations);
    on<LocationSelected>(_onLocationSelected);
    on<LoadSavedLocation>(_onLoadSavedLocation);
  }
  Future<void> _onLoadLocations(
      LoadLocations event, Emitter<MapState> emit) async {
    emit(MapLoading());
    try {
      final locations = await _apiService.getLocation();
      print('Загружено локаций: ${locations.length}');
      emit(MapLoaded(locations));
    } catch (e) {
      print('Ошибка загрузки локаций: $e');
      emit(MapError("Не удалось загрузить локации: $e"));
    }
  }

  void _onLocationSelected(LocationSelected event, Emitter<MapState> emit) {
    emit(MapSelected(event.location));
  }

  Future<void> _onLoadSavedLocation(
      LoadSavedLocation event, Emitter<MapState> emit) async {
    emit(MapLoading());
    try {
      final savedLocation = await _apiService.getSavedLocation();
      emit(MapLoaded([savedLocation]));
    } catch (e) {
      emit(MapError("Не удалось загрузить сохраненную локацию: $e"));
    }
  }
}

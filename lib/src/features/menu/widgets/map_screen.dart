import 'package:empty_project/src/features/menu/bloc/map_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:yandex_mapkit/yandex_mapkit.dart';
import 'package:empty_project/src/features/menu/models/location.dart';

class MapScreen extends StatefulWidget {
  const MapScreen({super.key});

  @override
  _MapScreenState createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  late YandexMapController _mapController;

  @override
  void initState() {
    super.initState();
    context.read<MapBloc>().add(LoadLocations());
  }

  void _onMarkerTap(CoffeeLocation location) {
    context.read<MapBloc>().add(LocationSelected(location));
    showModalBottomSheet(
      context: context,
      builder: (context) => _buildBottomSheet(location),
    );
    _mapController.moveCamera(CameraUpdate.newCameraPosition(
      CameraPosition(
          target: Point(latitude: location.lat, longitude: location.lng),
          zoom: 15),
    ));
  }

  Widget _buildBottomSheet(CoffeeLocation location) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: Text(
            location.address,
            style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
        ),
        ElevatedButton(
          onPressed: () {
            context.read<MapBloc>().add(SaveLocation(location));
            Navigator.pop(context);
            Navigator.pop(context);
          },
          child: Text('Выбрать'),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Карта кофеен'),
      ),
      body: BlocConsumer<MapBloc, MapState>(
        listener: (context, state) {
          // Обработка побочных эффектов
          if (state is MapError) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(state.error)),
            );
          }
        },
        builder: (context, state) {
          print('Текущее состояние: $state');
          if (state is MapLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is MapLoaded) {
            return YandexMap(
              onMapCreated: (controller) async {
                _mapController = controller;
                await _initLocationLayer();
                if (state.locations.isNotEmpty) {
                  _mapController.moveCamera(CameraUpdate.newCameraPosition(
                    CameraPosition(
                        target: Point(
                            latitude: state.locations[0].lat,
                            longitude: state.locations[0].lng),
                        zoom: 12),
                  ));
                }
              },
              mapObjects: state.locations.map((location) {
                return PlacemarkMapObject(
                  mapId: MapObjectId(location.address),
                  point: Point(latitude: location.lat, longitude: location.lng),
                  onTap: (self, point) => _onMarkerTap(location),
                  icon: PlacemarkIcon.single(PlacemarkIconStyle(
                    image: BitmapDescriptor.fromAssetImage('assets/pin.png'),
                  )),
                );
              }).toList(),
            );
          } else if (state is MapError) {
            return Center(
              child: Text(
                state.error,
                style: TextStyle(color: Colors.red, fontSize: 16),
              ),
            );
          } else if (state is MapLoadedWithSavedLocation) {
            return YandexMap(
              onMapCreated: (controller) {
                _mapController = controller;
                _mapController.moveCamera(CameraUpdate.newCameraPosition(
                  CameraPosition(
                      target: Point(
                          latitude: state.savedLocation.lat,
                          longitude: state.savedLocation.lng),
                      zoom: 15),
                ));
              },
              mapObjects: state.placemarks,
            );
          } else {
            return Center(child: Text('Загрузите карту'));
          }
        },
      ),
    );
  }

  Future<void> _initLocationLayer() async {
    final locationPermissionIsGranted =
        await Permission.location.request().isGranted;

    if (locationPermissionIsGranted) {
      await _mapController.toggleUserLayer(visible: true);
    } else {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Нет доступа к местоположению пользователя'),
          ),
        );
      });
    }
  }
}

import 'package:dio/dio.dart';
import 'package:empty_project/src/features/menu/models/location.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../src/features/menu/models/drink.dart';
import '../src/theme/text_sources.dart';

class ApiService {
  final Dio _dio;
  ApiService(this._dio);

  Future<void> placeOrder(
      List<Drink> cartItems, String fcmToken, BuildContext context) async {
    var orderData = {
      "positions": {
        for (var item in cartItems) item.id.toString(): item.quantity,
      },
      "token": fcmToken,
    };

    try {
      var response = await _dio.post(
        'https://coffeeshop.academy.effective.band/api/v1/orders',
        data: orderData,
      );
      if (response.statusCode == 201) {
        cartItems.clear();
        if (context.mounted) {
          Navigator.pop(context);
        }
      } else {
        if (context.mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text(TextSources.errorDuringOrder),
              duration: Duration(seconds: 2),
            ),
          );
        }
      }
    } catch (error) {
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text(TextSources.errorDuringOrder),
            duration: Duration(seconds: 2),
          ),
        );
      }
    }
  }

  Future<List<CoffeeLocation>> getLocation() async {
    try {
      var response = await _dio.get(
          'https://coffeeshop.academy.effective.band/api/v1/locations/?page=0&limit=25');
      print('Статус ответа: ${response.statusCode}'); // Диагностический принт
      print('Данные: ${response.data}'); // Диагностический принт
      if (response.statusCode == 200) {
        List<dynamic> data = response.data['data'];
        List<CoffeeLocation> locations = data.map((item) {
          return CoffeeLocation(
              address: item['address'], lat: item['lat'], lng: item['lng']);
        }).toList();

        return locations;
      } else {
        throw Exception(
            "Can't parse locations. Status code: ${response.statusCode}");
      }
    } catch (e) {
      print('Критическая ошибка: $e'); // Диагностический принт
      throw Exception("Error getting locations: $e");
    }
  }

  Future<CoffeeLocation> getSavedLocation() async {
    final prefs = await SharedPreferences.getInstance();
    String? address = prefs.getString('saved_address');
    double? lat = prefs.getDouble('saved_lat');
    double? lng = prefs.getDouble('saved_lng');

    if (address != null && lat != null && lng != null) {
      return CoffeeLocation(address: address, lat: lat, lng: lng);
    } else {
      throw Exception("No saved location found.");
    }
  }

  Future<void> saveLocation(CoffeeLocation location) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('saved_address', location.address);
    await prefs.setDouble('saved_lat', location.lat);
    await prefs.setDouble('saved_lng', location.lng);
  }
}

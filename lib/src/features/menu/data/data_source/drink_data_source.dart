import 'package:dio/dio.dart';

import '../../models/drink.dart';

class DrinkDataSource {
  final Dio _dio;

  DrinkDataSource(this._dio);

  Future<List<Drink>> getDrinks(int page, int limit) async {
    try {
      final response = await _dio.get(
          'https://coffeeshop.academy.effective.band/api/v1/products/?page=$page&limit=$limit');

      if (response.statusCode == 200) {
        List<dynamic> data = response.data['data'];
        List<Drink> drinks = data.map((json) => _parseDrink(json)).toList();
        return drinks;
      } else {
        throw Exception("Can't parse drinks");
      }
    } catch (error) {
      throw Exception("Network error");
    }
  }

  Drink _parseDrink(Map<String, dynamic> json) {
    double price = double.tryParse(json['prices']?[0]?['value'] ?? '0') ?? 0.0;
    return Drink(
      name: json['name'] ?? 'Неизвестно',
      price: price,
      imagePath: json['imageUrl'] ?? 'assets/latte.png',
      id: json['id'],
      slug: json['category']?['slug'] ?? '',
    );
  }
}

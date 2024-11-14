import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import '../src/features/menu/models/drink.dart';
import '../src/theme/text_sources.dart';

class ApiService {
  Future<void> placeOrder(
      List<Drink> cartItems, String fcmToken, BuildContext context) async {
    var dio = Dio();

    var orderData = {
      "positions": {
        for (var item in cartItems) item.id.toString(): item.quantity,
      },
      "token": fcmToken,
    };

    try {
      var response = await dio.post(
        'https://coffeeshop.academy.effective.band/api/v1/orders',
        data: orderData,
      );
      if (response.statusCode == 201) {
        cartItems.clear();
        if (context.mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text(TextSources.orderPlaced),
              duration: Duration(seconds: 2),
            ),
          );
          await Future.delayed(const Duration(seconds: 2));
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

  Future<List<Drink>> getDrinks() async {
    try {
      final response = await Dio().get(
          'https://coffeeshop.academy.effective.band/api/v1/products/?page=0&limit=24');
      if (response.statusCode == 200) {
        List<dynamic> data = response.data['data'];
        List<Drink> drinks = data.map((json) => parseDrink(json)).toList();
        return drinks;
      } else {
        throw Exception("Cant parse drinks");
      }
    } catch (error) {
      return [];
    }
  }

  Drink parseDrink(Map<String, dynamic> json) {
    double price = double.tryParse(json['prices']?[0]?['value'] ?? '0') ?? 0.0;
    return Drink(
        name: json['name'] ?? 'Неизвестно',
        price: price,
        imagePath: json['imageUrl'] ?? Icons.error,
        id: json['id'],
        slug: json['category']?['slug']);
  }
}

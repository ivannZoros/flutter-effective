import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
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
}

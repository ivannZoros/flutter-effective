import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import '../src/features/menu/models/drink.dart';

class ApiService {
  Future<void> placeOrder(
      List<Drink> cartItems, String fcmToken, BuildContext context) async {
    final dio = Dio();

    final orderData = {
      "positions": {
        for (var item in cartItems) item.id: item.quantity,
      },
      "token": fcmToken,
    };
    print(orderData);

    try {
      final response = await dio.post(
        'https://coffeeshop.academy.effective.band/api/v1/orders',
        data: orderData,
      );

      if (response.statusCode == 201 || response.statusCode == 200) {
        cartItems.clear();
        Navigator.pop(context);
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Заказ создан')),
        );
      }
    } catch (error) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Возникла ошибка при заказе')),
      );
    }
  }
}

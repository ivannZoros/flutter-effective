import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import '../src/features/menu/models/drink.dart';

class ApiService {
  Future<void> placeOrder(
      List<Drink> cartItems, String fcmToken, BuildContext context) async {
    final dio = Dio();

    final orderData = {
      "positions": {
        for (var item in cartItems) item.name: item.quantity,
      },
      "token": fcmToken,
    };

    try {
      final response = await dio.post(
        'https://coffeeshop.academy.effective.band/api/v1/orders',
        data: orderData,
      );
      if (response.statusCode == 200) {
        cartItems.clear();
        Navigator.pop(context);
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Заказ оформлен успешно!')),
        );
      }
    } catch (error) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Ошибка при оформлении заказа')),
      );
    }
  }
}

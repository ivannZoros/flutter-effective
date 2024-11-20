import 'package:empty_project/src/features/menu/models/drink.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../../api/api_service.dart';

part 'order_event.dart';
part 'order_state.dart';

class OrderBloc extends Bloc<OrderEvent, OrderState> {
  final ApiService _apiService;

  OrderBloc(this._apiService) : super(OrderInitial()) {
    on<PlaceOrderEvent>((event, emit) async {
      emit(OrderLoading());
      try {
        await _apiService.placeOrder(
            event.cartItems, event.fcmToken, event.context);
        emit(OrderLoaded());
      } catch (error) {
        emit(const OrderError("Error"));
      }
    });
  }
}

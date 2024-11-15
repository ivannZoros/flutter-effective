import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'api/api_service.dart';
import 'src/app.dart';
import 'src/features/menu/block/order_bloc.dart';

void main() {
  runApp(MultiBlocProvider(providers: [
    BlocProvider(
      create: (context) => OrderBloc(apiService: ApiService()),
    ),
  ], child: const CoffeeShopApp()));
}

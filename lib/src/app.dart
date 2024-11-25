import 'package:dio/dio.dart';
import 'package:empty_project/api/api_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'features/menu/bloc/drinks_list_bloc.dart';
import 'features/menu/data/data_source/drink_data_source.dart';
import 'features/menu/data/database/app_db.dart';
import 'features/menu/data/database/drink_repository.dart';
import 'features/menu/menu_screen.dart';

class CoffeeShopApp extends StatelessWidget {
  const CoffeeShopApp({super.key});

  @override
  Widget build(BuildContext context) {
    final dio = Dio();
    final appDb = AppDb();
    final apiService = ApiService(dio);
    final drinkDataSource = DrinkDataSource(dio);
    final drinkRepository = DrinkRepository(drinkDataSource, appDb);

    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider.value(value: drinkRepository),
        RepositoryProvider.value(value: apiService),
      ],
      child: MaterialApp(
        home: BlocProvider<DrinksListBloc>(
          create: (context) => DrinksListBloc(drinkRepository),
          child: const MenuScreen(),
        ),
      ),
    );
  }
}

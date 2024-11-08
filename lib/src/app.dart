import 'package:flutter/material.dart';

import 'features/menu/menu_screen.dart';
import 'theme/app_colors.dart';

class CoffeeShopApp extends StatelessWidget {
  const CoffeeShopApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: AppColors.white,
      ),
      home: const MenuScreen(),
    );
  }
}

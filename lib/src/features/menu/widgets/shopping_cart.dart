import 'package:empty_project/src/theme/app_colors.dart';
import 'package:flutter/material.dart';

class ShoppingCart extends StatefulWidget {
  final double totalCost;
  final VoidCallback onPressed;

  const ShoppingCart(
      {super.key, required this.totalCost, required this.onPressed});

  @override
  _ShoppingCartState createState() => _ShoppingCartState();
}

class _ShoppingCartState extends State<ShoppingCart> {
  @override
  Widget build(BuildContext context) {
    return FloatingActionButton.extended(
      onPressed: widget.onPressed,
      icon: Image.asset(
        'assets/ShoppingCart.png',
      ),
      label: Text(
        "${widget.totalCost} ₽",
        style: const TextStyle(color: AppColors.white),
      ),
      backgroundColor: AppColors.blue,
    );
  }
}

import 'package:flutter/material.dart';

import '../../../theme/app_colors.dart';
import '../models/drink.dart';
import 'active_button.dart';

class CoffeeCard extends StatefulWidget {
  final Drink drink;
  final VoidCallback onAddToCart;
  final Function(int) plusCup;
  final Function(int) minusCup;
  const CoffeeCard(
      {super.key,
      required this.drink,
      required this.onAddToCart,
      required this.plusCup,
      required this.minusCup});

  @override
  State<CoffeeCard> createState() => _CoffeeCardState();
}

class _CoffeeCardState extends State<CoffeeCard> {
  bool _isButtonPressed = false;

  void _handleRemove() {
    setState(() {
      _isButtonPressed = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const SizedBox(
            height: 10,
          ),
          Image.asset(
            widget.drink.imagePath,
            height: 100,
            fit: BoxFit.contain,
          ),
          const Padding(
            padding: EdgeInsets.symmetric(vertical: 5),
          ),
          Text(widget.drink.name),
          const Padding(
            padding: EdgeInsets.symmetric(vertical: 5),
          ),
          if (_isButtonPressed)
            ActiveButton(
              onRemove: _handleRemove,
              plusCup: (quantity) => widget.plusCup(quantity),
              minusCup: (quantity) => widget.minusCup(quantity),
            )
          else
            ElevatedButton(
              onPressed: () {
                setState(() {
                  _isButtonPressed = true;
                });
                widget.onAddToCart();
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.blue,
                foregroundColor: AppColors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                padding: const EdgeInsets.symmetric(
                  vertical: 12,
                  horizontal: 16,
                ),
              ),
              child: Text("${widget.drink.price} р"),
            ),
        ],
      ),
    );
  }
}

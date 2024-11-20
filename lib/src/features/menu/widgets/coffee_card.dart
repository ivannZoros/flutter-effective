import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../theme/app_colors.dart';
import '../bloc/drinks_list_bloc.dart';
import '../models/drink.dart';
import 'active_button.dart';

class CoffeeCard extends StatelessWidget {
  final Drink drink;
  final VoidCallback onAddToCart;

  const CoffeeCard({
    super.key,
    required this.drink,
    required this.onAddToCart,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<DrinksListBloc, DrinksListState>(
      builder: (context, state) {
        final updatedDrink = state is DrinksListLoaded
            ? state.drinks
                .firstWhere((d) => d.id == drink.id, orElse: () => drink)
            : drink;

        return Container(
          key: ValueKey(updatedDrink.id),
          decoration: BoxDecoration(
            color: AppColors.white,
            borderRadius: BorderRadius.circular(16),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const SizedBox(height: 10),
              Image.network(
                drink.imagePath,
                height: 100,
                fit: BoxFit.contain,
              ),
              const SizedBox(height: 5),
              Text(drink.name),
              const SizedBox(height: 5),
              if (drink.quantity > 0)
                ActiveButton(
                  drink: drink,
                )
              else
                ElevatedButton(
                  onPressed: drink.quantity == 0 ? onAddToCart : null,
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
                  child: Text("${updatedDrink.price} р"),
                ),
            ],
          ),
        );
      },
    );
  }
}

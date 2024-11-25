import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../theme/app_colors.dart';
import '../bloc/drinks_list_bloc.dart';
import '../models/drink.dart';

class ActiveButton extends StatelessWidget {
  final Drink drink;

  const ActiveButton({
    super.key,
    required this.drink,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<DrinksListBloc, DrinksListState>(
      builder: (context, state) {
        if (state is DrinksListLoaded) {
          final updatedDrink = state.drinks.firstWhere(
            (item) => item.id == drink.id,
            orElse: () => drink,
          );
          return Padding(
            key: ValueKey(updatedDrink.quantity),
            padding: const EdgeInsets.all(12.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  height: 24,
                  width: 24,
                  child: ElevatedButton(
                    onPressed: () {
                      context
                          .read<DrinksListBloc>()
                          .add(RemoveFromCart(updatedDrink));
                    },
                    style: ElevatedButton.styleFrom(
                      padding: EdgeInsets.zero,
                      backgroundColor: AppColors.blue,
                      foregroundColor: AppColors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    child: const Center(
                      child: Text(
                        "-",
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8),
                  child: SizedBox(
                    height: 24,
                    child: ElevatedButton(
                      onPressed: () {},
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.blue,
                        foregroundColor: AppColors.white,
                      ),
                      child: Text(
                        updatedDrink.quantity.toString(),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 24,
                  width: 24,
                  child: ElevatedButton(
                    onPressed: () {
                      context
                          .read<DrinksListBloc>()
                          .add(AddToCart(updatedDrink));
                    },
                    style: ElevatedButton.styleFrom(
                      padding: EdgeInsets.zero,
                      backgroundColor: AppColors.blue,
                      foregroundColor: AppColors.white,
                    ),
                    child: const Center(
                      child: Text(
                        "+",
                        style: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          );
        }

        return const SizedBox.shrink();
      },
    );
  }
}

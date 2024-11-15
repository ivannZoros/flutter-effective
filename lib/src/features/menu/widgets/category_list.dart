import 'package:flutter/material.dart';

import '../../../theme/app_colors.dart';

class CategoryList extends StatelessWidget {
  final int selectedIndex;
  final Function(int) onCategorySelected;

  const CategoryList({
    super.key,
    required this.selectedIndex,
    required this.onCategorySelected,
  });

  @override
  Widget build(BuildContext context) {
    final List<String> choiceChipLabels = [
      'Черный кофе',
      'Кофе с молоком',
      'Чай',
      'Авторские напитки',
    ];

    return SizedBox(
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: choiceChipLabels.length,
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.only(left: 8.0),
            child: ChoiceChip(
              label: Text(
                choiceChipLabels[index],
                style: const TextStyle(
                  color: AppColors.black,
                  fontSize: 14,
                ),
              ),
              selected: selectedIndex == index,
              onSelected: (bool value) {
                if (value) {
                  onCategorySelected(index);
                }
              },
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              selectedColor: AppColors.blue,
              backgroundColor: AppColors.white,
            ),
          );
        },
      ),
    );
  }
}

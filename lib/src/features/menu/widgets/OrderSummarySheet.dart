import 'package:empty_project/src/features/menu/models/Drink.dart';
import 'package:empty_project/src/theme/app_colors.dart';
import 'package:flutter/material.dart';

class OrderSummarySheet extends StatelessWidget {
  final List<Drink> cartItems;
  final VoidCallback onClose;

  const OrderSummarySheet(
      {super.key, required this.cartItems, required this.onClose});

  @override
  Widget build(BuildContext context) {
    double totalCost =
        cartItems.fold(0, (sum, item) => sum + (item.price * item.quantity));

    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Row(
              children: [
                const Text(
                  'Ваш заказ',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: AppColors.black,
                    fontSize: 24,
                  ),
                ),
                IconButton(
                    onPressed: () {}, icon: Image.asset('assets/delete.png'))
              ],
            ),
            const Divider(),
            Expanded(
              child: ListView.builder(
                itemCount: cartItems.length,
                itemBuilder: (context, index) {
                  final item = cartItems[index];
                  return Row(
                    children: [Image.asset(item.imagePath), Text(item.name)],
                  );
                },
              ),
            ),
            ElevatedButton(
                onPressed: () {}, child: const Text("Оформить заказ")),
          ],
        ),
      ),
    );
  }
}

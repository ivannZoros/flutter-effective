import 'package:empty_project/src/features/menu/models/drink.dart';
import 'package:empty_project/src/theme/app_colors.dart';
import 'package:flutter/material.dart';

class OrderSummarySheet extends StatelessWidget {
  final List<Drink> cartItems;
  final VoidCallback onClose;

  const OrderSummarySheet(
      {super.key, required this.cartItems, required this.onClose});

  @override
  Widget build(BuildContext context) {
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
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                    onPressed: () {
                      onClose();
                      cartItems.clear();
                    },
                    icon: Image.asset('assets/delete.png'))
              ],
            ),
            const Divider(),
            Expanded(
              child: ListView.builder(
                itemCount: cartItems.length,
                itemBuilder: (context, index) {
                  final item = cartItems[index];
                  return Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          Image.asset(
                            item.imagePath,
                            height: 55,
                            width: 55,
                          ),
                          const SizedBox(width: 10),
                          Text(
                            item.name,
                            style: const TextStyle(fontSize: 16),
                          ),
                        ],
                      ),
                      Text(
                        "${item.price} ₽",
                      ),
                    ],
                  );
                },
              ),
            ),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {},
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.blue,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16)),
                ),
                child: const Padding(
                  padding: EdgeInsets.all(16.0),
                  child: Text(
                    "Оформить заказ",
                    style: TextStyle(fontSize: 20, color: AppColors.white),
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

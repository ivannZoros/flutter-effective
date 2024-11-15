import 'package:empty_project/src/features/menu/models/drink.dart';
import 'package:empty_project/src/theme/app_colors.dart';
import 'package:empty_project/src/theme/image_sources.dart';
import 'package:empty_project/src/theme/text_sources.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../block/order_bloc.dart';

class OrderSummarySheet extends StatelessWidget {
  final List<Drink> cartItems;
  final VoidCallback onClose;
  final VoidCallback onClearCart;

  const OrderSummarySheet({
    super.key,
    required this.cartItems,
    required this.onClose,
    required this.onClearCart,
  });

  List<Drink> _generateCartItemsList(List<Drink> cartItems) {
    List<Drink> expandedList = [];
    for (var item in cartItems) {
      for (int i = 0; i < item.quantity; i++) {
        expandedList.add(item);
      }
    }
    return expandedList;
  }

  @override
  Widget build(BuildContext context) {
    List<Drink> expandedCartItems = _generateCartItemsList(cartItems);
    return Scaffold(
      body: BlocListener<OrderBloc, OrderState>(
        listener: (context, state) {
          if (state is OrderLoading) {
            showDialog(
              context: context,
              barrierDismissible: false,
              builder: (_) => const Center(child: CircularProgressIndicator()),
            );
          } else if (state is OrderLoaded) {
            Navigator.pop(context);
            ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
              content: Text(TextSources.orderPlaced),
            ));
          } else if (state is OrderError) {
            Navigator.pop(context);
            ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text(TextSources.errorDuringOrder)));
          }
        },
        child: DecoratedBox(
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
                      TextSources.yourOrder,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: AppColors.black,
                        fontSize: 24,
                      ),
                    ),
                    IconButton(
                        onPressed: () {
                          onClose();
                          onClearCart();
                        },
                        icon: Image.asset(ImageSources.imgDelete))
                  ],
                ),
                const Divider(),
                Expanded(
                  child: ListView.builder(
                    itemCount: expandedCartItems.length,
                    itemBuilder: (context, index) {
                      final item = expandedCartItems[index];
                      return Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              Image.network(
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
                            style: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      );
                    },
                  ),
                ),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () {
                      const fcmToken = "<FCM Registration Token>";
                      context.read<OrderBloc>().add(
                            PlaceOrderEvent(
                                cartItems: cartItems,
                                fcmToken: fcmToken,
                                context: context),
                          );
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.blue,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16)),
                    ),
                    child: const Padding(
                      padding: EdgeInsets.all(16.0),
                      child: Text(
                        TextSources.placeOrder,
                        style: TextStyle(fontSize: 20, color: AppColors.white),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

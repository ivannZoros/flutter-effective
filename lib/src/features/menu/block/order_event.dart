part of 'order_bloc.dart';

class OrderEvent extends Equatable {
  const OrderEvent();

  @override
  List<Object> get props => [];
}

class PlaceOrderEvent extends OrderEvent {
  const PlaceOrderEvent(
      {required this.cartItems, required this.fcmToken, required this.context});

  final List<Drink> cartItems;
  final String fcmToken;
  final BuildContext context;

  @override
  List<Object> get props => [cartItems, fcmToken];
}

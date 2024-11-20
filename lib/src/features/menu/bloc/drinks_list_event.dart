part of 'drinks_list_bloc.dart';

class DrinksListEvent extends Equatable {
  const DrinksListEvent();

  @override
  List<Object> get props => [];
}

class LoadDrinksList extends DrinksListEvent {}

class AddToCart extends DrinksListEvent {
  final Drink drink;

  const AddToCart(this.drink);

  @override
  List<Object> get props => [drink];
}

class RemoveFromCart extends DrinksListEvent {
  final Drink drink;

  const RemoveFromCart(this.drink);

  @override
  List<Object> get props => [drink];
}

class ClearCart extends DrinksListEvent {}

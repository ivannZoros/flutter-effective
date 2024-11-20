part of 'drinks_list_bloc.dart';

sealed class DrinksListState extends Equatable {
  const DrinksListState();

  @override
  List<Object> get props => [];
}

class DrinksListInitial extends DrinksListState {}

class DrinksListLoading extends DrinksListState {}

class DrinksListLoaded extends DrinksListState {
  final List<Drink> drinks;
  final List<Section> sections;
  final List<Drink> cartItems;
  final double totalCost;

  const DrinksListLoaded({
    required this.totalCost,
    required this.drinks,
    required this.sections,
    required this.cartItems,
  });

  DrinksListLoaded copyWith({
    List<Drink>? drinks,
    List<Section>? sections,
    List<Drink>? cartItems,
    double? totalCost,
  }) {
    return DrinksListLoaded(
      totalCost: totalCost ?? this.totalCost,
      drinks: drinks ?? this.drinks,
      sections: sections ?? this.sections,
      cartItems: cartItems ?? this.cartItems,
    );
  }

  @override
  List<Object> get props => [drinks, sections, cartItems, totalCost];
}

class DrinksListError extends DrinksListState {
  final String message;

  const DrinksListError(this.message);

  @override
  List<Object> get props => [message];
}

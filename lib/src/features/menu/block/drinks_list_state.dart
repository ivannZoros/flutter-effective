part of 'drinks_list_bloc.dart';

class DrinksListState {}

class DrinksListInitial extends DrinksListState {}

class DrinksListLoading extends DrinksListState {}

class DrinksListLoaded extends DrinksListState {
  final List<Drink> drinks;

  DrinksListLoaded(this.drinks);
}

class DrinksListError extends DrinksListState {
  final String message;

  DrinksListError(this.message);
}

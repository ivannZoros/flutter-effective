import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../data/database/drink_repository.dart';
import '../models/drink.dart';
import '../models/section.dart';

part 'drinks_list_event.dart';
part 'drinks_list_state.dart';

class DrinksListBloc extends Bloc<DrinksListEvent, DrinksListState> {
  final DrinkRepository _drinkRepository;

  DrinksListBloc(this._drinkRepository) : super(DrinksListInitial()) {
    on<LoadDrinksList>((event, emit) async {
      emit(DrinksListLoading());

      try {
        final drinks = await _drinkRepository.getDrinks(0, 24);
        final sections = await _createSections(drinks);
        double calculatedTotalCost = 0;
        if (state is DrinksListLoaded) {
          final currentState = state as DrinksListLoaded;
          for (var drink in currentState.cartItems) {
            calculatedTotalCost += drink.price * drink.quantity;
          }
        }
        emit(DrinksListLoaded(
          drinks: drinks,
          sections: sections,
          cartItems: [],
          totalCost: calculatedTotalCost,
        ));
      } catch (error) {
        emit(DrinksListError(error.toString()));
      }
    });

    on<AddToCart>((event, emit) {
      if (state is DrinksListLoaded) {
        final currentState = state as DrinksListLoaded;
        final updatedDrinks = currentState.drinks.map((drink) {
          if (drink.id == event.drink.id) {
            final newQuantity = drink.quantity + 1;
            return drink.copyWith(
                quantity: newQuantity <= 10 ? newQuantity : 10);
          }
          return drink;
        }).toList();

        final updatedCartItems = [...currentState.cartItems];
        final cartItemIndex =
            updatedCartItems.indexWhere((d) => d.id == event.drink.id);

        if (cartItemIndex == -1) {
          updatedCartItems.add(event.drink.copyWith(quantity: 1));
        } else {
          updatedCartItems[cartItemIndex] = updatedCartItems[cartItemIndex]
              .copyWith(quantity: updatedCartItems[cartItemIndex].quantity + 1);
        }
        emit(currentState.copyWith(
            drinks: updatedDrinks, cartItems: updatedCartItems));
      }
    });

    on<RemoveFromCart>((event, emit) {
      if (state is DrinksListLoaded) {
        final currentState = state as DrinksListLoaded;
        final updatedCartItems = [...currentState.cartItems];
        final cartItemIndex =
            updatedCartItems.indexWhere((d) => d.id == event.drink.id);

        if (cartItemIndex != -1) {
          final updatedDrinkInCart = updatedCartItems[cartItemIndex]
              .copyWith(quantity: updatedCartItems[cartItemIndex].quantity - 1);

          if (updatedDrinkInCart.quantity == 0) {
            updatedCartItems.removeAt(cartItemIndex);
          } else {
            updatedCartItems[cartItemIndex] = updatedDrinkInCart;
          }
        }

        final updatedDrinks = currentState.drinks.map((drink) {
          if (drink.id == event.drink.id) {
            return drink.copyWith(
                quantity: drink.quantity > 0 ? drink.quantity - 1 : 0);
          }
          return drink;
        }).toList();

        emit(currentState.copyWith(
          drinks: updatedDrinks,
          cartItems: updatedCartItems,
        ));
      }
    });

    on<ClearCart>((event, emit) {
      if (state is DrinksListLoaded) {
        final currentState = state as DrinksListLoaded;
        for (var drink in currentState.drinks) {
          drink.quantity = 0;
        }
        emit(currentState.copyWith(cartItems: []));
      }
    });

    on<OrderPlaced>((event, emit) {
      if (state is DrinksListLoaded) {
        final currentState = state as DrinksListLoaded;
        final updatedDrinks = currentState.drinks
            .map((drink) => drink.copyWith(quantity: 0))
            .toList();
        emit(currentState.copyWith(cartItems: [], drinks: updatedDrinks));
      }
    });
  }

  Future<List<Section>> _createSections(List<Drink> drinks) async {
    final Map<String, List<Drink>> drinksByCategory = {};

    for (final drink in drinks) {
      drinksByCategory.putIfAbsent(drink.slug, () => []).add(drink);
    }

    final sections = drinksByCategory.entries.map((entry) {
      return Section(title: entry.key, drinks: entry.value);
    }).toList();
    return sections;
  }
}

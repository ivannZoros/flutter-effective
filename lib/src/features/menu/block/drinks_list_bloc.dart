import 'package:empty_project/api/api_service.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../models/drink.dart';

part 'drinks_list_event.dart';
part 'drinks_list_state.dart';

class DrinksListBloc extends Bloc<DrinksListEvent, DrinksListState> {
  final ApiService apiService;

  DrinksListBloc({required this.apiService}) : super(DrinksListInitial()) {
    on<LoadDrinksList>((event, emit) async {
      emit(DrinksListLoading());
      try {
        final drinks = await ApiService().getDrinks();
        emit(DrinksListLoaded(drinks));
      } catch (error) {
        emit(DrinksListError("Cant parse drinks"));
      }
    });
  }
}

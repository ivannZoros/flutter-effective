import 'dart:developer';

import 'package:empty_project/api/api_service.dart';
import 'package:empty_project/src/features/menu/block/drinks_list_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../theme/app_colors.dart';
import 'models/drink.dart';
import 'models/section.dart';
import 'widgets/category_list.dart';
import 'widgets/coffee_card.dart';
import 'widgets/order_summary_sheet.dart';
import 'widgets/shopping_cart.dart';
import 'widgets/sticky_header_delegate.dart';

class MenuScreen extends StatefulWidget {
  const MenuScreen({super.key});

  @override
  State<MenuScreen> createState() => _MenuScreenState();
}

class _MenuScreenState extends State<MenuScreen> {
  final ScrollController _scrollController = ScrollController();
  int _currentCategoryIndex = 0;
  List<GlobalKey> _sectionKeys = [];
  List<Drink> cartItems = [];
  List<Section> _sections = [];

  Future<void> _loadDrinks() async {
    final drinks = await ApiService().getDrinks();

    setState(() {
      List<Drink> blackCoffeeDrinks =
          drinks.where((drink) => drink.slug == "Черный кофе").toList();
      List<Drink> milkCoffeeDrinks =
          drinks.where((drink) => drink.slug == "Кофе с молоком").toList();
      List<Drink> teaDrinks =
          drinks.where((drink) => drink.slug == "Чай").toList();
      List<Drink> authorDrinks = drinks
          .where((drink) =>
              drink.slug != "Чай" &&
              drink.slug != "Кофе с молоком" &&
              drink.slug != "Черный кофе")
          .toList();
      _sections = [
        Section(title: "Черный кофе", drinks: blackCoffeeDrinks),
        Section(title: "Кофе с молоком", drinks: milkCoffeeDrinks),
        Section(title: "Чай", drinks: teaDrinks),
        Section(title: "Авторские напитки", drinks: authorDrinks),
      ];
      _sectionKeys = List.generate(_sections.length, (_) => GlobalKey());
    });
  }

  double calculateTotalCost() {
    return cartItems.fold(0, (sum, item) => sum + item.price * item.quantity);
  }

  void _addToCart(Drink drink) {
    setState(() {
      if (drink.quantity > 0) {
        drink.quantity++;
      } else {
        drink.quantity = 1;
        cartItems.add(drink);
      }
    });
  }

  void _removeFromCart(Drink drink) {
    setState(() {
      if (drink.quantity > 1) {
        drink.quantity--;
      } else {
        drink.quantity = 0;
        cartItems.remove(drink);
      }
    });
  }

  void _clearCart() {
    setState(() {
      cartItems.clear();
    });
  }

  @override
  void initState() {
    super.initState();
    _loadDrinks();

    _scrollController.addListener(() {
      _updateActiveCategory();
    });
  }

  @override
  void dispose() {
    super.dispose();
    _scrollController.removeListener(() {
      _updateActiveCategory();
    });
    _scrollController.dispose();
  }

  void _updateActiveCategory() {
    int newActiveIndex = _currentCategoryIndex;

    for (int i = 0; i < _sectionKeys.length; i++) {
      final context = _sectionKeys[i].currentContext;

      if (context != null) {
        final RenderObject renderObject = context.findRenderObject()!;

        if (renderObject is RenderSliverToBoxAdapter) {
          final renderBox = renderObject.child;

          if (renderBox is RenderBox) {
            final position = renderBox.localToGlobal(Offset.zero).dy;

            if (position <= 80.0 + 1.0 && position >= -1.0) {
              newActiveIndex = i;
              break;
            }
          }
        }
      }
    }

    if (_currentCategoryIndex != newActiveIndex) {
      setState(() {
        if (newActiveIndex >= 0 && newActiveIndex < _sections.length) {
          _currentCategoryIndex = newActiveIndex;
        } else {
          _currentCategoryIndex = _sections.length - 1;
        }
      });
    }
  }

  void _scrollToCategory(int index) {
    final context = _sectionKeys[index].currentContext;
    if (context != null) {
      Scrollable.ensureVisible(
        context,
        duration: const Duration(milliseconds: 500),
        curve: Curves.easeInOut,
      );
      setState(() {
        _currentCategoryIndex = index;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          DrinksListBloc(apiService: ApiService())..add(LoadDrinksList()),
      child: Scaffold(
        backgroundColor: AppColors.milk,
        body: BlocBuilder<DrinksListBloc, DrinksListState>(
          builder: (context, state) {
            if (state is DrinksListLoading) {
              return const Center(child: CircularProgressIndicator());
            } else if (state is DrinksListLoaded) {
              _loadDrinks();
              return SafeArea(
                child: Stack(
                  children: [
                    CustomScrollView(
                      controller: _scrollController,
                      slivers: <Widget>[
                        SliverPersistentHeader(
                          delegate: StickyHeaderDelegate(
                            height: 80,
                            child: CategoryList(
                              selectedIndex: _currentCategoryIndex,
                              onCategorySelected: _scrollToCategory,
                            ),
                          ),
                          pinned: true,
                        ),
                        for (int i = 0; i < _sections.length; i++) ...[
                          SliverToBoxAdapter(
                            key: _sectionKeys[i],
                            child: Padding(
                              padding: const EdgeInsets.all(16.0),
                              child: Text(
                                _sections[i].title,
                                style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: AppColors.black,
                                  fontSize: 32,
                                ),
                              ),
                            ),
                          ),
                          SliverPadding(
                            padding: const EdgeInsets.symmetric(horizontal: 16),
                            sliver: SliverGrid(
                              gridDelegate:
                                  const SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 2,
                                mainAxisSpacing: 16,
                                crossAxisSpacing: 16,
                                childAspectRatio: 0.8,
                              ),
                              delegate: SliverChildBuilderDelegate(
                                (context, drinkIndex) {
                                  final drink = _sections[i].drinks[drinkIndex];
                                  return CoffeeCard(
                                    drink: drink,
                                    onAddToCart: () => _addToCart(drink),
                                    plusCup: (q) => _addToCart(drink),
                                    minusCup: (q) => _removeFromCart(drink),
                                  );
                                },
                                childCount: _sections[i].drinks.length,
                              ),
                            ),
                          ),
                        ],
                      ],
                    ),
                  ],
                ),
              );
            } else if (state is DrinksListError) {
              return Center(child: Text(state.message));
            }
            return const SizedBox.shrink();
          },
        ),
        floatingActionButton: cartItems.isNotEmpty
            ? ShoppingCart(
                totalCost: calculateTotalCost(),
                onPressed: () {
                  showModalBottomSheet<void>(
                    context: context,
                    isScrollControlled: true,
                    builder: (BuildContext context) {
                      return Material(
                        child: ConstrainedBox(
                          constraints: BoxConstraints(
                            maxHeight:
                                MediaQuery.of(context).size.height * 0.90,
                          ),
                          child: OrderSummarySheet(
                            cartItems: cartItems,
                            onClose: () {
                              Navigator.pop(context);
                              setState(() {});
                            },
                            onClearCart: _clearCart,
                          ),
                        ),
                      );
                    },
                  );
                },
              )
            : null,
      ),
    );
  }
}

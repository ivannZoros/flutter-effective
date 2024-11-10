import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

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

  final List<Section> _sections = [
    Section(title: "Черный кофе", drinks: drinks.sublist(0, 6)),
    Section(title: "Кофе с молоком", drinks: drinks.sublist(6, 12)),
    Section(title: "Чай", drinks: drinks.sublist(12, 18)),
    Section(title: "Авторские напитки", drinks: drinks.sublist(18, 24)),
  ];

  double calculateTotalCost() {
    return cartItems.fold(0, (sum, item) => sum + item.price * item.quantity);
  }

  void _addToCart(Drink drink) {
    setState(() {
      bool found = false;
      for (var item in cartItems) {
        if (item.id == drink.id) {
          item.quantity++;
          found = true;
          break;
        }
      }
      if (!found) {
        drink.quantity = 1;
        cartItems.add(drink);
      }
    });
  }

  void _removeFromCart(Drink drink) {
    setState(() {
      for (var item in cartItems) {
        if (item.id == drink.id) {
          if (item.quantity > 0) {
            item.quantity--;
          } else {
            cartItems.remove(item);
          }
          break;
        }
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
    _sectionKeys = List.generate(_sections.length, (_) => GlobalKey());

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
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        backgroundColor: AppColors.milk,
        body: SafeArea(
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
                                minusCup: (q) => _removeFromCart(drink));
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

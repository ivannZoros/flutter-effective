import 'package:empty_project/src/features/menu/widgets/ShoppingCart.dart';
import 'src/features/menu/models/Section.dart';
import 'src/features/menu/widgets/CategoryList.dart';
import 'src/features/menu/widgets/OrderSummarySheet.dart';
import 'src/features/menu/widgets/StickyHeaderDelegate.dart';
import 'src/features/menu/widgets/CoffeeCard.dart';
import 'src/theme/app_colors.dart';
import 'package:flutter/material.dart';
import 'src/features/menu/models/Drink.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatefulWidget {
  const MainApp({super.key});

  @override
  State<StatefulWidget> createState() => _MainAppState();
}

class _MainAppState extends State<MainApp> {
  final ScrollController _scrollController = ScrollController();
  int _currentCategoryIndex = 0;
  final List<GlobalKey> _sectionKeys = List.generate(4, (_) => GlobalKey());
  List<Drink> cartItems = [];
  bool _isOrderSummaryVisible = false;

  final List<Section> _sections = [
    Section(title: "Черный кофе", drinks: drinks.sublist(0, 2)),
    Section(title: "Кофе с молоком", drinks: drinks.sublist(2, 4)),
    Section(title: "Чай", drinks: drinks.sublist(4, 6)),
    Section(title: "Авторские напитки", drinks: drinks.sublist(6, 8)),
  ];

  void _showOrderSummary() {
    setState(() {
      _isOrderSummaryVisible = true;
    });
  }

  void _hideOrderSummary() {
    setState(() {
      _isOrderSummaryVisible = false;
    });
  }

  double calculateTotalCost() {
    return cartItems.fold(0, (sum, item) => sum + item.price * item.quantity);
  }

  void _addToCart(Drink drink) {
    setState(() {
      cartItems.add(drink);
    });
  }

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_updateActiveCategory);
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  void _updateActiveCategory() {
    double currentPosition = _scrollController.position.pixels;
    int newActiveIndex = _currentCategoryIndex;

    for (int i = 0; i < _sectionKeys.length; i++) {
      final context = _sectionKeys[i].currentContext;
      if (context != null) {
        final renderObject = context.findRenderObject();
        if (renderObject is RenderBox) {
          final position = renderObject.localToGlobal(Offset.zero).dy;
          final sectionHeight = renderObject.size.height;

          if (position < currentPosition + MediaQuery.of(context).size.height &&
              position + sectionHeight > currentPosition) {
            newActiveIndex = i;
            break;
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
                                onAddToCart: () => _addToCart(drink));
                          },
                          childCount: _sections[i].drinks.length,
                        ),
                      ),
                    ),
                  ],
                ],
              ),
              Visibility(
                visible: _isOrderSummaryVisible,
                child: OrderSummarySheet(
                  cartItems: cartItems,
                  onClose: _hideOrderSummary,
                ),
              ),
            ],
          ),
        ),
        floatingActionButton: cartItems.isNotEmpty
            ? ShoppingCart(
                totalCost: calculateTotalCost(),
                onPressed: _showOrderSummary,
              )
            : null,
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../api/api_service.dart';
import '../../theme/app_colors.dart';
import 'bloc/drinks_list_bloc.dart';
import 'bloc/order_bloc.dart';
import 'models/section.dart';
import 'widgets/category_list.dart';
import 'widgets/coffee_card.dart';
import 'widgets/order_summary_sheet.dart';
import 'widgets/shopping_cart.dart';
import 'widgets/sticky_header_delegate.dart';

class MenuScreen extends StatefulWidget {
  const MenuScreen({
    super.key,
  });

  @override
  State<MenuScreen> createState() => _MenuScreenState();
}

class _MenuScreenState extends State<MenuScreen> {
  final ScrollController _scrollController = ScrollController();
  int _currentCategoryIndex = 0;
  List<GlobalKey> _sectionKeys = [];
  // List<Drink> cartItems = [];

  @override
  void initState() {
    super.initState();
    context.read<DrinksListBloc>().add(LoadDrinksList());

    _scrollController.addListener(() {
      //_updateActiveCategory();
    });
  }

  @override
  void dispose() {
    super.dispose();
    _scrollController.removeListener(() {
      //  _updateActiveCategory();
    });
    _scrollController.dispose();
  }

  void _updateActiveCategory(List<Section> sections) {
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
        if (newActiveIndex >= 0 && newActiveIndex < sections.length) {
          _currentCategoryIndex = newActiveIndex;
        } else {
          _currentCategoryIndex = sections.length - 1;
        }
      });
    }
  }

  void _scrollToCategory(int index, List<Section> sections) {
    if (index < _sectionKeys.length) {
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
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.milk,
      body: BlocBuilder<DrinksListBloc, DrinksListState>(
        builder: (context, state) {
          if (state is DrinksListLoading) {
            return const SizedBox.shrink();
          } else if (state is DrinksListError) {
            return Center(
              child: Text(
                state.message,
              ),
            );
          } else if (state is DrinksListLoaded) {
            final sections = state.sections;
            if (_sectionKeys.isEmpty ||
                _sectionKeys.length != sections.length) {
              _sectionKeys = List.generate(sections.length, (_) => GlobalKey());
            }

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
                            onCategorySelected: (index) {
                              _scrollToCategory(index, sections);
                            },
                          ),
                        ),
                        pinned: true,
                      ),
                      for (int i = 0; i < sections.length; i++) ...[
                        SliverToBoxAdapter(
                          key: _sectionKeys[i],
                          child: Padding(
                            padding: const EdgeInsets.all(16.0),
                            child: Text(
                              sections[i].title,
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
                                final drink = sections[i].drinks[drinkIndex];
                                return BlocBuilder<DrinksListBloc,
                                    DrinksListState>(builder: (context, state) {
                                  if (state is DrinksListLoaded) {
                                    final updatedDrink =
                                        state.drinks.firstWhere(
                                      (item) => item.id == drink.id,
                                      orElse: () => drink,
                                    );
                                    return CoffeeCard(
                                      drink: updatedDrink,
                                      onAddToCart: () {
                                        context
                                            .read<DrinksListBloc>()
                                            .add(AddToCart(updatedDrink));
                                      },
                                    );
                                  }
                                  return const SizedBox.shrink();
                                });
                              },
                              childCount: sections[i].drinks.length,
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
      floatingActionButton: BlocBuilder<DrinksListBloc, DrinksListState>(
        builder: (blocContext, state) {
          if (state is DrinksListLoaded && state.cartItems.isNotEmpty) {
            double totalCost = state.cartItems
                .fold(0, (sum, item) => sum + item.price * item.quantity);
            return ShoppingCart(
              totalCost: totalCost,
              onPressed: () {
                showModalBottomSheet<void>(
                  context: blocContext,
                  isScrollControlled: true,
                  builder: (BuildContext sheetContext) {
                    return MultiBlocProvider(
                      providers: [
                        BlocProvider<OrderBloc>(
                          create: (context) => OrderBloc(
                              RepositoryProvider.of<ApiService>(context)),
                        ),
                      ],
                      child: BlocProvider.value(
                        value: BlocProvider.of<DrinksListBloc>(blocContext),
                        child: Material(
                          child: ConstrainedBox(
                            constraints: BoxConstraints(
                              maxHeight:
                                  MediaQuery.of(context).size.height * 0.90,
                            ),
                            child: OrderSummarySheet(
                              cartItems: state.cartItems,
                              onClose: () {
                                Navigator.pop(context);
                              },
                              drinksListBloc:
                                  BlocProvider.of<DrinksListBloc>(context),
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                );
              },
            );
          }
          return const SizedBox.shrink();
        },
      ),
    );
  }
}

import 'package:flutter/material.dart';

void main() {
  runApp(const MainApp());
}

class Drink {
  final String name;
  final String price;
  final String imagePath;

  Drink({
    required this.name,
    required this.price,
    required this.imagePath,
  });
}
class ActiveButton extends StatefulWidget{
  const ActiveButton({super.key,required this.onRemove});
  final Function() onRemove;

  @override
  State<ActiveButton> createState() => _ActiveButtonState();

}

class _ActiveButtonState extends State<ActiveButton>{
  int _cupCounter = 1;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(12.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
            SizedBox(
              height: 24,
              width: 24,
              child: ElevatedButton(
                onPressed: () {
                  setState(() {
                    if(_cupCounter > 1) {
                    _cupCounter--;
                  } else{
                    widget.onRemove();
                  }
                  });
                  
                },
                style: ElevatedButton.styleFrom(
                  padding: EdgeInsets.zero,
                  backgroundColor: const Color.fromARGB(194, 15, 134, 189),
                  foregroundColor: const Color(0xFFE7F0F7),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12)
                  )
              ),
                child:const Center(
                  child: Text(
                    "-",
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),),
                )
              ),
            ),
          
          
            Padding(
              padding: const EdgeInsets.all(8),
              child: SizedBox(
              height: 24,
              child: ElevatedButton(
                onPressed: () { },
                style: ElevatedButton.styleFrom(
                  
                  backgroundColor: const Color.fromARGB(194, 15, 134, 189),
                  foregroundColor: const Color(0xFFE7F0F7),
                  
              ),
                child:Text(_cupCounter.toString(),textAlign: TextAlign.center,),
                ),
              ),
            ),
          
          SizedBox(
            height: 24,
            width: 24,
            child: ElevatedButton(
              onPressed: () {
                setState(() {
                  if(_cupCounter < 10){
                  _cupCounter++;
                }
                });
                
              },
              style: ElevatedButton.styleFrom(
                padding: EdgeInsets.zero,
                backgroundColor: const Color.fromARGB(194, 15, 134, 189),
                foregroundColor: const Color(0xFFE7F0F7),
                
            ),
              child: const Center(
                child: Text("+",style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold
                ),),
              ),
            ),
          ),
        ],
      ),
    );
  }

}
class CategoryList extends StatelessWidget {
  final int selectedIndex;
  final Function(int) onCategorySelected;

  const CategoryList({
    super.key,
    required this.selectedIndex,
    required this.onCategorySelected,
  });

  @override
  Widget build(BuildContext context) {
    final List<String> choiceChipLabels = [
      'Черный кофе',
      'Кофе с молоком',
      'Чай',
      'Авторские напитки',
    ];

    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: List.generate(
          choiceChipLabels.length,
          (int index) {
            return Padding(
              padding: const EdgeInsets.only(left: 8.0),
              child: ChoiceChip(
                label: Text(
                  choiceChipLabels[index],
                  style: const TextStyle(
                    color: Colors.black,
                    fontSize: 14,
                  ),
                ),
                selected: selectedIndex == index,
                onSelected: (bool value) {
                  if (value) {
                    onCategorySelected(index);
                  }
                },
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                selectedColor: const Color(0xFF85C3DE),
                backgroundColor: Colors.white,
              ),
            );
          },
        ),
      ),
    );
  }
}

class Section {
  final String title;
  final List<Drink> drinks;

  Section({required this.title, required this.drinks});
}

class MainApp extends StatefulWidget {
  const MainApp({super.key});

  @override
  State<StatefulWidget> createState() => _MainAppState();
}

class _MainAppState extends State<MainApp> {
  final ScrollController _scrollController = ScrollController();
  int _currentCategoryIndex = 0;

  final List<Section> _sections = [
    Section(title: "Черный кофе", drinks: drinks.sublist(0, 2)),
    Section(title: "Кофе с молоком", drinks: drinks.sublist(2, 4)),
    Section(title: "Чай", drinks: drinks.sublist(4, 6)),
    Section(title: "Авторские напитки", drinks: drinks.sublist(6, 8)),
  ];

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
    final scrollOffset = _scrollController.offset;
    final viewportHeight = _scrollController.position.viewportDimension;
    final itemHeight = viewportHeight / _sections.length;

    final newCategoryIndex = (scrollOffset / itemHeight).floor().clamp(0, _sections.length - 1);

    if (_scrollController.position.atEdge && _scrollController.position.pixels > 0) {
    if (_currentCategoryIndex != _sections.length - 1) {
      setState(() {
        _currentCategoryIndex = _sections.length - 1;
      });
    }
  } else if (_currentCategoryIndex != newCategoryIndex) {
    setState(() {
      _currentCategoryIndex = newCategoryIndex;
    });
    }
  }

  void _scrollToCategory(int index) {
    final offset = index * _scrollController.position.viewportDimension / _sections.length;
    _scrollController.animateTo(
      offset,
      duration: const Duration(milliseconds: 500),
      curve: Curves.easeInOut,
    );
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        backgroundColor: const Color(0xFFF7FAF8),
        body: SafeArea(
          child: CustomScrollView(
            controller: _scrollController,
            slivers: <Widget>[
              
              SliverPersistentHeader(
                delegate: StickyHeaderDelegate(
                  height: 80.0,
                  child: CategoryList(
                    selectedIndex: _currentCategoryIndex,
                    onCategorySelected: _scrollToCategory,
                  ),
                ),
                pinned: true,
              ),
              for (final section in _sections) ...[
                SliverToBoxAdapter(
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Text(
                      section.title,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                        fontSize: 32,
                      ),
                    ),
                  ),
                ),
                SliverPadding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  sliver: SliverGrid(
                    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      mainAxisSpacing: 16,
                      crossAxisSpacing: 16,
                      childAspectRatio: 0.8,
                    ),
                    delegate: SliverChildBuilderDelegate(
                      (context, drinkIndex) {
                        final drink = section.drinks[drinkIndex];
                        return _CoffeeCard(drink: drink);
                      },
                      childCount: section.drinks.length,
                    ),
                  ),
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }
}

 
class StickyHeaderDelegate extends SliverPersistentHeaderDelegate {
  final Widget child;
  final double height;

  StickyHeaderDelegate({
    required this.child,
    required this.height,
  });

  @override
  double get minExtent => height;

  @override
  double get maxExtent => height;

  @override
  Widget build(BuildContext context, double shrinkOffset, bool overlapsContent) {
    return Container(
      height: height,
      color: const Color(0xFFF7FAF8), 
      child: child,
    );
  }

  @override
  bool shouldRebuild(SliverPersistentHeaderDelegate oldDelegate) {
    return true;
  }
}


final List<Drink> drinks = [
  Drink(name: 'Эспрессо 1', price: '139р', imagePath: 'lib/src/img/blackcoffee1.png'),
  Drink(name: 'Эспрессо 2', price: '99р', imagePath: 'lib/src/img/blackcoffee.png'),
  Drink(name: 'Кофе с молоком 1', price: '299р', imagePath: 'lib/src/img/latte.png'),
  Drink(name: 'Кофе с молоком 2', price: '99р', imagePath: 'lib/src/img/milkcoffee.png'),
  Drink(name: 'Чай 1', price: '199р', imagePath: 'lib/src/img/tea.png'),
  Drink(name: 'Чай 2', price: '129р', imagePath: 'lib/src/img/milkcoffee.png'),
  Drink(name: 'Авторский 1', price: '329р', imagePath: 'lib/src/img/blackcoffee1.png'),
  Drink(name: 'Авторский 2', price: '229р', imagePath: 'lib/src/img/latte.png'),
];


class _CoffeeCard extends StatefulWidget {
  final Drink drink;
  const _CoffeeCard({required this.drink});
  
  @override
  State<_CoffeeCard> createState() => _CoffeeCardState();
}
  


class _CoffeeCardState extends State<_CoffeeCard>{
bool _isButtonPressed = false;

void _handleRemove(){
  setState(() {
    _isButtonPressed = false;
  });
}

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Padding(
            padding: EdgeInsets.symmetric(vertical: 8),
          ),
          Image.asset(
            widget.drink.imagePath,
            height: 100,
            fit: BoxFit.contain,
            
          ),
          const Padding(
            padding: EdgeInsets.symmetric(vertical: 5),
          ),
          Text(widget.drink.name),
          const Padding(
            padding: EdgeInsets.symmetric(vertical: 5),
          ),
          if (_isButtonPressed)
            ActiveButton(onRemove: _handleRemove)
            else
                ElevatedButton(
                  onPressed: () {
                     setState(() {
                  _isButtonPressed = true;
                });
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color.fromARGB(194, 15, 134, 189),
                    foregroundColor: const Color(0xFFE7F0F7),
                    
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    padding: const EdgeInsets.symmetric(
                      vertical: 12,
                      horizontal: 16,
                    ),
                  ),
                  child: Text(widget.drink.price),
                ),
        ],
      ),
    );
  }
  
 
}

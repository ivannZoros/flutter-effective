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

final List<Drink> drinks = [
  Drink(name: 'Эспрессо 1', price: '139р', imagePath: 'assets/blackcoffee.png'),
  Drink(name: 'Эспрессо 2', price: '99р', imagePath: 'assets/blackcoffee.png'),
  Drink(name: 'Кофе с молоком 1', price: '299р', imagePath: 'assets/latte.png'),
  Drink(
      name: 'Кофе с молоком 2',
      price: '99р',
      imagePath: 'assets/milkcoffee.png'),
  Drink(name: 'Чай 1', price: '199р', imagePath: 'assets/tea.png'),
  Drink(name: 'Чай 2', price: '129р', imagePath: 'assets/milkcoffee.png'),
  Drink(
      name: 'Авторский 1', price: '329р', imagePath: 'assets/blackcoffee1.png'),
  Drink(name: 'Авторский 2', price: '229р', imagePath: 'assets/latte.png'),
];

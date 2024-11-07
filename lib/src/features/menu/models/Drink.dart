class Drink {
  final String name;
  final int price;
  final String imagePath;
  int quantity;

  Drink({
    required this.name,
    required this.price,
    required this.imagePath,
    this.quantity = 1,
  });
}

final List<Drink> drinks = [
  Drink(
    name: 'Эспрессо 1',
    price: 139,
    imagePath: 'assets/blackcoffee.png',
  ),
  Drink(name: 'Эспрессо 2', price: 99, imagePath: 'assets/blackcoffee.png'),
  Drink(name: 'Кофе с молоком 1', price: 299, imagePath: 'assets/latte.png'),
  Drink(
      name: 'Кофе с молоком 2', price: 99, imagePath: 'assets/milkcoffee.png'),
  Drink(name: 'Чай 1', price: 199, imagePath: 'assets/tea.png'),
  Drink(name: 'Чай 2', price: 129, imagePath: 'assets/milkcoffee.png'),
  Drink(name: 'Авторский 1', price: 329, imagePath: 'assets/blackcoffee1.png'),
  Drink(name: 'Авторский 2', price: 229, imagePath: 'assets/latte.png'),
];

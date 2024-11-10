class Drink {
  final String name;
  final int price;
  final String imagePath;
  int quantity;
  int id;

  Drink({
    required this.name,
    required this.price,
    required this.imagePath,
    this.quantity = 0,
    required this.id,
  });
}

final List<Drink> drinks = [
  Drink(
    name: 'Эспрессо 1',
    price: 139,
    imagePath: 'assets/blackcoffee.png',
    id: 1,
  ),
  Drink(
      name: 'Эспрессо 2',
      price: 99,
      imagePath: 'assets/blackcoffee.png',
      id: 2),
  Drink(
    name: 'Эспрессо 3',
    price: 139,
    imagePath: 'assets/blackcoffee.png',
    id: 3,
  ),
  Drink(
      name: 'Эспрессо 4',
      price: 99,
      imagePath: 'assets/blackcoffee.png',
      id: 4),
  Drink(
    name: 'Эспрессо 5',
    price: 139,
    imagePath: 'assets/blackcoffee.png',
    id: 5,
  ),
  Drink(
      name: 'Эспрессо 6',
      price: 99,
      imagePath: 'assets/blackcoffee.png',
      id: 6),
  Drink(
      name: 'Кофе с молоком 1',
      price: 299,
      imagePath: 'assets/latte.png',
      id: 7),
  Drink(
      name: 'Кофе с молоком 2',
      price: 99,
      imagePath: 'assets/milkcoffee.png',
      id: 8),
  Drink(
      name: 'Кофе с молоком 3',
      price: 299,
      imagePath: 'assets/latte.png',
      id: 9),
  Drink(
      name: 'Кофе с молоком 4',
      price: 99,
      imagePath: 'assets/milkcoffee.png',
      id: 10),
  Drink(
      name: 'Кофе с молоком 5',
      price: 299,
      imagePath: 'assets/latte.png',
      id: 11),
  Drink(
      name: 'Кофе с молоком 6',
      price: 99,
      imagePath: 'assets/milkcoffee.png',
      id: 12),
  Drink(name: 'Чай 1', price: 199, imagePath: 'assets/tea.png', id: 13),
  Drink(name: 'Чай 2', price: 129, imagePath: 'assets/milkcoffee.png', id: 14),
  Drink(name: 'Чай 3', price: 199, imagePath: 'assets/tea.png', id: 15),
  Drink(name: 'Чай 4', price: 129, imagePath: 'assets/milkcoffee.png', id: 16),
  Drink(name: 'Чай 5', price: 199, imagePath: 'assets/tea.png', id: 17),
  Drink(name: 'Чай 6', price: 129, imagePath: 'assets/milkcoffee.png', id: 18),
  Drink(
      name: 'Авторский 1',
      price: 329,
      imagePath: 'assets/blackcoffee1.png',
      id: 19),
  Drink(name: 'Авторский 2', price: 229, imagePath: 'assets/latte.png', id: 20),
  Drink(
      name: 'Авторский 3',
      price: 329,
      imagePath: 'assets/blackcoffee1.png',
      id: 21),
  Drink(name: 'Авторский 4', price: 229, imagePath: 'assets/latte.png', id: 22),
  Drink(
      name: 'Авторский 5',
      price: 329,
      imagePath: 'assets/blackcoffee1.png',
      id: 23),
  Drink(name: 'Авторский 6', price: 229, imagePath: 'assets/latte.png', id: 24),
];

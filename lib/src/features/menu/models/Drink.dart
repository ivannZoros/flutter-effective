class Drink {
  String name;
  double price;
  String imagePath;
  int quantity;
  int id;
  String slug;

  Drink({
    required this.name,
    required this.price,
    required this.imagePath,
    this.quantity = 0,
    required this.id,
    required this.slug,
  });
}

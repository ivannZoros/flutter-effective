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
  Drink copyWith({
    String? name,
    double? price,
    String? imagePath,
    int? id,
    String? slug,
    int? quantity,
  }) {
    return Drink(
      name: name ?? this.name,
      price: price ?? this.price,
      imagePath: imagePath ?? this.imagePath,
      id: id ?? this.id,
      slug: slug ?? this.slug,
      quantity: quantity ?? this.quantity,
    );
  }
}

class Product {
  final int id;
  final String productName;
  final int price;
  final String description;
  Product({
    required this.id,
    required this.productName,
    required this.price,
    required this.description,
  });

  factory Product.fromJson(Map<String, dynamic> map) {
    return Product(
      id: map['id'] as int,
      productName: map['product_name'] as String,
      price: map['price'] as int,
      description: map['description'] as String,
    );
  }
}


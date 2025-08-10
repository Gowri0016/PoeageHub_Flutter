// Data structure for a product

class Product {
  final String id;
  final String name;
  final String imageUrl;
  final String description;
  final double price;
  final bool isFeatured;
  final String? brand;
  final String? categoryId;
  final bool inStock;

  Product({
    required this.id,
    required this.name,
    required this.imageUrl,
    required this.description,
    required this.price,
    this.isFeatured = false,
    this.brand,
    this.categoryId,
    this.inStock = true,
  });
}

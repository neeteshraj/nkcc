class Product {
  final String productTypeId;
  final String name;
  final String slug;
  final String brand;
  final String model;
  final String category;
  final String description;
  final double price;
  final int stock;
  final double rating;
  final String thumbnail;

  Product({
    required this.productTypeId,
    required this.name,
    required this.slug,
    required this.brand,
    required this.model,
    required this.category,
    required this.description,
    required this.price,
    required this.stock,
    required this.rating,
    required this.thumbnail,
  });

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      productTypeId: json['productTypeId'],
      name: json['name'],
      slug: json['slug'],
      brand: json['brand'],
      model: json['model'],
      category: json['category'],
      description: json['description'],
      price: json['price'],
      stock: json['stock'],
      rating: json['rating'],
      thumbnail: json['thumbnail'],
    );
  }
}

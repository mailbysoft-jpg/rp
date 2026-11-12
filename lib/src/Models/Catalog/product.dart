class Product {
  final String id;
  final String name;
  final String category;
  final double? price;
  final String? imageUrl;

  Product({
    required this.id,
    required this.name,
    required this.category,
    this.price,
    this.imageUrl,
  });
}

const List<String> categories = [
  "All",
  "Necklace",
  "Rings",
  "Bangles",
  "Earrings",
];

final List<Product> products = [
  Product(
    id: "1",
    name: "Royal Gold Necklace",
    category: "Necklace",
    price: 24500,
    imageUrl: "assets/images/banner2.png",
  ),
  Product(
    id: "2",
    name: "Classic Diamond Ring",
    category: "Rings",
    price: 18500,
  ),
  Product(
    id: "3",
    name: "Elegant Gold Bangles",
    category: "Bangles",
    price: 32000,
  ),
  Product(
    id: "4",
    name: "Traditional Gold Earrings",
    category: "Earrings",
    price: 15500,
  ),
  Product(
    id: "5",
    name: "Premium Bridal Necklace",
    category: "Necklace",
    price: 45000,
  ),
  Product(id: "6", name: "Modern Gold Ring", category: "Rings", price: 12500),
];

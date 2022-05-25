import 'dart:convert';

class Product {
  Product(
      {required this.count,
      required this.name,
      required this.price,
      required this.image});

  int count;
  String name;
  int price;
  String image;

  factory Product.fromJson(String str) => Product.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Product.fromMap(Map<String, dynamic> json) => Product(
      count: json["count"],
      name: json["name"],
      price: json["price"],
      image: json["image"]);

  Map<String, dynamic> toMap() =>
      {"count": count, "name": name, "price": price, "image": image};

  @override
  String toString() {
    // TODO: implement toString
    return '$name, $count, $price, $image';
  }
}

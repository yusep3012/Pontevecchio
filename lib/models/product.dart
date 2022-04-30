// To parse this JSON data, do
//
//     final product = productFromMap(jsonString);

import 'dart:convert';

class Product {
  Product(
      {required this.id,
      required this.name,
      required this.price,
      required this.image});

  String id;
  int name;
  int price;
  String image;

  factory Product.fromJson(String str) => Product.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Product.fromMap(Map<String, dynamic> json) => Product(
      id: json["id"],
      name: json["name"],
      price: json["price"],
      image: json["image"]);

  Map<String, dynamic> toMap() =>
      {"id": id, "name": name, "price": price, "image": image};
}

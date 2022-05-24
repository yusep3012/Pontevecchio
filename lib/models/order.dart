import 'dart:convert';

import 'package:pontevecchio/models/models.dart';

// To parse this JSON data, do
//
//     final order = orderFromMap(jsonString);

class Order {
  Order({
    required this.id,
    required this.table,
    // required this.waiter,
    required this.products,
  });

  String id;
  int table;
  // String waiter;
  List<Product> products;

  factory Order.fromJson(String str) => Order.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Order.fromMap(Map<String, dynamic> json) => Order(
        id: json["id"],
        table: json["table"],
        // waiter: json["waiter"],
        products:
            List<Product>.from(json["products"].map((x) => Product.fromMap(x))),
      );

  Map<String, dynamic> toMap() => {
        "id": id,
        "table": table,
        // "waiter": waiter,
        "products": List<dynamic>.from(products.map((x) => x.toMap())),
      };

  @override
  String toString() {
    // TODO: implement toString
    return '$products';
  }
}

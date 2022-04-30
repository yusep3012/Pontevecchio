import 'dart:convert';

import 'package:pontevecchio/models/models.dart';

class User {
  User(
      {required this.id,
      required this.table,
      required this.waiter,
      required this.products});

  String id;
  String table;
  String waiter;
  List<Product> products;

  factory User.fromJson(String str) => User.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory User.fromMap(Map<String, dynamic> json) => User(
        id: json["id"],
        table: json["table"],
        waiter: json["waiter"],
        products:
            List<Product>.from(json["products"].map((x) => Product.fromMap(x))),
      );

  Map<String, dynamic> toMap() => {
        "id": id,
        "table": table,
        "waiter": waiter,
        "products": List<dynamic>.from(products.map((x) => x.toMap())),
      };
}

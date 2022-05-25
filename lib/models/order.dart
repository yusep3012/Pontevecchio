import 'dart:convert';

import 'package:pontevecchio/models/models.dart';

// To parse this JSON data, do
//
//     final order = orderFromMap(jsonString);

class Order {
  Order({
    required this.id,
    required this.table,
    required this.waiter,
    required this.products,
    required this.busy,
    required this.paidOut,
  });

  String id;
  String table;
  String waiter;
  bool paidOut;
  bool busy;
  List<Product> products;

  factory Order.fromJson(String str) => Order.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Order.fromMap(Map<String, dynamic> json) => Order(
        id: json["id"],
        table: json["table"],
        waiter: json["waiter"],
        busy: json["busy"],
        paidOut: json["paidOut"],
        products:
            List<Product>.from(json["products"].map((x) => Product.fromMap(x))),
      );

  Map<String, dynamic> toMap() => {
        "id": id,
        "table": table,
        "waiter": waiter,
        "busy": busy,
        "paidOut": paidOut,
        "products": List<dynamic>.from(products.map((x) => x.toMap())),
      };

  @override
  String toString() {
    return 'Mesa: $table, $id ,$products, $waiter, Ocupado: $busy, Pagado: $paidOut';
  }
}

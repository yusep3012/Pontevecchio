import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';

// Widgets
import 'package:pontevecchio/widgets/widgets.dart';

class OrderButton extends StatelessWidget {
  const OrderButton({
    Key? key,
    required this.price,
    required this.numberTable,
    required this.message,
    required this.text,
    required this.payBotton,
  }) : super(key: key);

  final int price;
  final int numberTable;
  final String message;
  final String text;
  final bool payBotton;

  @override
  Widget build(BuildContext context) {
    var uuid = const Uuid();
    var db = FirebaseFirestore.instance;

    return ElevatedButton(
        style: ElevatedButton.styleFrom(primary: const Color(0xff2E305F)),
        onPressed: () {
          if (payBotton) {
            db
                .collection("pedidos")
                .where('table', isEqualTo: '${numberTable + 1}')
                .get()
                .then((value) => value.docs.forEach((element) {
                      print(element.id);
                      dialogConfirmation(
                        context,
                        message,
                        '/successful_payment',
                        true,
                        price,
                        element.id,
                      );
                    }))
                .toString();
          } else {
            if (productList.isNotEmpty) {
              var pedido = {
                "id": uuid.v4(),
                "table": '${numberTable + 1}',
                "products": jsonEncode(productList),
                "waiter": 'Yusep',
                "busy": true, //Cambiar a false
                "paidOut": false, //Cambiar a true
              };

              db.collection("pedidos").add(pedido).then(
                  (DocumentReference doc) =>
                      print('DocumentSnapshot added with ID: ${doc.id}'));
            } else {
              snackBar(context, 'No hay productos por agregar');
            }
          }
        },
        child: Text(text));
  }
}

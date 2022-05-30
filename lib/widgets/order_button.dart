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
    required this.editBotton,
    required this.orderBotton,
    required this.data,
  }) : super(key: key);

  final int price;
  final int numberTable;
  final String message;
  final String text;
  final bool payBotton;
  final bool editBotton;
  final bool orderBotton;
  final QuerySnapshot<Object?> data;

  @override
  Widget build(BuildContext context) {
    var uuid = const Uuid();
    var db = FirebaseFirestore.instance;

    return ElevatedButton(
        style: ElevatedButton.styleFrom(primary: const Color(0xff2E305F)),
        onPressed: () {
          if (productList.isEmpty) {
            snackBar(context, 'No hay productos por agregar');
            return;
          }

          if (editBotton) {
            if (data.docs[0]['products'] == jsonEncode(productList)) {
              snackBar(context, 'No hay productos por editar');
              return;
            }
            db
                .collection("pedidos")
                .where('table', isEqualTo: '${numberTable + 1}')
                .get()
                .then((value) => value.docs.forEach((element) {
                      db
                          .collection("pedidos")
                          .doc(element.id)
                          .update({"products": jsonEncode(productList)});
                    }));

            snackBar(context, 'Pedido editado');

            Navigator.pushReplacementNamed(context, '/table_list_screen');
          }

          if (orderBotton) {
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

              snackBar(context, 'Pedido realizado');

              Navigator.pushReplacementNamed(context, '/table_list_screen');
            }
          }

          if (payBotton) {
            db
                .collection("pedidos")
                .where('table', isEqualTo: '${numberTable + 1}')
                .where('busy', isEqualTo: true)
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
                    }));
          }
        },
        child: Text(text));
  }
}

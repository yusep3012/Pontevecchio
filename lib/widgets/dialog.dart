import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:pontevecchio/widgets/widgets.dart';

Future<dynamic> dialogConfirmation(
  BuildContext context,
  String message,
  String routeName,
  bool pay,
  int price,
  String idDocumentFirebase,
) {
  var db = FirebaseFirestore.instance;

  return showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          elevation: 5,
          title: const Text('¡Cuidado!'),
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(message),
              const SizedBox(height: 10),
            ],
          ),
          actions: [
            TextButton(
                onPressed: () => Navigator.pop(context),
                child: const Text(
                  'No',
                  style: TextStyle(color: Colors.red),
                )),
            TextButton(
                onPressed: () {
                  if (pay) {
                    db
                        .collection("pedidos")
                        .doc(idDocumentFirebase)
                        .update({"busy": false, "paidOut": true});

                    Navigator.pushNamed(context, routeName,
                        arguments: {'price': price});
                  }

                  if (!pay) {
                    FirebaseAuth.instance.signOut();
                    snackBar(context, 'Sesión cerrada');
                    Navigator.pop(context);
                  }
                },
                child: const Text('Sí'))
          ],
        );
      });
}

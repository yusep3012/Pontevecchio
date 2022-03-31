import 'package:flutter/material.dart';

Future<dynamic> dialogConfirmation(BuildContext context) {
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
            children: const [
              Text('¿Está seguro que desea eliminar este producto?'),
              SizedBox(height: 10),
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
                onPressed: () => Navigator.pop(context),
                child: const Text('Sí'))
          ],
        );
      });
}

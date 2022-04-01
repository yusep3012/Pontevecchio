import 'package:flutter/material.dart';

Future<dynamic> dialogConfirmation(BuildContext context, String text,
    String routeName, bool answer, int price) {
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
              Text(text),
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
                onPressed: answer
                    ? () => Navigator.pushNamed(context, routeName,
                        arguments: {'price': price})
                    : () => Navigator.pop(context),
                child: const Text('Sí'))
          ],
        );
      });
}

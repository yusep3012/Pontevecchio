import 'package:flutter/material.dart';
import 'package:pontevecchio/screens/screens.dart';

Future<dynamic> showModalBottom(BuildContext context, int price) {
  return showModalBottomSheet(
      isDismissible: false,
      backgroundColor: Colors.grey[200],
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(top: Radius.circular(25))),
      context: context,
      builder: (BuildContext context) {
        return Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              margin: const EdgeInsets.all(15),
              decoration: BoxDecoration(
                  color: Colors.white, borderRadius: BorderRadius.circular(15)),
              child: Padding(
                padding: const EdgeInsets.all(15),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Cerveza Pilsen',
                      style:
                          TextStyle(fontSize: 23, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 20),
                    Row(
                      children: [
                        const Text(
                          'Precio ',
                          style: TextStyle(
                              fontSize: 18, fontWeight: FontWeight.w700),
                        ),
                        Text(
                          // '\$4000',
                          '$price',
                          style: TextStyle(fontSize: 18),
                        ),
                      ],
                    ),
                    const SizedBox(height: 20),
                    const Bottons()
                  ],
                ),
              ),
            ),
          ],
        );
      });
}

import 'package:flutter/material.dart';
import 'package:pontevecchio/models/models.dart';

// Widgets
import 'package:pontevecchio/widgets/widgets.dart';

class OrderButton extends StatelessWidget {
  const OrderButton({
    Key? key,
    required this.price,
    required this.numberTable,
  }) : super(key: key);

  final int price;
  final int numberTable;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
        style: ElevatedButton.styleFrom(primary: const Color(0xff2E305F)),
        onPressed: () {
          // productList.removeRange(0, productList.length);
          print(Order(id: '01', table: numberTable + 1, products: productList)
              .toString());

          dialogConfirmation(
            context,
            '¿Está seguro(a) de pagar el pedido ya?',
            '/successful_payment',
            true,
            price,
          );
        },
        child: const Text('Pagar pedido'));
  }
}

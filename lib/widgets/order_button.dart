import 'package:flutter/material.dart';

// Widgets
import 'package:pontevecchio/widgets/widgets.dart';

class OrderButton extends StatelessWidget {
  const OrderButton({
    Key? key,
    required this.price,
  }) : super(key: key);

  final int price;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
        style: ElevatedButton.styleFrom(primary: const Color(0xff2E305F)),
        onPressed: () {
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

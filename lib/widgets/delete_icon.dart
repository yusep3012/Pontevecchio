import 'package:flutter/material.dart';

// Widgets
import 'package:pontevecchio/widgets/widgets.dart';

class IconButtonDelete extends StatelessWidget {
  const IconButtonDelete({
    Key? key,
    required this.price,
  }) : super(key: key);

  final int price;

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: Icon(
        Icons.delete_rounded,
        color: Colors.red[400],
        size: 28,
      ),
      onPressed: () {
        // dialogConfirmation(
        //   context,
        //   '¿Está seguro que desea eliminar este producto?',
        //   '/successful_payment',
        //   false,
        //   price,
        // );
      },
    );
  }
}

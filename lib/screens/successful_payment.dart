import 'package:flutter/material.dart';

// Widgets
import 'package:pontevecchio/widgets/widgets.dart';

class SuccessfulPayment extends StatelessWidget {
  const SuccessfulPayment({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final arguments = (ModalRoute.of(context)?.settings.arguments ??
        <String, dynamic>{}) as Map;

    return WillPopScope(
      onWillPop: () async {
        return false;
      },
      child: Scaffold(
        body: Center(
          child: Column(
            children: [
              const Expanded(
                flex: 3,
                child: Icon(
                  Icons.check_circle_outline_rounded,
                  color: Colors.green,
                  size: 150,
                ),
              ),
              const Text(
                '¡Gracias por su compra!',
                style: TextStyle(fontSize: 30, fontWeight: FontWeight.w600),
              ),
              Expanded(
                child: Column(
                  children: [
                    const SizedBox(height: 15),
                    Text(
                      'Valor: \$${arguments['price']}',
                      style: const TextStyle(fontSize: 25),
                    ),
                  ],
                ),
              ),
              Container(
                padding: const EdgeInsets.only(left: 16, right: 16),
                child: const Text(
                  'Su compra ha sido completada satisfactoriamente',
                  style: TextStyle(fontSize: 17),
                  textAlign: TextAlign.center,
                ),
              ),
              const ButtonGeneral(
                  routeName: '/login_screen', text: 'Lista de las mesas'),
              const Spacer()
            ],
          ),
        ),
      ),
    );
  }
}

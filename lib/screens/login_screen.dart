import 'package:flutter/material.dart';

// Widgets
import 'package:pontevecchio/widgets/widgets.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Stack(
        alignment: AlignmentDirectional.topCenter,
        children: [
          const Background(),
          Column(
            children: [
              const Expanded(flex: 3, child: Logo()),
              Expanded(flex: 0, child: Container()),
              const Expanded(flex: 3, child: Formulary())
            ],
          )
        ],
      ),
    );
  }
}

class Formulary extends StatelessWidget {
  const Formulary({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 30, horizontal: 50),
      child: Form(
        child: Column(
          children: [
            const UserDates(),
            const Register(),
            Expanded(child: Container()),
            const ButtonGeneral(
                routeName: '/table_list_screen', text: 'Ingresar')
          ],
        ),
      ),
    );
  }
}

class Register extends StatelessWidget {
  const Register({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    const colorText = Colors.white;
    const double fontSize = 16;

    return Container(
      margin: const EdgeInsets.only(top: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text('¿No estás registrado?',
              style: TextStyle(color: colorText, fontSize: fontSize)),
          TextButton(
              onPressed: () {
                Navigator.pushNamed(context, '/register_screen');
              },
              child:
                  const Text('Registrar', style: TextStyle(fontSize: fontSize)))
        ],
      ),
    );
  }
}

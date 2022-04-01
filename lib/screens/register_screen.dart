import 'package:flutter/material.dart';

// Widgets
import 'package:pontevecchio/widgets/widgets.dart';

class RegisterScreen extends StatelessWidget {
  const RegisterScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          backgroundColor: const Color(0xff2E305F),
          elevation: 0,
        ),
        body: Stack(
          children: [
            const Background(),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 30, horizontal: 50),
              child: Column(
                children: const [
                  Expanded(flex: 3, child: Logo()),
                  Expanded(flex: 3, child: UserDates()),
                  Expanded(
                      flex: 0,
                      child:
                          Button(routeName: '/login_screen', text: 'Registrar'))
                ],
              ),
            )
          ],
        ));
  }
}

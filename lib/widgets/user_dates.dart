import 'package:flutter/material.dart';

// Widget
import 'package:pontevecchio/widgets/widgets.dart';

// Models

class UserDates extends StatelessWidget {
  const UserDates({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: const [
        CustomInput(labelText: 'Usuario'),
        SizedBox(height: 20),
        CustomInput(labelText: 'Contraseña'),
      ],
    );
  }
}

import 'package:flutter/material.dart';

class Button extends StatelessWidget {
  final String nameRoute;
  final String text;
  const Button({Key? key, required this.nameRoute, required this.text})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 25),
      child: ElevatedButton(
        onPressed: () {
          Navigator.pushNamed(context, nameRoute);
        },
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 25),
          child: Text(text, style: const TextStyle(fontSize: 16)),
        ),
      ),
    );
  }
}

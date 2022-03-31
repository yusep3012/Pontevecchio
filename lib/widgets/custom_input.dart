import 'package:flutter/material.dart';

class CustomInput extends StatelessWidget {
  final String labelText;
  final bool? obscureText;

  const CustomInput({
    Key? key,
    required this.labelText,
    this.obscureText,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    const styleUnderlineInputBorder = UnderlineInputBorder(
        borderSide: BorderSide(color: Colors.white, width: 2));

    return TextFormField(
      style: const TextStyle(color: Colors.white),
      decoration: InputDecoration(
        labelText: labelText,
        labelStyle: const TextStyle(color: Colors.white),
        fillColor: Colors.white,
        focusedBorder: styleUnderlineInputBorder,
        enabledBorder: styleUnderlineInputBorder,
      ),
    );
  }
}

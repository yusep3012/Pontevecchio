import 'package:flutter/material.dart';

class BackgroundWhite extends StatelessWidget {
  const BackgroundWhite({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(20),
            topRight: Radius.circular(20),
          ),
          color: Colors.grey[200]),
      padding: const EdgeInsets.only(top: 15),
    );
  }
}

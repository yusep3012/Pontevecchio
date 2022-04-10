import 'package:flutter/material.dart';

// Widgets
import 'package:pontevecchio/widgets/widgets.dart';

class Error extends StatelessWidget {
  final String text;
  const Error({
    Key? key,
    required this.text,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Stack(
        children: [
          const BackgroundWhite(),
          Center(
              child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Spacer(),
              Expanded(
                  flex: 3,
                  child: Icon(
                    Icons.error_outline_rounded,
                    size: 180,
                    color: Colors.indigo[900],
                  )),
              Expanded(
                  flex: 3,
                  child: Text(
                    text,
                    style: const TextStyle(
                        fontSize: 28, fontWeight: FontWeight.w600),
                  )),
            ],
          )),
        ],
      ),
    );
  }
}

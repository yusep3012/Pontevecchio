import 'package:flutter/material.dart';

// Widgets
import 'package:pontevecchio/widgets/widgets.dart';

class Bottons extends StatefulWidget {
  const Bottons({
    Key? key,
  }) : super(key: key);

  final Color color = const Color(0xff2E305F);

  @override
  State<Bottons> createState() => _BottonsState();
}

class _BottonsState extends State<Bottons> {
  int _count = 0;
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        Expanded(
          child: ElevatedButton(
              style: ElevatedButton.styleFrom(primary: const Color(0xff2E305F)),
              onPressed: () {
                Navigator.pop(context);
                _count = 0;
                snackBar(context);
              },
              child: const Text(
                'Agregar',
                style: TextStyle(fontSize: 16),
              )),
        ),
        const SizedBox(width: 10),
        ElevatedButton(
            style: ElevatedButton.styleFrom(primary: widget.color),
            onPressed: () {
              remove();
            },
            child: const Text(
              '-',
              style: TextStyle(fontSize: 18),
            )),
        const SizedBox(width: 20),
        Text(
          '$_count',
          style: const TextStyle(fontSize: 16),
        ),
        const SizedBox(width: 20),
        ElevatedButton(
            style: ElevatedButton.styleFrom(primary: widget.color),
            onPressed: () {
              add();
            },
            child: const Text(
              '+',
              style: TextStyle(fontSize: 18),
            )),
      ],
    );
  }

  void remove() {
    return setState(() {
      if (_count > 0) _count--;
    });
  }

  void add() {
    return setState(() {
      _count++;
    });
  }
}

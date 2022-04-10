import 'package:flutter/material.dart';

// Widgets
import 'package:pontevecchio/widgets/widgets.dart';

class Bottons extends StatefulWidget {
  const Bottons({
    Key? key,
    required this.price,
  }) : super(key: key);

  final Color color = const Color(0xff2E305F);
  final int price;

  @override
  State<Bottons> createState() => _BottonsState();
}

class _BottonsState extends State<Bottons> {
  int _count = 0;
  int result = 0;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            const Text(
              'Precio ',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.w700),
            ),
            Text(
              result == 0 ? '\$${widget.price}' : '\$$result',
              style: const TextStyle(fontSize: 18),
            ),
          ],
        ),
        const SizedBox(height: 20),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Expanded(
              child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      primary: const Color(0xff2E305F)),
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
                  result = remove();
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
                  result = add();
                },
                child: const Text(
                  '+',
                  style: TextStyle(fontSize: 18),
                )),
          ],
        )
      ],
    );
  }

  int remove() {
    var res = 0;
    setState(() {
      if (_count > 0) {
        _count--;
        res = widget.price * _count;
      }
    });
    return res;
  }

  int add() {
    var res = 0;
    setState(() {
      _count++;
      if (_count >= 1) {
        res = widget.price * _count;
      }
    });
    return res;
  }
}

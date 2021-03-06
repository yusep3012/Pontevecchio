import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

// Models
import 'package:pontevecchio/models/models.dart';

// Widgets
import 'package:pontevecchio/widgets/widgets.dart';

List<Product> productList = [];
List<Product> productList2 = [];

class Bottons extends StatefulWidget {
  const Bottons({
    Key? key,
    required this.price,
    required this.productName,
    required this.image,
  }) : super(key: key);

  final Color color = const Color(0xff2E305F);
  final int price;
  final String productName;
  final String image;

  @override
  State<Bottons> createState() => _BottonsState();
}

class _BottonsState extends State<Bottons> {
  // var db = FirebaseFirestore.instance;
  int _count = 1;
  int result = 0;
  int quantity = 0;
  int newQuantity = 0;

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
                  onPressed: () => addProducts(),
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

  void addProducts() {
    if (_count >= 1) {
      productList.add(Product(
          count: _count,
          name: widget.productName,
          price: widget.price,
          image: widget.image));
      productList2.add(Product(
          count: 0,
          name: widget.productName,
          price: widget.price,
          image: widget.image));

      snackBar(context, 'Producto agregado');
      Navigator.pop(context);
    } else {
      snackBar(context, 'Cantidad errada');
      Navigator.pop(context);
    }

    if (productList.isNotEmpty) {
      for (var element in productList) {
        if (element.name == (widget.productName)) {
          quantity = element.count;
          newQuantity += quantity;
        }
      }
    }

    if (_count >= 1) {
      productList
          .removeWhere((element) => element.name == (widget.productName));

      var i = productList2.indexWhere((e) => e.name == widget.productName);

      productList.add(Product(
          count: newQuantity,
          name: widget.productName,
          price: widget.price,
          image: widget.image));

      productList2[i].count += quantity;
    }
  }
}

import 'dart:convert';

import 'package:flutter/material.dart';

// DB Firebase
import 'package:cloud_firestore/cloud_firestore.dart';

// Models
import 'package:pontevecchio/models/models.dart';

// Widgets
import 'package:pontevecchio/widgets/widgets.dart';

class TableRequestScreen extends StatelessWidget {
  final int numberTable;
  const TableRequestScreen({Key? key, required this.numberTable})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xff2E305F),
      appBar: AppBar(
        title: Text('Mesa ${numberTable + 1}'),
      ),
      body: DefaultTabController(
        length: 2,
        child: Stack(
          children: [
            const BackgroundWhite(),
            tabBar(),
            Expanded(child: tabBarView(context, numberTable)),
          ],
        ),
      ),
    );
  }
}

// === TABBAR ===
Widget tabBar() {
  return Padding(
    padding: const EdgeInsets.all(15),
    child: TabBar(
        labelColor: Colors.white,
        unselectedLabelColor: Colors.black54,
        labelPadding: const EdgeInsets.all(10),
        indicatorColor: Colors.indigo[900],
        indicator: BoxDecoration(
            color: const Color(0xff2E305F),
            borderRadius: BorderRadius.circular(15)),
        tabs: const [
          Icon(Icons.shopping_cart_outlined),
          Icon(Icons.article_outlined),
        ]),
  );
}

Widget tabBarView(BuildContext context, int numberTable) {
  const textStyle = TextStyle(fontWeight: FontWeight.bold);

  return firstViewTabBarView(context, textStyle, numberTable);
}

Widget firstViewTabBarView(
    BuildContext context, TextStyle textStyle, int numberTable) {
  final Stream<QuerySnapshot> products =
      FirebaseFirestore.instance.collection('productos').snapshots();

  final Orientation orientation = MediaQuery.of(context).orientation;
  late Size size = MediaQuery.of(context).size;
  late int cardsNumber = 2;
  late double height = 115;

  if (orientation == Orientation.landscape) {
    cardsNumber = 3;
    height = size.width * 0.225;
  }

  return StreamBuilder<QuerySnapshot>(
      stream: products,
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (snapshot.hasError) {
          return const Error(text: '??Ups, Algo sali?? mal!');
        }

        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Loading();
        }

        final data = snapshot.requireData;

        return Container(
          padding: const EdgeInsets.only(left: 5, top: 75, right: 5),
          child: TabBarView(children: [
            GridView.count(
              crossAxisCount: cardsNumber,
              children: List.generate(data.size, (index) {
                final String productName = data.docs[index]['name'];
                final int price = data.docs[index]['price'];
                final String image = data.docs[index]['image'];

                return GestureDetector(
                    onTap: () =>
                        showModalBottom(context, productName, price, image),
                    child: Card(
                      elevation: 10,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15)),
                      child: Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(top: 8.0),
                            child: Image(
                              image: NetworkImage(image),
                              fit: BoxFit.fitHeight,
                              height: height,
                            ),
                          ),
                          const Spacer(),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 10),
                            child: Text(
                              productName,
                              style: const TextStyle(
                                  fontSize: 16, fontWeight: FontWeight.w600),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                          const SizedBox(height: 5),
                          Padding(
                            padding: const EdgeInsets.only(bottom: 5),
                            child: Text('\$$price',
                                style: const TextStyle(fontSize: 15)),
                          ),
                        ],
                      ),
                    ));
              }),
            ),

            // SECOND PAGE
            secondPageTabBarView(textStyle, numberTable),
          ]),
        );
      });

  //
}

Widget secondPageTabBarView(TextStyle textStyle, int numberTable) {
  return StreamBuilder<QuerySnapshot>(
      stream: FirebaseFirestore.instance
          .collection('pedidos')
          .where('busy', isEqualTo: true)
          .where('table', isEqualTo: '${numberTable + 1}')
          .snapshots(),
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (snapshot.hasError) {
          return const Error(text: '??Ups, Algo sali?? mal!');
        }

        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Loading();
        }

        final data = snapshot.requireData;

        final length =
            data.size > 0 ? jsonDecode(data.docs[0]['products']).length : 0;

        return OrderList(
          length: length,
          data: data,
          textStyle: textStyle,
          numberTable: numberTable,
        );
      });
}

class OrderList extends StatelessWidget {
  const OrderList({
    Key? key,
    required this.length,
    required this.data,
    required this.textStyle,
    required this.numberTable,
  }) : super(key: key);

  final int length;
  final QuerySnapshot<Object?> data;

  final TextStyle textStyle;
  final int numberTable;

  @override
  Widget build(BuildContext context) {
    int total = 0;

    if (data.size > 0) {
      var products = jsonDecode(data.docs[0]['products']);

      for (var element in products) {
        var decode = jsonDecode(element);

        var model = Product(
            count: decode['count'],
            name: decode['name'],
            price: decode['price'],
            image: decode['image']);
        var i = productList.indexWhere((e) => e.name == model.name);
        var i2 = productList2.indexWhere((e) => e.name == model.name);
        if (i < 0) {
          productList.add(model);
        } else if (i2 >= 0 && i >= 0) {
          productList[i].count = productList2[i2].count + model.count;
        }

        for (var i = 0; i < productList.length; i++) {
          final int price = productList[i].price;
          final int quantity = productList[i].count;
          total += price * quantity;
        }
      }
    } else {
      if (productList.isNotEmpty) {
        for (var i = 0; i < productList.length; i++) {
          final int price = productList[i].price;
          final int quantity = productList[i].count;
          total += price * quantity;
        }
      }
    }

    return Container(
      margin: const EdgeInsets.all(5),
      padding: const EdgeInsets.only(left: 0, top: 20, right: 0, bottom: 20),
      decoration: BoxDecoration(
          color: Colors.white, borderRadius: BorderRadius.circular(15)),
      child: Column(
        children: [
          Expanded(
            child: ListView.builder(
                itemCount: productList.length,
                itemBuilder: ((context, index) {
                  final productName = productList[index].name;
                  final int price = productList[index].price;
                  final int quantity = productList[index].count;
                  final String image = productList[index].image;

                  return ListTile(
                    leading: SizedBox(
                        width: 50,
                        child: Image(
                          image: NetworkImage(image),
                          fit: BoxFit.fitHeight,
                        )),
                    title: Text(
                      productName,
                      style: textStyle,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    subtitle: Text(
                      'Cantidad: $quantity',
                      style: const TextStyle(fontWeight: FontWeight.w600),
                    ),
                    trailing: Wrap(
                      crossAxisAlignment: WrapCrossAlignment.center,
                      spacing: 1,
                      children: [
                        Text('\$${price * quantity}', style: textStyle)
                      ],
                    ),
                  );
                })),
          ),
          Padding(
            padding: const EdgeInsets.only(right: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                const SizedBox(width: 10),
                if (length <= 0)
                  Expanded(
                      child: OrderButton(
                    price: total,
                    numberTable: numberTable,
                    message: '',
                    text: 'Pedir',
                    payBotton: false,
                    editBotton: false,
                    orderBotton: true,
                    data: data,
                  )),
                if (length > 0)
                  Expanded(
                    child: OrderButton(
                      price: total,
                      numberTable: numberTable,
                      message: '??Est?? seguro(a) de pagar el pedido?',
                      text: 'Pagar',
                      payBotton: true,
                      editBotton: false,
                      orderBotton: false,
                      data: data,
                    ),
                  ),
                if (length > 0) const SizedBox(width: 10),
                if (length > 0)
                  Expanded(
                    child: OrderButton(
                      price: total,
                      numberTable: numberTable,
                      message: '',
                      text: 'Editar',
                      payBotton: false,
                      editBotton: true,
                      orderBotton: false,
                      data: data,
                    ),
                  ),
                const SizedBox(width: 20),
                const Text('Total',
                    style:
                        TextStyle(fontWeight: FontWeight.bold, fontSize: 19)),
                const SizedBox(width: 8),
                Text('\$$total',
                    style: const TextStyle(
                        fontWeight: FontWeight.w600, fontSize: 19)),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

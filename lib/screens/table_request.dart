import 'package:flutter/material.dart';

// DB Firebase
import 'package:cloud_firestore/cloud_firestore.dart';

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
            Expanded(child: tabBarView(context)),
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

Widget tabBarView(
  BuildContext context,
) {
  const textStyle = TextStyle(fontWeight: FontWeight.bold);

  return firstViewTabBarView(context, textStyle);
}

Widget firstViewTabBarView(BuildContext context, TextStyle textStyle) {
  final Stream<QuerySnapshot> products =
      FirebaseFirestore.instance.collection('productos').snapshots();

  return StreamBuilder<QuerySnapshot>(
      stream: products,
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (snapshot.hasError) {
          return const Error(text: '¡Ups, Algo salió mal!');
        }

        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Loading();
        }

        final data = snapshot.requireData;

        return Container(
          padding: const EdgeInsets.only(left: 5, top: 75, right: 5),
          child: TabBarView(children: [
            GridView.count(
              crossAxisCount: 2,
              children: List.generate(data.size, (index) {
                final String productName = data.docs[index]['name'];
                final int price = data.docs[index]['price'];
                final String image = data.docs[index]['image'];
                return GestureDetector(
                  onTap: () {
                    showModalBottom(context, productName, price, image);
                  },
                  child: Card(
                    elevation: 10,
                    color: Colors.white,
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 8),
                          child: SizedBox(
                            width: double.infinity,
                            height: 115,
                            child: Image(
                              image: NetworkImage(image),
                              fit: BoxFit.fitHeight,
                            ),
                          ),
                        ),
                        Expanded(
                          child: Container(
                            width: double.infinity,
                            decoration: const BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.only(
                                  bottomLeft: Radius.circular(15),
                                  bottomRight: Radius.circular(15),
                                )),
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                  vertical: 8, horizontal: 15),
                              child: Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Text(
                                      productName,
                                      style: const TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.w600),
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                    const SizedBox(height: 5),
                                    Text('\$$price',
                                        style: const TextStyle(fontSize: 15)),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15)),
                  ),
                );
              }),
            ),

            // SECOND PAGE
            secondPageTabBarView(textStyle),
          ]),
        );
      });

  //
}

Widget secondPageTabBarView(TextStyle textStyle) {
  return StreamBuilder(
      builder: (BuildContext context, AsyncSnapshot<Object?> snapshot) {
    if (snapshot.hasError) {
      return const Error(text: '¡Ups, Algo salió mal!');
    }

    if (snapshot.connectionState == ConnectionState.waiting) {
      return const Loading();
    }

    int total = 0;

    for (var i = 0; i < productList.length; i++) {
      final int price = productList[i]['price'];
      final int quantity = productList[i]['quantity'];
      total += price * quantity;
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
                  final String productName = productList[index]['name'];
                  final int price = productList[index]['price'];
                  final int quantity = productList[index]['quantity'];
                  final String image = productList[index]['image'];

                  return ListTile(
                    leading: Container(
                        width: 50,
                        height: 70,
                        decoration: const BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(5),
                                topRight: Radius.circular(5))),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Image(
                            image: NetworkImage(image),
                            fit: BoxFit.fitHeight,
                          ),
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
                        Text('\$${price * quantity}', style: textStyle),
                        // const IconButtonDelete(price: 2000),
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
                Expanded(
                  child: OrderButton(price: total),
                ),
                const SizedBox(width: 20),
                const Text('Total',
                    style:
                        TextStyle(fontWeight: FontWeight.bold, fontSize: 19)),
                const SizedBox(width: 20),
                Text('\$$total',
                    style: const TextStyle(
                        fontWeight: FontWeight.w600, fontSize: 19)),
              ],
            ),
          ),
        ],
      ),
    );
  });
}

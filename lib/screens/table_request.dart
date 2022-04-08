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
    final Stream<QuerySnapshot> products =
        FirebaseFirestore.instance.collection('productos').snapshots();

    return Scaffold(
      backgroundColor: const Color(0xff2E305F),
      appBar: AppBar(
        title: Text('Mesa ${numberTable + 1}'),
      ),
      body: StreamBuilder<QuerySnapshot>(
          stream: products,
          builder:
              (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
            if (snapshot.hasError) {
              return const Error(text: '¡Ups, Algo salió mal!');
              ;
            }

            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Loading();
            }

            final data = snapshot.requireData;

            return DefaultTabController(
              length: 2,
              child: Stack(
                children: [
                  const BackgroundWhite(),
                  tabBar(),
                  Expanded(child: tabBarView(context, data)),
                ],
              ),
            );
          }),
    );
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

  Widget tabBarView(BuildContext context, QuerySnapshot<Object?> data) {
    const textStyle = TextStyle(fontWeight: FontWeight.bold);

    return Container(
      padding: const EdgeInsets.only(left: 5, top: 75, right: 5),
      child: TabBarView(children: [
        GridView.count(
          crossAxisCount: 2,
          children: List.generate(data.size, (index) {
            final String productName = data.docs[index]['name'];
            final int price = data.docs[index]['price'];
            return GestureDetector(
              onTap: () {
                showModalBottom(context, productName, price);
              },
              child: Card(
                color: Colors.white30,
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8),
                      child: SizedBox(
                        width: double.infinity,
                        height: 115,
                        child: Image(
                          image: NetworkImage('${data.docs[index]['image']}'),
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
                              crossAxisAlignment: CrossAxisAlignment.start,
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
                                Text('\$${data.docs[index]['price']}',
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
        Container(
          margin: const EdgeInsets.all(5),
          padding:
              const EdgeInsets.only(left: 0, top: 20, right: 0, bottom: 20),
          decoration: BoxDecoration(
              color: Colors.white, borderRadius: BorderRadius.circular(15)),
          child: Column(
            children: [
              Expanded(
                child: ListView.builder(
                    itemCount: data.size,
                    itemBuilder: ((context, index) {
                      return ListTile(
                        leading: Container(
                            width: 50,
                            height: 70,
                            decoration: BoxDecoration(
                                color: Colors.grey[350],
                                borderRadius: const BorderRadius.only(
                                    topLeft: Radius.circular(5),
                                    topRight: Radius.circular(5))),
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Image(
                                  image: NetworkImage(
                                      '${data.docs[index]['image']}')),
                            )),
                        title: Text(
                          '${data.docs[index]['name']}',
                          style: textStyle,
                        ),
                        subtitle: Text(
                          'Cantidad ${data.docs[index]['quantity']}',
                          style: const TextStyle(fontWeight: FontWeight.w600),
                        ),
                        trailing: Wrap(
                          crossAxisAlignment: WrapCrossAlignment.center,
                          spacing: 1,
                          children: [
                            Text('\$${data.docs[index]['price']}',
                                style: textStyle),
                            const IconButtonDelete(price: 2000),
                          ],
                        ),
                      );
                    })),
              ),
              Padding(
                padding: const EdgeInsets.only(right: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: const [
                    SizedBox(width: 10),
                    Expanded(
                      child: OrderButton(price: 2000),
                    ),
                    SizedBox(width: 20),
                    Text('Total',
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 19)),
                    SizedBox(width: 20),
                    Text('\$2000',
                        style: TextStyle(
                            fontWeight: FontWeight.w600, fontSize: 19))
                  ],
                ),
              ),
            ],
          ),
        ),
      ]),
    );
  }
}

// }
// }
class Loading extends StatelessWidget {
  const Loading({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          const BackgroundWhite(),
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  width: 100,
                  height: 100,
                  child: CircularProgressIndicator(
                    color: Colors.indigo[900],
                  ),
                ),
                const SizedBox(height: 40),
                const Text('Cargando...', style: TextStyle(fontSize: 25)),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

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

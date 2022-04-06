import 'package:flutter/material.dart';

// DB Firebase
import 'package:cloud_firestore/cloud_firestore.dart';

// Widgets
import 'package:pontevecchio/widgets/widgets.dart';

class TableRequestScreen extends StatelessWidget {
  final int numberTable;
  TableRequestScreen({Key? key, required this.numberTable}) : super(key: key);

  final CollectionReference products =
      FirebaseFirestore.instance.collection('productos');

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<DocumentSnapshot>(
      future: products.doc('p01').get(),
      builder:
          (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot) {
        if (snapshot.hasError) {
          return const Error(text: '¡Ups, Algo salió mal!');
        }

        if (snapshot.hasData && !snapshot.data!.exists) {
          return const Error(text: 'El documento no existe');
        }

        if (snapshot.connectionState == ConnectionState.done) {
          Map<String, dynamic> data =
              snapshot.data!.data() as Map<String, dynamic>;

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
                  Expanded(child: tabBarView(context, data)),
                ],
              ),
            ),
          );
        }

        return const Loading();
      },
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

  Widget tabBarView(BuildContext context, Map<String, dynamic> data) {
    const textStyle = TextStyle(fontWeight: FontWeight.bold);
    final int price = data['price'];
    final String productName = data['name'];
    return Container(
      padding: const EdgeInsets.only(left: 5, top: 75, right: 5),
      child: TabBarView(children: [
        GridView.count(
          crossAxisCount: 2,
          children: List.generate(6, (index) {
            return GestureDetector(
              onTap: () {
                showModalBottom(context, productName, price);
              },
              child: Card(
                color: Colors.white30,
                child: Column(
                  children: [
                    const Padding(
                      padding: EdgeInsets.symmetric(vertical: 8),
                      child: Image(
                        image: AssetImage('assets/pilsen.png'),
                        width: 34,
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
                                  '${data['name']}',
                                  style: const TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w600),
                                ),
                                const SizedBox(height: 5),
                                Text('\$${data['price']}',
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
                    itemCount: 4,
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
                            child: const Padding(
                              padding: EdgeInsets.all(8.0),
                              child:
                                  Image(image: AssetImage('assets/pilsen.png')),
                            )),
                        title: Text(
                          '${data['name']}',
                          style: textStyle,
                        ),
                        subtitle: const Text(
                          'Cantidad 1',
                          style: TextStyle(fontWeight: FontWeight.w600),
                        ),
                        trailing: Wrap(
                          crossAxisAlignment: WrapCrossAlignment.center,
                          spacing: 1,
                          children: [
                            Text('\$${data['price']}', style: textStyle),
                            IconButtonDelete(price: price),
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
                      child: OrderButton(price: price),
                    ),
                    const SizedBox(width: 20),
                    const Text('Total',
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 19)),
                    const SizedBox(width: 20),
                    Text('\$$price',
                        style: const TextStyle(
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

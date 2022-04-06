import 'package:flutter/material.dart';

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

  Widget tabBarView(BuildContext context) {
    const textStyle = TextStyle(fontWeight: FontWeight.bold);
    const int price = 2000;
    return Container(
      padding: const EdgeInsets.only(left: 5, top: 75, right: 5),
      child: TabBarView(children: [
        GridView.count(
          crossAxisCount: 2,
          children: List.generate(6, (index) {
            return GestureDetector(
              onTap: () {
                showModalBottom(context, price);
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
                              children: const [
                                Text(
                                  'Cerveza Pilsen',
                                  style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w600),
                                ),
                                SizedBox(height: 5),
                                Text('\$$price',
                                    style: TextStyle(fontSize: 15)),
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
                        title: const Text(
                          'Cerveza Pilsen',
                          style: textStyle,
                        ),
                        subtitle: const Text(
                          'Cantidad 1',
                          style: TextStyle(fontWeight: FontWeight.w600),
                        ),
                        trailing: Wrap(
                          crossAxisAlignment: WrapCrossAlignment.center,
                          spacing: 1,
                          children: const [
                            Text('\$$price', style: textStyle),
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
                  children: const [
                    SizedBox(width: 10),
                    Expanded(
                      child: OrderButton(price: price),
                    ),
                    SizedBox(width: 20),
                    Text('Total',
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 19)),
                    SizedBox(width: 20),
                    Text('\$$price',
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

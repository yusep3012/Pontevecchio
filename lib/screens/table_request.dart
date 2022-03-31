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
    return Container(
      padding: const EdgeInsets.only(left: 5, top: 75, right: 5),
      child: TabBarView(children: [
        GridView.count(
          crossAxisCount: 2,
          children: List.generate(6, (index) {
            return GestureDetector(
              onTap: () {
                showModalBottom(context);
              },
              child: Card(
                  color: Colors.white30,
                  child: const Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Image(
                      image: AssetImage('assets/pilsen.png'),
                    ),
                  ),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15))),
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
                          children: [
                            const Text('\$1000', style: textStyle),
                            IconButton(
                              icon: Icon(
                                Icons.delete_rounded,
                                color: Colors.red[400],
                                size: 28,
                              ),
                              onPressed: () {
                                dialogConfirmation(context);
                              },
                            ),
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
                        child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                                primary: const Color(0xff2E305F)),
                            onPressed: () {},
                            child: const Text('Realizar pedido'))),
                    const SizedBox(width: 20),
                    const Text('Total',
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 19)),
                    const SizedBox(width: 20),
                    const Text('\$100000',
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

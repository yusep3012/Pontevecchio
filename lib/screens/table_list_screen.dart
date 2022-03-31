import 'package:flutter/material.dart';

// Screens
import 'package:pontevecchio/screens/screens.dart';

// Widgets
import 'package:pontevecchio/widgets/widgets.dart';

class TablesScreen extends StatelessWidget {
  const TablesScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: const Color(0xff2E305F),
        appBar: AppBar(
          title: const Text('Listado de las mesas'),
        ),
        body: Stack(
          children: const [
            BackgroundWhite(),
            Padding(
              padding:
                  EdgeInsets.only(left: 10, top: 15, right: 10, bottom: 15),
              child: TablesList(),
            ),
          ],
        ));
  }
}

class TablesList extends StatelessWidget {
  const TablesList({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: 5,
      itemBuilder: (context, index) => Padding(
        padding: const EdgeInsets.symmetric(vertical: 3, horizontal: 15),
        child: Card(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
          color: Colors.white,
          child: ListTile(
            title: Text('Mesa ${index + 1}'),
            // Verde disponible, Rojo ocupada, Amarillo reservada
            leading: const CircleAvatar(
              backgroundColor: Colors.green,
            ),
            trailing: const Icon(Icons.keyboard_arrow_right_outlined),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => TableRequestScreen(numberTable: index),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}

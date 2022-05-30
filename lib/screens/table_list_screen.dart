import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

// Screens
import 'package:pontevecchio/screens/screens.dart';

// Widgets
import 'package:pontevecchio/widgets/widgets.dart';

class TablesScreen extends StatelessWidget {
  const TablesScreen({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        return false;
      },
      child: Scaffold(
          backgroundColor: const Color(0xff2E305F),
          appBar: AppBar(
            automaticallyImplyLeading: false,
            title: const Text('Listado de las mesas'),
            actions: [
              IconButton(
                  onPressed: () => FirebaseAuth.instance.signOut(),
                  icon: const Icon(Icons.logout_outlined))
            ],
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
          )),
    );
  }
}

class TablesList extends StatelessWidget {
  const TablesList({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance
            .collection('pedidos')
            .where('busy', isEqualTo: true)
            .snapshots(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.hasError) {
            return const Error(text: '¡Ups, Algo salió mal!');
          }

          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Loading();
          }

          final data = snapshot.requireData;

          return ListView.builder(
              itemCount: 5,
              itemBuilder: (context, index) {
                return Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 3, horizontal: 15),
                  child: Card(
                    elevation: 10,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15)),
                    color: Colors.white,
                    child: ListTile(
                      title: Text('Mesa ${index + 1}'),

                      // Verde disponible, Amarillo ocupada
                      leading: CircleAvatar(
                        backgroundColor: data.size > 0 &&
                                data.docs
                                    .where((element) =>
                                        element['table'] == '${index + 1}')
                                    .isNotEmpty
                            ? Colors.orange
                            : Colors.green,
                      ),
                      trailing: const Icon(Icons.keyboard_arrow_right_outlined),
                      onTap: () {
                        productList.removeRange(0, productList.length);
                        productList2.removeRange(0, productList2.length);

                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) =>
                                TableRequestScreen(numberTable: index),
                          ),
                        );
                      },
                    ),
                  ),
                );
              });
        });
  }
}

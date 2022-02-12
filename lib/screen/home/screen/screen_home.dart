import 'package:flutter/material.dart';
import 'package:moneymanager/db/catogary/catogary_db.dart';
import 'package:moneymanager/models/category/catagory_model.dart';
import 'package:moneymanager/screen/add_transaction/screen_add_transcation.dart';
import 'package:moneymanager/screen/catogary/addcat_popup.dart';
import 'package:moneymanager/screen/catogary/screen_catogary.dart';
import 'package:moneymanager/screen/transaction/screen/screen_transaction.dart';

class ScreenHome extends StatefulWidget {
  ScreenHome({Key? key}) : super(key: key);

  @override
  State<ScreenHome> createState() => _ScreenHomeState();
}

class _ScreenHomeState extends State<ScreenHome> {
  final _list = [
    ScreenTransactions(),
    SccreenCatogary(),
  ];

  int newNoIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Money Manager"),
        centerTitle: true,
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: newNoIndex,
        onTap: (newIndex) {
          setState(() {
            newNoIndex = newIndex;
          });
        },
        items: const [
          BottomNavigationBarItem(
              icon: Icon(Icons.dashboard), label: 'Transations'),
          BottomNavigationBarItem(icon: Icon(Icons.category), label: 'Catogary')
        ],
      ),
      body: _list[newNoIndex],
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          if (newNoIndex == 0) {
            print("Transation page");
            Navigator.of(context).pushNamed(ScreenAddTransaction.routeName);
          } else {
            print("Catogary page");
            addCatogaryPopup(context);

            // final _sample = CatogaryModel(
            //   id: DateTime.now().millisecondsSinceEpoch.toString(),
            //   name: 'Travel',
            //   type: CatogaryType.expense,
            // );
            // CategoryDb().insertCategory(_sample);
          }
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}

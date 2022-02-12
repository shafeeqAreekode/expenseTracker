import 'package:flutter/material.dart';
import 'package:moneymanager/db/catogary/catogary_db.dart';
import 'package:moneymanager/screen/catogary/expense_cat_list.dart';
import 'package:moneymanager/screen/catogary/income_cat_list.dart';

class SccreenCatogary extends StatefulWidget {
  const SccreenCatogary({Key? key}) : super(key: key);

  @override
  State<SccreenCatogary> createState() => _SccreenCatogaryState();
}

class _SccreenCatogaryState extends State<SccreenCatogary>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  @override
  void initState() {
    // TODO: implement initState
    _tabController = TabController(length: 2, vsync: this);
    CategoryDb().refreshUi();

    // CategoryDb().getCategory().then((value) {
    //   print("Gatogary get");
    //   return print(value.toString());
    // });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TabBar(
          indicatorWeight: 5.0,
          indicatorColor: Colors.green,
          labelColor: Colors.red,
          unselectedLabelColor: Colors.amber,
          tabs: const [
            Tab(
              text: 'Expense',
            ),
            Tab(
              text: 'Income',
            ),
          ],
          controller: _tabController,
        ),
        Expanded(
          child: TabBarView(controller: _tabController, children: const [
            ExpenseCatList(),
            IncomeCatList(),
          ]),
        )
      ],
    );
  }
}

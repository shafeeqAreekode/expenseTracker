import 'package:flutter/material.dart';
import 'package:moneymanager/db/transaction/transaction-db.dart';
import 'package:moneymanager/models/category/catagory_model.dart';
import 'package:moneymanager/models/transaction/transaction_model.dart';

class ScreenTransactions extends StatelessWidget {
  ScreenTransactions({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // return Column(
    //   children: [
    //     Container(
    //       height: 80.0,
    //       color: Colors.black45,
    //       child: Row(
    //         mainAxisAlignment: MainAxisAlignment.spaceBetween,
    //         children: [
    //           Expanded(
    //             child: Container(
    //               color: _TotalExpersecolor,
    //               child: Column(
    //                 mainAxisAlignment: MainAxisAlignment.spaceEvenly,
    //                 children: const [
    //                   Text("Total Expense", style: TextStyle(fontSize: 20)),
    //                   Text("120000", style: TextStyle(fontSize: 20)),
    //                 ],
    //               ),
    //             ),
    //           ),
    //           Expanded(
    //             child: Container(
    //               color: _TotalIncomecolor,
    //               child: Column(
    //                 mainAxisAlignment: MainAxisAlignment.spaceEvenly,
    //                 children: const [
    //                   Text("Total Income", style: TextStyle(fontSize: 20)),
    //                   Text("1200", style: TextStyle(fontSize: 20)),
    //                 ],
    //               ),
    //             ),
    //           ),
    //         ],
    //       ),
    //     ),
    //     Expanded(
    //       child: ListView.separated(
    //         itemCount: 17,
    //         itemBuilder: (context, index) {
    //           return ListTile(
    //             leading: const Card(
    //               child: Text("24 Nov 2021"),
    //             ),
    //             title: const Text('Petrol'),
    //             subtitle: const Text('200'),
    //             trailing: IconButton(
    //               onPressed: () {},
    //               icon: const Icon(
    //                 Icons.delete,
    //                 color: Colors.red,
    //               ),
    //             ),
    //           );
    //         },
    //         separatorBuilder: (context, index) {
    //           return const Divider();
    //         },
    //       ),
    //     ),
    //   ],
    // );
    return ValueListenableBuilder(
        valueListenable: TransactionDb().transactionListValueNotyfyer,
        builder: (BuildContext ctx, List<TransactionModel> newList, Widget? _) {
          return ListView.separated(
            itemBuilder: (ctx, index) {
              final transaction = newList[index];
              return ListTile(
                isThreeLine: true,
                leading: CircleAvatar(
                  backgroundColor: transaction.type == CatogaryType.income
                      ? Color(0xCC039423)
                      : Color(0xCCC00909),
                  radius: 50,
                  child: Text(transaction.amount.toInt().toString()),
                ),
                title: Text(transaction.purpose),
                subtitle: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(transaction.type == CatogaryType.income
                        ? "Icome"
                        : "Expense"),
                    Text(transaction.date.toString()),
                  ],
                ),
                trailing:
                    IconButton(onPressed: () {}, icon: Icon(Icons.delete)),
              );
            },
            separatorBuilder: (ctx, index) {
              return const SizedBox(height: 10);
            },
            itemCount: newList.length,
          );
        });
  }
}

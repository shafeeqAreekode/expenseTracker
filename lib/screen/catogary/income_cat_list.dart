import 'package:flutter/material.dart';
import 'package:moneymanager/db/catogary/catogary_db.dart';
import 'package:moneymanager/models/category/catagory_model.dart';

class IncomeCatList extends StatelessWidget {
  const IncomeCatList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: CategoryDb().catogaryIncomeListValueNotifiyer,
      builder: (BuildContext ctx, List<CatogaryModel> newList, Widget? _) {
        return ListView.separated(
          itemBuilder: (ctx, index) {
            final catogary = newList[index];
            return ListTile(
              title: Text(catogary.name),
              trailing: IconButton(
                  onPressed: () {
                    CategoryDb.instance.deleteCatogary(catogary.id);
                  },
                  icon: Icon(Icons.delete)),
            );
          },
          separatorBuilder: (ctx, index) {
            return const SizedBox(height: 10);
          },
          itemCount: newList.length,
        );
      },
    );
  }
}

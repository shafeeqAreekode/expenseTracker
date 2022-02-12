import 'package:flutter/material.dart';
import 'package:moneymanager/db/catogary/catogary_db.dart';
import 'package:moneymanager/models/category/catagory_model.dart';

ValueNotifier<CatogaryType> selectedCatogaryNotifiyer =
    ValueNotifier(CatogaryType.income);

Future<void> addCatogaryPopup(BuildContext context) async {
  final _CatogaryTextController = TextEditingController();
  showDialog(
      context: context,
      builder: (ctx) {
        return SimpleDialog(
          title: const Text("Add Catogary"),
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextFormField(
                controller: _CatogaryTextController,
                decoration: const InputDecoration(
                    hintText: 'Catogary Name', border: OutlineInputBorder()),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                children: [
                  RadioButton(title: 'Income', type: CatogaryType.income),
                  RadioButton(title: 'Expense', type: CatogaryType.expense),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: ElevatedButton(
                  onPressed: () {
                    final _nameCatNew = _CatogaryTextController.text;
                    if (_nameCatNew.isEmpty) {
                      return;
                    }
                    final _typeCatNew = selectedCatogaryNotifiyer.value;
                    final _catogary = CatogaryModel(
                        id: DateTime.now().millisecondsSinceEpoch.toString(),
                        name: _nameCatNew,
                        type: _typeCatNew);
                    CategoryDb().insertCategory(_catogary);
                    Navigator.of(ctx).pop();
                  },
                  child: const Text("Add")),
            )
          ],
        );
      });
}

class RadioButton extends StatelessWidget {
  final String title;
  final CatogaryType type;
  // final CatogaryType selectedCatogaryType;
  const RadioButton({
    Key? key,
    required this.title,
    required this.type,
    // required this.selectedCatogaryType,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        ValueListenableBuilder(
          valueListenable: selectedCatogaryNotifiyer,
          builder: (BuildContext context, CatogaryType newCatogary, Widget? _) {
            return Radio<CatogaryType>(
              value: type,
              groupValue: newCatogary,
              onChanged: (value) {
                if (value == null) {
                  return;
                }
                selectedCatogaryNotifiyer.value = value;
                selectedCatogaryNotifiyer.notifyListeners();
              },
            );
          },
        ),
        Text(title),
      ],
    );
  }
}

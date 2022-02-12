import 'dart:math';

import 'package:flutter/material.dart';
import 'package:moneymanager/db/catogary/catogary_db.dart';
import 'package:moneymanager/db/transaction/transaction-db.dart';
import 'package:moneymanager/models/category/catagory_model.dart';
import 'package:intl/intl.dart';
import 'package:moneymanager/models/transaction/transaction_model.dart';

class ScreenAddTransaction extends StatefulWidget {
  static const routeName = 'add-transaction';
  const ScreenAddTransaction({Key? key}) : super(key: key);

  @override
  State<ScreenAddTransaction> createState() => _ScreenAddTransactionState();
}

class _ScreenAddTransactionState extends State<ScreenAddTransaction> {
  /*
Purpose
Date and time
Amount
Income/Expense
Catogary Type
  */
  DateTime? _selectedDate;
  CatogaryType? _selectedCatogaryType;
  CatogaryModel? _selectedCatogaryModel;
  String? _selectedListValue;

  ///from the ui
  final purposeTextEdittingController = TextEditingController();
  final amountTextEdittingController = TextEditingController();
  @override
  void initState() {
    // TODO: implement initState
    _selectedCatogaryType = CatogaryType.income;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Add Transactions"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Column(
          children: [
            TextFormField(
              controller: purposeTextEdittingController,
              keyboardType: TextInputType.text,
              decoration: const InputDecoration(hintText: 'Purpose'),
            ),
            TextFormField(
              controller: amountTextEdittingController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(hintText: 'Amount'),
            ),
            TextButton.icon(
                onPressed: () async {
                  final _selectedDateTemp = await showDatePicker(
                    context: context,
                    initialDate: DateTime.now(),
                    firstDate:
                        DateTime.now().subtract(const Duration(days: 31)),
                    lastDate: DateTime.now(),
                  );
                  setState(() {
                    _selectedDate = _selectedDateTemp;
                  });
                },
                icon: const Icon(Icons.calendar_today),
                label: Text(_selectedDate == null
                    ? "Pick Date"
                    : _selectedDate.toString())),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Row(
                  children: [
                    Radio(
                        value: CatogaryType.income,
                        groupValue: _selectedCatogaryType,
                        onChanged: (newValue) {
                          setState(() {
                            _selectedCatogaryType = CatogaryType.income;
                            _selectedListValue = null;
                          });
                        }),
                    const Text("Income")
                  ],
                ),
                Row(
                  children: [
                    Radio(
                        value: CatogaryType.expense,
                        groupValue: _selectedCatogaryType,
                        onChanged: (newValue) {
                          setState(() {
                            _selectedCatogaryType = CatogaryType.expense;
                            _selectedListValue = null;
                          });
                        }),
                    const Text("Expense")
                  ],
                ),
              ],
            ),
            DropdownButton(
                value: _selectedListValue,
                icon: Icon(Icons.arrow_drop_down_circle_outlined),
                items: (_selectedCatogaryType == CatogaryType.income
                        ? CategoryDb.instance.catogaryIncomeListValueNotifiyer
                        : CategoryDb.instance.catogaryExpenseListValueNotifyer)
                    .value
                    .map((e) {
                  return DropdownMenuItem(
                    onTap: () {
                      _selectedCatogaryModel = e;
                    },
                    value: e.id,
                    child: Text(e.name),
                  );
                }).toList(),
                hint: Text("Select Catogary"),
                onChanged: (selectedValue) {
                  // print(selectedValue);
                  setState(() {
                    _selectedListValue = selectedValue.toString();
                  });
                  print(_selectedListValue);
                }),
            ElevatedButton.icon(
              onPressed: () {
                addTransactions();
              },
              icon: const Icon(Icons.add),
              label: const Text("Add New Transactions"),
            )
          ],
        ),
      ),
    );
  }

  Future<void> addTransactions() async {
    final _purposeText = purposeTextEdittingController.text;
    final _amountText = amountTextEdittingController.text;
    if (_purposeText.isEmpty) {
      return;
    }
    if (_amountText.isEmpty) {
      return;
    }
    // _selectedDate
    if (_selectedDate == null) {
      return;
    }
    if (_selectedListValue == null) {
      return;
    }
    final _parsedAmount = double.tryParse(_amountText);
    if (_parsedAmount == null) {
      return;
    }
    //_selectedCatogaryType
    //_selectedCatogaryModel
    final _model = TransactionModel(
      _purposeText,
      _parsedAmount,
      _selectedDate!,
      _selectedCatogaryType!,
      _selectedCatogaryModel!,
    );
    TransactionDb.instance.addTransaction(_model);
  }
}

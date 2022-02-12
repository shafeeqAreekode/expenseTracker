import 'package:flutter/cupertino.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:moneymanager/models/transaction/transaction_model.dart';

const TRANSACTION_DB_NAME = "transaction-db";

abstract class TransactionDbFunctions {
  Future<void> addTransaction(TransactionModel obj);
  Future<List<TransactionModel>> getTransactions();
}

class TransactionDb implements TransactionDbFunctions {
  TransactionDb._internal();
  static TransactionDb instance = TransactionDb._internal();
  factory TransactionDb() {
    return instance;
  }
  ValueNotifier<List<TransactionModel>> transactionListValueNotyfyer =
      ValueNotifier([]);

  @override
  Future<void> addTransaction(TransactionModel obj) async {
    final _db = await Hive.openBox<TransactionModel>(TRANSACTION_DB_NAME);
    await _db.put(obj.id, obj);
    _refreshUi();
  }

  Future<void> _refreshUi() async {
    transactionListValueNotyfyer.value.clear();
    final _alltransactionList = await getTransactions();
    await Future.forEach(_alltransactionList, (TransactionModel transaction) {
      transactionListValueNotyfyer.value.add(transaction);
    });

    transactionListValueNotyfyer.notifyListeners();
  }

  @override
  Future<List<TransactionModel>> getTransactions() async {
    final _transactionDb =
        await Hive.openBox<TransactionModel>(TRANSACTION_DB_NAME);
    return _transactionDb.values.toList();
  }
}

import 'package:flutter/cupertino.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:moneymanager/models/transaction/transaction_model.dart';

const TRANSACTION_DB_NAME = "transaction-db";

abstract class TransactionDbFunctions {
  Future<List<TransactionModel>> getTransactions();
  Future<void> addTransaction(TransactionModel obj);
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
    final _alltransactionList = await getTransactions();
    _alltransactionList.sort(((a, b) => a.date.compareTo(b.date)));
    transactionListValueNotyfyer.value.clear();
    transactionListValueNotyfyer.value.addAll(_alltransactionList);

    transactionListValueNotyfyer.notifyListeners();
  }

  @override
  Future<List<TransactionModel>> getTransactions() async {
    final _transactionDb =
        await Hive.openBox<TransactionModel>(TRANSACTION_DB_NAME);
    return _transactionDb.values.toList();
  }
}

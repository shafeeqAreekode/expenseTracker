import 'package:flutter/cupertino.dart';
import 'package:hive/hive.dart';
import 'package:moneymanager/models/category/catagory_model.dart';
part 'transaction_model.g.dart';

@HiveType(typeId: 3)
class TransactionModel {
  @HiveField(0)
  final String purpose;
  @HiveField(1)
  final double amount;
  @HiveField(2)
  final DateTime date;
  @HiveField(3)
  final CatogaryType type;
  @HiveField(4)
  final CatogaryModel model;
  @HiveField(5)
  String? id;

  TransactionModel(
    @required this.purpose,
    @required this.amount,
    @required this.date,
    @required this.type,
    @required this.model,
  ) {
    id = DateTime.now().millisecondsSinceEpoch.toString();
  }
}

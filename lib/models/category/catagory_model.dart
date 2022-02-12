import 'package:hive_flutter/adapters.dart';
part 'catagory_model.g.dart';

@HiveType(typeId: 2)
enum CatogaryType {
  @HiveField(0)
  income,
  @HiveField(1)
  expense,
}

@HiveType(typeId: 1)
class CatogaryModel {
  @HiveField(0)
  final String id;
  @HiveField(1)
  final String name;
  @HiveField(2)
  final CatogaryType type;
  @HiveField(3)
  final bool isDeleted;

  CatogaryModel({
    required this.id,
    required this.name,
    required this.type,
    this.isDeleted = false,
  });
  @override
  String toString() {
    return '{$name $type}';
  }
}

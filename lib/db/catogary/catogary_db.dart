import 'package:flutter/cupertino.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:moneymanager/models/category/catagory_model.dart';

const CATOGARY_DB_NAME = 'catogary-db';

abstract class CategoryDbFunctions {
  Future<List<CatogaryModel>> getCategory();
  Future<void> insertCategory(CatogaryModel value);
  Future<void> deleteCatogary(String catogaryId);
}

class CategoryDb implements CategoryDbFunctions {
  CategoryDb._internal();
  static CategoryDb instance = CategoryDb._internal();
  factory CategoryDb() {
    return instance;
  }

  ValueNotifier<List<CatogaryModel>> catogaryIncomeListValueNotifiyer =
      ValueNotifier([]);
  ValueNotifier<List<CatogaryModel>> catogaryExpenseListValueNotifyer =
      ValueNotifier([]);
  //insert catogary to  database (hive box)
  @override
  Future<void> insertCategory(CatogaryModel value) async {
    final _catogaryDb = await Hive.openBox<CatogaryModel>(CATOGARY_DB_NAME);
    await _catogaryDb.put(value.id, value);
    refreshUi();
  }

  //get all catogary from database (hive box)
  @override
  Future<List<CatogaryModel>> getCategory() async {
    final _catogaryDb = await Hive.openBox<CatogaryModel>(CATOGARY_DB_NAME);
    return _catogaryDb.values.toList();
  }

  Future<void> refreshUi() async {
    catogaryExpenseListValueNotifyer.value.clear();
    catogaryIncomeListValueNotifiyer.value.clear();
    final _allCatogarylist = await getCategory();
    await Future.forEach(_allCatogarylist, (CatogaryModel catogary) {
      if (catogary.type == CatogaryType.income) {
        catogaryIncomeListValueNotifiyer.value.add(catogary);
      } else {
        catogaryExpenseListValueNotifyer.value.add(catogary);
      }
    });
    catogaryExpenseListValueNotifyer.notifyListeners();
    catogaryIncomeListValueNotifiyer.notifyListeners();
  }

  //delete catogary from database (hive box)
  @override
  Future<void> deleteCatogary(String catogaryId) async {
    final _catogaryDb = await Hive.openBox<CatogaryModel>(CATOGARY_DB_NAME);
    await _catogaryDb.delete(catogaryId);
    return refreshUi();
  }
}

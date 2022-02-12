import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:moneymanager/models/category/catagory_model.dart';
import 'package:moneymanager/models/transaction/transaction_model.dart';
import 'package:moneymanager/screen/add_transaction/screen_add_transcation.dart';
import 'package:moneymanager/screen/home/screen/screen_home.dart';

Future<void> main() async {
  // final obj1 = CategoryDb();
  // final obj2 = CategoryDb();
  // print("test ten");
  // print(obj1 == obj2);

  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  if (!Hive.isAdapterRegistered(CatogaryTypeAdapter().typeId)) {
    Hive.registerAdapter(CatogaryTypeAdapter());
  }
  if (!Hive.isAdapterRegistered(CatogaryModelAdapter().typeId)) {
    Hive.registerAdapter(CatogaryModelAdapter());
  }
  if (!Hive.isAdapterRegistered(TransactionModelAdapter().typeId)) {
    Hive.registerAdapter(TransactionModelAdapter());
  }
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: ScreenHome(),
      routes: {
        ScreenAddTransaction.routeName: (ctx) => const ScreenAddTransaction()
      },
    );
  }
}

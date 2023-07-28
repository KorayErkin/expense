// ignore_for_file: unnecessary_import

import 'package:expense/src/data/expense_data.dart';
import 'package:expense/src/screens/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:provider/provider.dart';

void main() async {
  /* initialize hive */
  await Hive.initFlutter();
  /* initialize hive */

  /* open a hive box */
  await Hive.openBox("expense_database2");
  /* open a hive box */

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => ExpenseData(),
      builder: (context, child) => MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Expense Tracker',
        theme: ThemeData(
          primarySwatch: Colors.indigo,
        ),
        home: const HomeScreen(),
      ),
    );
  }
}

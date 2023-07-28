// ignore_for_file: unused_local_variable

import 'package:expense/src/models/expense_item.dart';
import 'package:hive/hive.dart';

class HiveDataBase {
  /* reference our box */
  final _myBox = Hive.box("expense_database2");
  /* reference our box */

  /* write data */
  void saveData(List<ExpenseItem> allExpense) {
    List<List<dynamic>> allExpensesFormatted = [];
    for (var expense in allExpense) {
      // convert each expenseItem into a list of storable types (strings, dateTime)
      List<dynamic> expenseFormatted = [
        expense.name,
        expense.amount,
        expense.dateTime,
      ];
      allExpensesFormatted.add(expenseFormatted);
    }

    // finally lets store in our database!
    _myBox.put("ALL_EXPENSES", allExpensesFormatted);
  }
  /* write data */

  /* read data */
  List<ExpenseItem> readData() {
    List savedExpenses = _myBox.get("ALL_EXPENSES") ?? [];
    List<ExpenseItem> allExpenses = [];

    for (int i = 0; i < savedExpenses.length; i++) {
      String name = savedExpenses[i][0];
      String amount = savedExpenses[i][1];
      DateTime dateTime = savedExpenses[i][2];

      ExpenseItem expense = ExpenseItem(
        name: name,
        amount: amount,
        dateTime: dateTime,
      );

      allExpenses.add(expense);
    }
    return allExpenses;
  }
  /* read data */
}

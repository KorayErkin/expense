// ignore_for_file: unused_local_variable

import 'package:expense/src/components/expense_summary.dart';
import 'package:expense/src/components/expense_tile.dart';
import 'package:expense/src/data/expense_data.dart';
import 'package:expense/src/models/expense_item.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  /* Text Controllers */
  final newExpenseNameController = TextEditingController();
  final newExpenseAmountController = TextEditingController();
  final newExpenseTlController = TextEditingController();
  final newExpenseKrsController = TextEditingController();
  /* Text Controllers */

  @override
  void initState() {
    super.initState();
    Provider.of<ExpenseData>(context, listen: false).prepareData();
  }

  /* Add new expense */
  void addNewExpense() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        elevation: 0,
        title: const Text("Add New Expense"),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            /* Expense Name */
            TextFormField(
              controller: newExpenseNameController,
              cursorColor: Colors.black,
              style: const TextStyle(color: Colors.black),
              decoration: const InputDecoration(
                hintText: "Expense Name",
                prefixIcon: Icon(Icons.abc),
                prefixIconColor: Colors.black,
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.green),
                ),
              ),
            ),
            /* Expense Name */

            const SizedBox(
              height: 10,
            ),

            /* Expense Amount */
            Row(
              children: [
                // Tl
                Expanded(
                  child: TextFormField(
                    textInputAction: TextInputAction.done,
                    keyboardType: TextInputType.number,
                    controller: newExpenseTlController,
                    cursorColor: Colors.black,
                    style: const TextStyle(color: Colors.black),
                    decoration: const InputDecoration(
                      hintText: "TL",
                      prefixIcon: Icon(Icons.attach_money),
                      prefixIconColor: Colors.black,
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.green),
                      ),
                    ),
                  ),
                ),

                const SizedBox(
                  width: 10,
                ),

                // Krş
                Expanded(
                  child: TextFormField(
                    textInputAction: TextInputAction.done,
                    keyboardType: TextInputType.number,
                    controller: newExpenseKrsController,
                    cursorColor: Colors.black,
                    style: const TextStyle(color: Colors.black),
                    decoration: const InputDecoration(
                      hintText: "Krs",
                      prefixIcon: Icon(Icons.attach_money),
                      prefixIconColor: Colors.black,
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.green),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            /* Expense Amount */
          ],
        ),
        actions: [
          /* Save button */
          TextButton(
            onPressed: save,
            child: const Text(
              "Save",
              style: TextStyle(
                color: Colors.green,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          /* Save button */

          /* Cancel button */
          TextButton(
            onPressed: cancel,
            child: const Text(
              "Cancel",
              style: TextStyle(
                color: Colors.red,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          /* Cancel button */
        ],
      ),
    );
  }
  /* Add new expense */

  /* Delete Expense */
  void deleteExpense(ExpenseItem expense) {
    Provider.of<ExpenseData>(context, listen: false).deleteExpense(expense);
  }
  /* Delete Expense */

  /* Save */
  void save() {
    if (newExpenseNameController.text.isNotEmpty &&
        newExpenseTlController.text.isNotEmpty &&
        newExpenseKrsController.text.isNotEmpty) {
      /* put Tl and Krs together */
      String amount =
          '${newExpenseTlController.text}.${newExpenseKrsController.text}';
      /* put Tl and Krs together */

      /* Create Expense Item */
      ExpenseItem newExpense = ExpenseItem(
        name: newExpenseNameController.text,
        amount: amount,
        dateTime: DateTime.now(),
      );
      /* Create Expense Item */

      /* Add the new expense */
      Provider.of<ExpenseData>(context, listen: false)
          .addNewExpense(newExpense);
      /* Add the new expense */
    }

    Navigator.pop(context);
    clear();
  }
  /* Save */

  /* Cancel */
  void cancel() {
    Navigator.pop(context);
    clear();
  }
  /* Cancel */

  /* Clear Controllers */
  void clear() {
    newExpenseNameController.clear();
    newExpenseAmountController.clear();
    newExpenseKrsController.clear();
    newExpenseTlController.clear();
  }
  /* Clear Controllers */

  @override
  Widget build(BuildContext context) {
    return Consumer<ExpenseData>(
      builder: (context, value, child) => Scaffold(
          /* Bg Color */
          backgroundColor: Colors.white,
          /* Bg Color */

          /* FloatingActionButton */
          floatingActionButton: FloatingActionButton(
            backgroundColor: Colors.indigo.shade900,
            onPressed: addNewExpense,
            child: const Icon(
              Icons.add,
              size: 33,
            ),
          ),
          /* FloatingActionButton */

          /* Body */
          body: Padding(
            padding: const EdgeInsets.only(top: 15),
            child: ListView(
              children: [
                /* Weakly summary */
                ExpenseSummary(
                  startOfWeek: value.startOfWeekDate(),
                ),
                /* Weakly summary */

                const SizedBox(
                  height: 20,
                ),

                /* Expense List */
                ListView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: value.getAllExpenseList().length,
                  itemBuilder: (context, index) => ExpenseTile(
                    name: value.getAllExpenseList()[index].name,
                    amount: value.getAllExpenseList()[index].amount,
                    dateTime: value.getAllExpenseList()[index].dateTime,
                    deleteTapped: (p0) => deleteExpense(
                      value.getAllExpenseList()[index],
                    ),
                  ),
                ),
                /* Expense List */
              ],
            ),
          )
          /* Body */
          ),
    );
  }
}

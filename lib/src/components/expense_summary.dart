// ignore_for_file: unused_local_variable

import 'package:expense/src/bar%20graph/bar_graph.dart';
import 'package:expense/src/data/expense_data.dart';
import 'package:expense/src/datetime/date_time_helper.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ExpenseSummary extends StatelessWidget {
  final DateTime startOfWeek;

  const ExpenseSummary({
    super.key,
    required this.startOfWeek,
  });

  double calculateMax(
    ExpenseData value,
    String monday,
    String tuesday,
    String wenesday,
    String thursday,
    String friday,
    String saturday,
    String sunday,
  ) {
    double? max = 100;
    List<double> values = [
      value.calculateDailyExpenseSummary()[monday] ?? 0,
      value.calculateDailyExpenseSummary()[tuesday] ?? 0,
      value.calculateDailyExpenseSummary()[wenesday] ?? 0,
      value.calculateDailyExpenseSummary()[thursday] ?? 0,
      value.calculateDailyExpenseSummary()[friday] ?? 0,
      value.calculateDailyExpenseSummary()[saturday] ?? 0,
      value.calculateDailyExpenseSummary()[sunday] ?? 0,
    ];
    values.sort();
    max = values.last * 1.1;
    return max == 0 ? 100 : max;
  }

  String calculateWeekTotal(
    ExpenseData value,
    String monday,
    String tuesday,
    String wenesday,
    String thursday,
    String friday,
    String saturday,
    String sunday,
  ) {
    List<double> values = [
      value.calculateDailyExpenseSummary()[monday] ?? 0,
      value.calculateDailyExpenseSummary()[tuesday] ?? 0,
      value.calculateDailyExpenseSummary()[wenesday] ?? 0,
      value.calculateDailyExpenseSummary()[thursday] ?? 0,
      value.calculateDailyExpenseSummary()[friday] ?? 0,
      value.calculateDailyExpenseSummary()[saturday] ?? 0,
      value.calculateDailyExpenseSummary()[sunday] ?? 0,
    ];
    double total = 0;
    for (int i = 0; i < values.length; i++) {
      total += values[i];
    }
    return total.toStringAsFixed(2);
  }

  @override
  Widget build(BuildContext context) {
    // get yyyymmdd for each day of this week
    String monday = convertDateTimeToString(
      startOfWeek.add(
        const Duration(
          days: 0,
        ),
      ),
    );
    String tuesday = convertDateTimeToString(
      startOfWeek.add(
        const Duration(
          days: 1,
        ),
      ),
    );
    String wednesday = convertDateTimeToString(
      startOfWeek.add(
        const Duration(
          days: 2,
        ),
      ),
    );
    String thursday = convertDateTimeToString(
      startOfWeek.add(
        const Duration(
          days: 3,
        ),
      ),
    );
    String friday = convertDateTimeToString(
      startOfWeek.add(
        const Duration(
          days: 4,
        ),
      ),
    );
    String saturday = convertDateTimeToString(
      startOfWeek.add(
        const Duration(
          days: 5,
        ),
      ),
    );
    String sunday = convertDateTimeToString(
      startOfWeek.add(
        const Duration(
          days: 6,
        ),
      ),
    );

    return Consumer<ExpenseData>(
      builder: (context, value, child) {
        return Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(25.0),
              child: Row(
                children: [
                  const Text(
                    "Week Total : ",
                    style: TextStyle(
                      color: Colors.red,
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                  Text(
                    "${calculateWeekTotal(
                      value,
                      monday,
                      tuesday,
                      wednesday,
                      thursday,
                      friday,
                      saturday,
                      sunday,
                    )} ₺",
                    style: const TextStyle(
                      color: Colors.indigo,
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 200,
              child: MyBarGraph(
                maxY: calculateMax(
                  value,
                  monday,
                  tuesday,
                  wednesday,
                  thursday,
                  friday,
                  saturday,
                  sunday,
                ),
                monAmount: value.calculateDailyExpenseSummary()[monday] ?? 0,
                tueAmount: value.calculateDailyExpenseSummary()[tuesday] ?? 0,
                wedAmount: value.calculateDailyExpenseSummary()[wednesday] ?? 0,
                thurAmount: value.calculateDailyExpenseSummary()[thursday] ?? 0,
                friAmount: value.calculateDailyExpenseSummary()[friday] ?? 0,
                satAmount: value.calculateDailyExpenseSummary()[saturday] ?? 0,
                sunAmount: value.calculateDailyExpenseSummary()[sunday] ?? 0,
              ),
            ),
          ],
        );
      },
    );
  }
}

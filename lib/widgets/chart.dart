import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import 'package:udemy_expenses_app/models/transaction.dart';
import 'package:udemy_expenses_app/widgets/chart_bar.dart';

class Chart extends StatelessWidget {
  final List<Transaction> recentTransactions;

  Chart(this.recentTransactions);

  List<Map<String, Object>> get groupTransactionValues {
    return List.generate(7, (index) {
      final today = DateTime.now();
      final weekDayNumber = today.weekday;
      final weekDay = today.subtract(Duration(days: weekDayNumber - index - 1));

      double totalSum = 0.0;

      for (var i = 0; i < recentTransactions.length; i++) {
        if (recentTransactions[i].date.day == weekDay.day &&
            recentTransactions[i].date.month == weekDay.month &&
            recentTransactions[i].date.year == weekDay.year) {
          totalSum += recentTransactions[i].amount;
        }
      }

      return {
        'day': DateFormat.E().format(weekDay).substring(0, 1),
        'amount': totalSum
      };
    });
  }

  double get totalSpending {
    return groupTransactionValues.fold(0.0, (sum, data) {
      return sum + (data['amount'] as double);
    });
  }

  @override
  Widget build(BuildContext context) {
    print(groupTransactionValues);
    return Card(
      elevation: 2,
      margin: EdgeInsets.all(5),
      child: Padding(
        padding: const EdgeInsets.only(
            top: 25.0, bottom: 25.0, right: 35.0, left: 35.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: groupTransactionValues.map((data) {
            return Flexible(
              flex: 2,
              fit: FlexFit.tight,
              child: ChartBar(
                  data['day'] as String,
                  data['amount'] as double,
                  totalSpending == 0.0
                      ? 0.0
                      : ((data['amount'] as double) / totalSpending)),
            );
          }).toList(),
        ),
      ),
    );
  }
}

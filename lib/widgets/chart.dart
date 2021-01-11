import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:personal_expenses/widgets/chart_bar.dart';

import '../transaction.dart';

class Chart extends StatelessWidget {
  Chart({Key key, this.transactions}) : super(key: key);

  final List<Transaction> transactions;

  List<Map<String, Object>> get groupedTransactionValues {
    return List.generate(7, (index) {
      final weekDay = DateTime.now().subtract(
        Duration(days: index),
      );

      double amount = 0;
      transactions
          .where((element) =>
              element.date.day == weekDay.day &&
              element.date.month == weekDay.month &&
              element.date.year == weekDay.year)
          .forEach((element) {
        amount += element.amount;
      });

      return {
        'day': DateFormat.E().format(weekDay).substring(0, 1),
        'amount': amount
      };
    }).reversed.toList();
  }

  double get maxSpending {
    return groupedTransactionValues.fold(0.0, (previousValue, element) {
      return previousValue + element['amount'];
    });
  }

  @override
  Widget build(BuildContext context) {
    print(groupedTransactionValues);
    return Card(
      elevation: 6,
      margin: EdgeInsets.all(20.0),
      child: Container(
        padding: EdgeInsets.all(10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: groupedTransactionValues.map((e) {
            return Flexible(
              fit: FlexFit.tight,
              child: ChartBar(
                label: e['day'],
                spending: e['amount'],
                spendingPctOfTotal: maxSpending == 0.0
                    ? 0.0
                    : (e['amount'] as double) / maxSpending,
              ),
            );
          }).toList(),
        ),
      ),
    );
  }
}

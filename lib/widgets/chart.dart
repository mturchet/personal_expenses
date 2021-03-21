import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import './chart_bar.dart';
import '../models/transaction.dart';

class Chart extends StatelessWidget {
  final List<Transaction> recentTransactions;

  Chart(this.recentTransactions);

  List<Map<String, Object>> get groupedTransactionValues {
    return List.generate(7, (index) {
      final weekDay = DateTime.now().subtract(
        Duration(
          days: index,
        ),
      );
      var totalSum = 0.0;
      for (var i = 0; i < recentTransactions.length; i++) {
        if (recentTransactions[i].date.day == weekDay.day &&
            recentTransactions[i].date.month == weekDay.month &&
            recentTransactions[i].date.year == weekDay.year) {
          totalSum += recentTransactions[i].amount;
        }
      }

      return {
        'day': DateFormat.E().format(weekDay).substring(0,
            1), //pega apenas o primeiro carácter (de 0 a 1) do format que retorna 3 dígitos
        'amount': totalSum,
      };
    })
        .reversed
        .toList(); //reverse gives us a iterable rather than a list and we need to call toList() again to convert it as we do on maps
  }

  double get maxSpending {
    return groupedTransactionValues.fold(0.0, (sum, item) {
      // fold allows us to change a list to another type with a certain logic that we pass into fold, equivalent to reduce function
      if (sum + item['amount'] == 0.0) {
        return 1.0;
      } else {
        return sum + item['amount'];
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    print(groupedTransactionValues);
    print(maxSpending);
    return Card(
      elevation: 6,
      margin: EdgeInsets.all(20),
      child: Padding(
        // this is a container with only properties of padding
        padding: EdgeInsets.all(10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: groupedTransactionValues.map((data) {
            return Flexible(
              // this widget takes a fit argument that we can pass a flex dimension
              fit: FlexFit.tight, //gets as space as it can get
              child: ChartBar(
                label: data['day'],
                spendingAmount: data['amount'],
                spendingPctOfTotal: (data['amount'] as double) / maxSpending,
                // maxSpending == 0.0
                //     ? 0.0
                //     // : {(data['amount'] as double) / maxSpending}
                //     : 0.5,
              ),
            );
          }).toList(),
        ),
      ),
    );
  }
}

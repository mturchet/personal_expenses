import 'package:flutter/material.dart';

class ChartBar extends StatelessWidget {
  final String label;
  final double spendingAmount;
  final double spendingPctOfTotal;

  ChartBar({this.label, this.spendingAmount, this.spendingPctOfTotal});

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      Container(
        height: 20,
        child: FittedBox(
          child: Text(
            'R\$${spendingAmount.toStringAsFixed(0)}',
          ),
        ),
      ),
      SizedBox(
        height: 4,
      ),
      Container(
        height: 60,
        width: 10,
        child: Stack(
          children: [
            Container(
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey, width: 1),
                color: Color.fromRGBO(220, 220, 220, 1),
                borderRadius: BorderRadius.circular(10),
              ),
            ),
            FractionallySizedBox(
              heightFactor:
                  spendingPctOfTotal, //this is a number that goes from 0 to 1 and 1 is the height of the surrounded container which is 60
              child: Container(
                decoration: BoxDecoration(
                  color: Theme.of(context).primaryColor,
                  borderRadius: BorderRadius.circular(
                      10), //two containers are matching up regarding their borders and their containers
                ),
              ),
            ),
          ],
        ),
      ),
      SizedBox(
        height: 4,
      ),
      Text(
        label,
      ),
    ]);
  }
}

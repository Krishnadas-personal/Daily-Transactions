import 'package:daily_transactions/widget/transaction_item.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class TransactionList extends StatelessWidget {
  final List transaction;
  final Function delete;
  const TransactionList({Key key, this.transaction, this.delete})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return (transaction.isEmpty)
        ? Column(
            children: [
              Text(
                "No Transactions yet baby",
                style: Theme.of(context).textTheme.headline6,
              ),
              Image.asset('assets/images/waiting.jpg')
            ],
          )
        : ListView(
            children: transaction.map((tx) {
              return TransactionItem(key: ValueKey(tx.id), transaction: tx, delete: delete);
            }).toList(),
          ); 
  }
}

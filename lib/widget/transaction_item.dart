import 'dart:math';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class TransactionItem extends StatefulWidget {
  final transaction;
  final Function delete;
  const TransactionItem({Key key, this.transaction, this.delete})
      : super(key: key);

  @override
  _TransactionItemState createState() => _TransactionItemState();
}

class _TransactionItemState extends State<TransactionItem> {
Color _bgColor;
@override
  void initState() {
    const List<Color> availableColor=[
      Colors.red,
      Colors.green,
      Colors.black,
      Colors.purple
    ];
    _bgColor=availableColor[Random().nextInt(3)];
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2.0,
      color: Colors.white70,
      margin: EdgeInsets.symmetric(vertical: 6, horizontal: 4),
      child: ListTile(
        leading: CircleAvatar(
          backgroundColor: _bgColor,
          // maxRadius: 30.0,
          radius: 28.0,
          child: Container(
            // margin: EdgeInsets.all(8.0),
            // decoration: BoxDecoratio(border: Border.all()),
            child: Padding(
              padding: const EdgeInsets.all(4.0),
              child: FittedBox(
                  child: Text(
                "\Rs ${widget.transaction.amount.toStringAsFixed(2)}",
                style: TextStyle(color: Colors.white),
              )),
            ),
          ),
        ),
        title: Padding(
            padding:
                const EdgeInsets.symmetric(vertical: 2.0, horizontal: 16.0),
            child: Text(
              widget.transaction.title,
              style: Theme.of(context).textTheme.headline6,
            )),
        subtitle: Padding(
            padding:
                const EdgeInsets.symmetric(vertical: 2.0, horizontal: 16.0),
            child: Text(DateFormat('dd-MMM-yyyy').format(widget.transaction.date),
                style: Theme.of(context).textTheme.headline6)),
        trailing: IconButton(
          icon: Icon(Icons.delete),
          color: Theme.of(context).errorColor,
          onPressed: () => widget.delete(widget.transaction.id),
        ),
      ),
    );
  }
}

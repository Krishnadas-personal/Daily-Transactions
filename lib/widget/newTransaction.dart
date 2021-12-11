import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class NewTransaction extends StatefulWidget {
  final Function newTx;
  NewTransaction(this.newTx);

  @override
  _NewTransactionState createState() => _NewTransactionState();
}

class _NewTransactionState extends State<NewTransaction> {
  TextEditingController _titleInput = TextEditingController();

  TextEditingController _amtInput = TextEditingController();
  DateTime _selectedDate;

  @override
  void newtrans() {
    
    if(_amtInput.text.isEmpty){
      return;
    }
    final title_input = _titleInput.text;
    final amount_input = double.parse(_amtInput.text);
    if (title_input.isEmpty || amount_input < 0|| _selectedDate==null) {
      return;
    }

    widget.newTx(title_input, amount_input,_selectedDate);

    Navigator.pop(context);
  }

  void _presentDatePicker() {
    showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2021),
      lastDate: DateTime.now(),
    ).then((pickedDate) {
      if (pickedDate == null) {
        return;
      }
      setState(() {
        _selectedDate = pickedDate;
      });
    });
  }

  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Card(
        elevation: 2.0,
        child: Container(
          height: 350,
          margin: EdgeInsets.all(6.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              TextField(
                controller: _titleInput,
                decoration: InputDecoration(labelText: "Title"),
                onSubmitted: (_) => newtrans(),
              ),
              TextField(
                controller: _amtInput,
                decoration: InputDecoration(labelText: "Amount"),
                onSubmitted: (_) => newtrans(),
                keyboardType: TextInputType.number,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  (_selectedDate == null)
                      ? Text('No Date Chosen')
                      : Text(DateFormat('dd-MMM-yyyy').format(_selectedDate)),
                  FlatButton(
                      onPressed: _presentDatePicker,
                      child: Text(
                        "Choose Date",
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Theme.of(context).primaryColor),
                      ))
                ],
              ),
              FlatButton(
                onPressed: newtrans,
                // color: Theme.of(context).primaryColor,
                child: Text(
                  "Add Transaction",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Theme.of(context).primaryColor,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

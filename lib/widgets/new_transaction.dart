import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'dart:io';

import 'package:personal_expenses/widgets/adapative_flat_button.dart';

class NewTransaction extends StatefulWidget {
  NewTransaction(this.addTx);
  final Function addTx;

  @override
  State<NewTransaction> createState() => _NewTransactionState();
}

class _NewTransactionState extends State<NewTransaction> {
  final _titleControllor = TextEditingController();

  final _amountControllor = TextEditingController();
  DateTime? _selectedDate;
  void submitData() {
    if (_amountControllor.text.isEmpty) {
      return;
    }
    final enteredTitle = _titleControllor.text;
    final enteredAmount = double.parse(_amountControllor.text);
    if (enteredTitle.isEmpty || enteredAmount <= 0 || _selectedDate == null)
      return;
    widget.addTx(
      enteredTitle,
      enteredAmount,
      _selectedDate,
    );
    Navigator.of(context).pop();
  }

  void _presentDatePiker() {
    showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2022),
      lastDate: DateTime.now(),
    ).then((pikedDate) {
      if (pikedDate == null) {
        return;
      }
      setState(() {
        _selectedDate = pikedDate;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Card(
        elevation: 5.0,
        child: Container(
          padding: EdgeInsets.only(
            top: 10.0,
            left: 10.0,
            right: 10.0,
            bottom: MediaQuery.of(context).viewInsets.bottom + 10,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              TextField(
                decoration: InputDecoration(
                  labelText: 'Title',
                ),
                controller: _titleControllor,
                onChanged: (value) {
                  // _titleInput = value;
                },
              ),
              TextField(
                decoration: InputDecoration(
                  labelText: 'Amount',
                ),
                keyboardType: TextInputType.number,
                controller: _amountControllor,
                onSubmitted: (_) => submitData(),
              ),
              Container(
                height: 70,
                child: Row(
                  children: [
                    Expanded(
                      child: Text(_selectedDate == null
                          ? 'No Date Chosen'
                          : 'Picked Date ${DateFormat.yMd().format(_selectedDate!)}'),
                    ),
                    AdaptiveFlatButton('Choose Date', _presentDatePiker),
                  ],
                ),
              ),
              RaisedButton(
                onPressed: submitData,
                child: Text(
                  'Add transaction',
                ),
                color: Theme.of(context).primaryColor,
                textColor: Colors.white,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

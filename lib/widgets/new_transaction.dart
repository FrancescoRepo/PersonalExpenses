import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class NewTransaction extends StatefulWidget {
  NewTransaction({Key key, this.addTransactionHandler}) : super(key: key);

  final Function addTransactionHandler;

  @override
  _NewTransactionState createState() => _NewTransactionState();
}

class _NewTransactionState extends State<NewTransaction> {
  final _titleController = new TextEditingController();
  final _amountController = new TextEditingController();
  final _dateController = new TextEditingController();
  DateTime _selectedDate;

  void _submitData() {
    final title = _titleController.text;

    if (title.isEmpty) return;
    if (_amountController.text.isEmpty) return;
    if (_selectedDate == null) return;

    final amount = double.parse(_amountController.text);

    widget.addTransactionHandler(title, amount, _selectedDate);

    Navigator.of(context).pop();
  }

  void _presentDatePicker() {
    showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2020),
      lastDate: DateTime.now(),
    ).then((pickedDate) {
      if (pickedDate == null) return;
      _dateController.text = DateFormat.yMd().format(pickedDate);
      setState(() {
        _selectedDate = pickedDate;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Card(
        elevation: 4,
        child: Container(
          padding: EdgeInsets.only(
            top: 10,
            left: 10,
            right: 10,
            bottom: MediaQuery.of(context).viewInsets.bottom + 10,
          ),
          child: Column(
            children: [
              TextField(
                decoration: InputDecoration(
                  labelText: "Title",
                ),
                controller: _titleController,
                onSubmitted: (_) => _submitData,
              ),
              TextField(
                decoration: InputDecoration(
                  labelText: "Amount",
                ),
                controller: _amountController,
                keyboardType: TextInputType.number,
                onSubmitted: (_) => _submitData,
              ),
              Container(
                height: 70,
                child: TextField(
                  decoration: InputDecoration(
                    labelText: "Date",
                    suffixIcon: Icon(Icons.date_range),
                  ),
                  textInputAction: TextInputAction.none,
                  onTap: _presentDatePicker,
                  readOnly: true,
                  controller: _dateController,
                ),
              ),
              RaisedButton(
                elevation: 4,
                onPressed: _submitData,
                child: Text("Add Transaction"),
                color: Theme.of(context).primaryColor,
                textColor: Colors.white,
              )
            ],
          ),
        ),
      ),
    );
  }
}

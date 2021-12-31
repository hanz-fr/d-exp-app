import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:udemy_expenses_app/widgets/dropdownbutton.dart';




class NewTransaction extends StatefulWidget {
  final Function addTX;
  NewTransaction(this.addTX);

  @override
  _NewTransactionState createState() => _NewTransactionState();
}

class _NewTransactionState extends State<NewTransaction> {
  final _titleController = TextEditingController();
  final _amountController = TextEditingController();
  DateTime? _selectedDate;

  void _submitTx() {
    final enteredTitle = _titleController.text;
    final enteredAmount = double.parse(_amountController.text);

    if (_amountController.text.isEmpty){
      return;
    }

    if (enteredTitle.isEmpty || enteredAmount <= 0 || _selectedDate == null) {
      return;
    }

    widget.addTX(
      enteredTitle,
      enteredAmount,
      _selectedDate,
    );

    Navigator.of(context).pop();
  }

  void _presentDatePicker() {
    showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime.now()
    ).then((pickedDate) {
      if (pickedDate ==  null) {
        return;
        }
      setState(() {
        _selectedDate = pickedDate;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(22),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: <Widget>[
          TextField(
            maxLength: 26,
            style: TextStyle(fontSize: 20),
            decoration: InputDecoration(
              labelText: 'Title',
              hintText: 'Item name',
            ),
            controller: _titleController,
            keyboardType: TextInputType.text,
            onSubmitted: (_) => _submitTx(),
          ),
          TextField(
            style: TextStyle(fontSize: 20),
            decoration:
                InputDecoration(labelText: 'Amount', hintText: 'Price (\$)'),
            controller: _amountController,
            keyboardType: TextInputType.number,
            onSubmitted: (_) => _submitTx(),
          ),
          SizedBox(
            height: 5,
          ),
          Row(
            children: <Widget>[
              Expanded(
                child: Text(
                  _selectedDate == null ? 'Date : ' : 'Date : ${DateFormat.yMd().format(_selectedDate!)}',
                  style: TextStyle(fontSize: 16),
                ),
              ),
              TextButton(
                onPressed: _presentDatePicker,
                child: Text(
                  'Choose Date',
                  style: TextStyle(color: Colors.blue[700], fontSize: 17),
                ),
              ),
              
            ],
          ),
          Row(
            children: [
              Expanded(
                child: Text(
                  "Title Color : ",
                  style: TextStyle(fontSize: 16)
                ),
              ),
              DropBtn(),
            ],
          ),
          Flexible(
            fit: FlexFit.tight,
            child: Container(
              margin: EdgeInsets.only(right: 5),
              padding: EdgeInsets.only(top: 80, bottom: 20),
              child: OutlinedButton(
                style: OutlinedButton.styleFrom(
                    side: BorderSide(color: Colors.blue.shade700)),
                onPressed: _submitTx,
                child: Text(
                  'ADD',
                  style: TextStyle(
                    fontSize: 20,
                    color: Colors.blue[700],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

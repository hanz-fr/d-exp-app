import 'dart:math';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:udemy_expenses_app/pages/tx_info.dart';


import '../models/transaction.dart';



class TransactionItem extends StatefulWidget {
  const TransactionItem({
    Key? key,
    required this.transaction,
    required this.deleteTx,
  }) : super(key: key);

  final Transaction transaction;
  final Function deleteTx;

  @override
  _TransactionItemState createState() => _TransactionItemState();
}

class _TransactionItemState extends State<TransactionItem> {
  Color ?_bgColor;
  Color ?_pickColor1;
  Color ?_pickColor2;
  Color ?_pickColor3;


  @override
  void initState() {
    super.initState();
    const availableColors = [
      Color.fromRGBO(255, 0, 149, 100),
      Color.fromRGBO(0, 200, 255, 100),
      Color.fromRGBO(255, 174, 0, 100),
    ];

    _bgColor = availableColors[Random().nextInt(3)];
    _pickColor1 = availableColors[0];
    _pickColor2 = availableColors[1];
    _pickColor3 = availableColors[2];
  }

  
  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 1.5,
      margin: EdgeInsets.symmetric(vertical: 3, horizontal: 5),
      child: ListTile(
        onTap: () {
          Navigator.push(context,
              MaterialPageRoute(builder: (context) {
            return TxDetails();
          }));
        },
        leading: Container(
          margin: EdgeInsets.symmetric(
            vertical: 5.5,
            horizontal: 5.5,
          ),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(6),
            border: Border.all(
              color: Colors.green.shade600,
              width: 2,
            ),
          ),
          padding: EdgeInsets.all(6),
          child: Text(
            '\$ ${widget.transaction.amount.toStringAsFixed(2)}',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 20.5,
              color: Colors.green,
            ),
          ),
        ),
        title: Text(
          widget.transaction.title,
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 20,
            color: _bgColor
          ),
        ),
        subtitle: Text(
          DateFormat.yMMMEd().format(widget.transaction.date),
          style: TextStyle(
              color: Colors.grey,
              fontSize: 14.5,
              fontWeight: FontWeight.bold),
        ),
        trailing: PopupMenuButton<int>(
          elevation: 2,
          tooltip: "More",
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8)),
          itemBuilder: (context) => [
            PopupMenuItem(
              value: 1,
              child: Text("Delete"),
            ),
            PopupMenuItem(
              value: 2,
              child: Text("Duplicate"),
            ),
          ],
          onSelected: (value) {
            switch (value) {
              case 1:
                widget.deleteTx(widget.transaction.id);
                break;
              case 2:
            }
          },
        ),
      ),
    );
  }
}
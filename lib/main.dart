import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import './widgets/chart.dart';
import './widgets/new_transaction.dart';
import './widgets/transaction_list.dart';
import './models/transaction.dart';




void main() {
  SystemChrome.setPreferredOrientations(
    [
      // Set the app default orientation
      // In this case, the app default orientation is Portrait.
      DeviceOrientation.portraitDown,
      DeviceOrientation.portraitUp
    ],
  );
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primarySwatch: Colors.indigo,
        fontFamily: 'Abel',
        appBarTheme: AppBarTheme(
          textTheme: ThemeData.light().textTheme.copyWith(
            headline6: TextStyle(
              fontFamily: 'Abel',
              fontSize: 25,
            ),
          ),
        ),
      ),
      home: MyHomePage(),
    );
  }
}



class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> with WidgetsBindingObserver {

  // The list of Transactions, taken from 'transaction.dart'
  // Initial value is empty
  final List<Transaction> _userTransactions = [];



  // The App State listener
  // Create an app state listener
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance!.addObserver(this);
  }

  // Print the state of the app we are currently at
  @override
  void didChangeAppLifecycleState(AppLifecycleState state){
    print(state);
  }


  // Dispose app listener when not needed
  // to prevent memory leaks
  @override
  dispose() {
    WidgetsBinding.instance!.removeObserver(this);
    super.dispose();
  }



  List<Transaction> get _recentTransactions {
    return _userTransactions.where((tx) {
      return tx.date.isAfter(DateTime.now().subtract(
        Duration(days: 7),
      ));
    }).toList();
  }

  // Function to add new Transaction
  void _addNewTX(String txTitle, double txAmount, DateTime chosenDate) {
    final newTX = Transaction(
      title: txTitle,
      amount: txAmount,
      date: chosenDate,
      id: DateTime.now().toString(),
    );

    setState(() {
      _userTransactions.add(newTX);
    });
  }

  // Function to reset transactions (delete all transactions)
  void _clearTX() {
    setState(() {
      if (_userTransactions.length > 0) {
        _userTransactions.clear();
      } else {
        return;
      }
    });
  }

  // Function to show ModalBottomSheet
  void _startAddNewTransaction(BuildContext ctx) {
    showModalBottomSheet(
      context: ctx,
      builder: (_) {
        return NewTransaction(_addNewTX);
      },
    );
  }

  // Function to delete transaction
  void _deleteTx(String id) {
    setState(() {
      _userTransactions.removeWhere((tx) {
        return tx.id == id;
      });
    });
  }




  @override
  Widget build(BuildContext context) {
    final appBar = PreferredSize(
      preferredSize: Size.fromHeight(75),
      child: AppBar(
      actions: <Widget>[
        PopupMenuButton<int>(
          elevation: 2,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
          itemBuilder: (context) => [
            PopupMenuItem(
              value: 1,
              child: Text("Reset"),
            ),
          ],
          onSelected: (value) {
            _clearTX();
          },
        ),
      ],
      title: Text('D-Exp'),
    ),
    );
    return Scaffold(
      appBar: appBar,
      floatingActionButton: FloatingActionButton(
        elevation: 1.0,
        child: Icon(
          Icons.add_rounded,
          size: 30,
        ),
        onPressed: () => _startAddNewTransaction(context),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      body: SingleChildScrollView(
        child: Column(
          //mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Container(
              height: (MediaQuery.of(context).size.height -
                      appBar.preferredSize.height -
                      MediaQuery.of(context).padding.top) *
                  0.31,
              child: Chart(_recentTransactions),
            ),
            Container(
              height: (MediaQuery.of(context).size.height -
                      appBar.preferredSize.height -
                      MediaQuery.of(context).padding.top) *
                  0.45,
              child: TransactionList(_userTransactions, _deleteTx),
            ),
          ],
        ),
      ),
    );
  }
}

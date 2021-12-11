import 'package:daily_transactions/widget/transactionList.dart';

import './models/Transaction.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'widget/chart.dart';
import 'widget/newTransaction.dart';
// import 'package:flutter/services.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  // SystemChrome.setPreferredOrientations([
  //   DeviceOrientation.portraitUp,
  //   DeviceOrientation.portraitDown,
  // ]);
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        textTheme: ThemeData.light().textTheme.copyWith(
                headline6: TextStyle(
              fontFamily: 'RobotoCondensed',
              fontSize: 16.0,
            )),
        appBarTheme: AppBarTheme(
            textTheme: ThemeData.light().textTheme.copyWith(
                    headline6: TextStyle(
                  fontFamily: 'RobotoCondensed',
                  fontSize: 20.0,
                  fontWeight: FontWeight.bold,
                ))),
        primarySwatch: Colors.deepPurple,
        accentColor: Colors.amber,
      ),
      home: MyHomePage(title: 'Transaction'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  List<Transaction> transactions = [];
  bool showchart = false;
  void _addNewTransaction(String txTilte, double txAmount, DateTime date) {
    final newTransaction = Transaction(
        title: txTilte,
        amount: txAmount,
        date: date,
        id: DateTime.now().toString());
    setState(() {
      transactions.add(newTransaction);
    });
  }

  List<Transaction> get _recentTransactions {
    return (transactions.isNotEmpty)
        ? transactions.where((tx) {
            return tx.date.isAfter(DateTime.now().subtract(Duration(days: 7)));
          }).toList()
        : [];
  }

  void startNewTransaction(BuildContext context) {
    showModalBottomSheet(
        context: context,
        builder: (_) {
          return GestureDetector(
            child: NewTransaction(_addNewTransaction),
            // behavior: ,
          );
        });
  }

  void deleteTransaction(String id) {
    setState(() {
      transactions.removeWhere((element) => element.id == id);
    });
  }

  @override
  Widget build(BuildContext context) {
    final mediaquery = MediaQuery.of(context);
    final isLandscape = mediaquery.orientation == Orientation.landscape;
    final appBar = AppBar(
      title: Text(
        'YOUR DAILY TRANSACTION',
      ),
      actions: [
        IconButton(
            icon: Icon(Icons.add),
            onPressed: () => startNewTransaction(context))
      ],
    );
    final txList = Container(
      height: (mediaquery.size.height * 0.7 -
          appBar.preferredSize.height -
          mediaquery.padding.top),
      child:
          TransactionList(transaction: transactions, delete: deleteTransaction),
    );

   List <Widget> buildLandscape() {
      return [Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text("Show Chart"),
          Switch(
              value: showchart,
              onChanged: (value) {
                setState(() {
                  showchart = value;
                });
              })
        ],
      ), showchart
                  ? Container(
                      height: (mediaquery.size.height * 0.4 -
                          appBar.preferredSize.height -
                          mediaquery.padding.top),
                      child: Chart(_recentTransactions),
                    )
                  : txList];
    }

    List<Widget> buildPortrait() {
      return [Container(
        height: (mediaquery.size.height * 0.4 -
            appBar.preferredSize.height -
            mediaquery.padding.top),
        child: Chart(_recentTransactions),
      ),txList];
    }

    return Scaffold(
      appBar: appBar,
      body: Column(crossAxisAlignment: CrossAxisAlignment.stretch,
          // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            if (isLandscape) ...buildLandscape(),
            if (!isLandscape) ...buildPortrait(),       
          ]),
      floatingActionButton: FloatingActionButton(
          child: Icon(Icons.add),
          onPressed: () => startNewTransaction(context)),
    );
  }
}

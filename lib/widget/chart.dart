import 'package:flutter/material.dart';
import '../models/Transaction.dart';
import 'package:intl/intl.dart';
import'./chartBar.dart';


class Chart extends StatelessWidget {
  final List<Transaction> recentTransactions;

  Chart(this.recentTransactions);
 
List<Map<String,Object>> get groupedTransactionValues {
 return List.generate(7,(index){
final weekDay =DateTime.now().subtract(Duration(days:index));
double totalSum =0.0;
for(int i=0;i<recentTransactions.length;i++){
  if(recentTransactions[i].date.day==weekDay.day &&
    recentTransactions[i].date.month==weekDay.month &&
    recentTransactions[i].date.year==weekDay.year){

      totalSum +=recentTransactions[i].amount;
      // print(totalSum);
      // print(weekDay);

  } 
}

return {'day':DateFormat.E().format(weekDay),'amount':totalSum};
 }).reversed.toList();
}

double get totalspending{
  return groupedTransactionValues.fold(0.0,(sum,item){
    return sum +item['amount'];

  });
}


  @override
  Widget build(BuildContext context) {
    print(groupedTransactionValues);
    return Card(
      elevation:6.0,
      margin:EdgeInsets.all(10.0),
      child: Padding(padding: EdgeInsets.all(10.0),child:Row(
        mainAxisAlignment:MainAxisAlignment.spaceAround,
        children:
 groupedTransactionValues.map((data){
 return Flexible( fit:FlexFit.tight, child: ChartBar(label:data['day'],amount:data['amount'],percentage:(totalspending==0.0)?0.0: (data['amount'] as double)/ totalspending));
  }).toList()    
      )) 
      
    );
  }
}
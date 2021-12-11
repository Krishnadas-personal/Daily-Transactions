import 'package:flutter/material.dart';

class ChartBar extends StatelessWidget {
  final label;
  final amount;
  final percentage;

  const ChartBar({Key key, this.label, this.amount, this.percentage})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context,constraints){
return Column(
      children: [
        Container(
          height: constraints.maxHeight *0.1,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 3.0),
            child: FittedBox(
              child: Text(amount.toString()),
            ),
          ),
        ),
        SizedBox(height: constraints.maxHeight *0.05,),
        Container(
          width: 15,
          height: constraints.maxHeight *0.7,
          // color: Colors.black,
          child: Stack(
            children: [
              Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8.0),
                    color: Color.fromRGBO(221, 221, 221, 1)),
              ),
              FractionallySizedBox(
                heightFactor: percentage,
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8.0),
                    color: Theme.of(context).primaryColor,
                  ),
                ),
              )
            ],
          ),
        ),
         SizedBox(height: constraints.maxHeight *0.05),
        Container(height: constraints.maxHeight *0.1, child: FittedBox(child: Text(label))),
      ],
    );
    });
    
    
  }
}

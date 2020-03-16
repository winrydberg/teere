import 'dart:ffi';

import "package:flutter/material.dart";

class ExpenditureScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return ExpenditureScreenState();
  }
}

class ExpenditureScreenState extends State<ExpenditureScreen> {
  String item;
  String qty;
  String unitcost;
  String totalcost;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Add Expenditure"),
        centerTitle: true,
      ),
      body: Container(
        child: Card(
            child: Container(
          margin: const EdgeInsets.all(10.0),
          child: Column(mainAxisSize: MainAxisSize.min, children: <Widget>[
            TextField(
              decoration: InputDecoration(
                labelText: 'Item Name',
                hintText: 'Enter Item',
              ),
              onChanged: (value) {
                print(value);
                setState(() {
                  item = value;
                });
              },
            ),

            // Container(
            //   margin: const EdgeInsets.all(5),
            // ),
            TextField(
              decoration: InputDecoration(
                labelText: 'Quantity',
                hintText: 'Enter Quantity',
              ),
              onChanged: (value) {
                setState(() {
                  qty = value;
                });
              },
            ),

            Row(
              children: <Widget>[
                Expanded(
                  flex: 1,
                  child: TextField(
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                      labelText: "Unit Cost",
                      hintText: 'Enter Unit Cost',
                    ),
                    onChanged: (value) {
                      setState(() {
                        unitcost = value;
                      });
                    },
                  ),
                ),
                Expanded(
                  flex: 1,
                  child: TextField(
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                      labelText: 'Total Cost',
                      hintText: 'Enter Total Cost',
                    ),
                    onChanged: (value) {
                      setState(() {
                        totalcost = value;
                      });
                    },
                  ),
                )
              ],
            ),

            Container(
              width: double.infinity,
              child: RaisedButton(
                onPressed: () {
                  print(item);
                  Navigator.pop(context, {"item": item, "qty": qty, "unitcost":unitcost,"totalcost": totalcost});
                },
                child: Text('ADD EXPENDITURE'),
              ),
            ),
          ]),
        )),
      ),
    );
  }
}

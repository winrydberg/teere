import 'package:flutter/material.dart';

// Adapted from the data table demo in offical flutter gallery:
// https://github.com/flutter/flutter/blob/master/examples/flutter_gallery/lib/demo/material/data_table_demo.dart
class ApplicantScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return ApplicantScreenState();
  }
}

class ApplicantScreenState extends State<ApplicantScreen> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 20.0),
      child: Column(
        children: <Widget>[
          Container(
            margin: const EdgeInsets.only(left: 5.0),
            child: Align(
              alignment: Alignment.centerLeft,
              child: Text("Applicant's History", style: TextStyle(fontWeight: FontWeight.bold),)),),
          Container(
            decoration: BoxDecoration(
              // border: Border.all(color: Colors.blueAccent)
            ),
            child: Column(
              children: <Widget>[
                    heading(),
                    ItemRow(),
              ],
            ),
          )
          
        ],
      ),
    );
  }

  Widget heading() {
    return Container(
      height: 40.0,
      margin: const EdgeInsets.only(top:5.0, left:5.0, right: 5.0),
      decoration: BoxDecoration(
        color: Colors.lightBlue[800],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Expanded(
            flex: 1,
              child: Center(child: Text("Amount", style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),)),
          ),
          Expanded(
            flex: 1,
              child: Center(child: Text("Date Applied", style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),)),
          ),
           Expanded(
            flex: 1,
              child: Center(child: Text("Status", style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),)),
          ),
        ],
      ),
    );
  }

    Widget ItemRow() {
    return Container(
      margin: const EdgeInsets.only(left: 5.0, right: 5.0),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.lightBlue[800],)
      ),
      child: Row(
        children: <Widget>[
          Expanded(
            flex: 1,
                    child: Container(
                      height: 30,
              child: Center(child: Text("GHC 1000.00")),
            ),
          ),
          Expanded(
            flex:1,
                    child: Container(
                       height: 30,
              child: Center(child: Text("1/02/2010")),
            ),
          ),
          Expanded(
            flex:1,
                    child: Container(
                       height: 30,
              child: Center(child: Text("Pending")),
            ),
          )
        ],
      ),
    );
  }
}

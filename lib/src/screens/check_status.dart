import 'package:dfmc/src/components/applicant.dart';
import "package:flutter/material.dart";

class StatusScreen extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    return StatusScreeState();
  }

}

class StatusScreeState extends State<StatusScreen>{
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: Text("Application Status"),
        centerTitle: true,
      ),
      body: Container(
        child: ApplicantScreen()
      ),
    );
  }
  
}
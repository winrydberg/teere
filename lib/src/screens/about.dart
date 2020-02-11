import 'package:flutter/material.dart';

class AboutScreen extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("About App"),
        centerTitle: true,
      ),

      body: Container(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Container(
                height: 100,
                child: Image(image: AssetImage('lib/assets/images/logo.jpeg'))),
              Container(
                margin: const EdgeInsets.all(10.0),
              ),
              Text("Teere DFMC App", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
              Text("Version 1.0.0")
            ],
          ),
        ),
      ),
    );
  }

}
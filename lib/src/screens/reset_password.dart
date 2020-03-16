import 'dart:async';
import 'dart:ui';

import 'package:dfmc/src/providers/appsate.dart';
import 'package:dfmc/src/screens/home.dart';
import 'package:dfmc/src/screens/register.dart';
import 'package:flutter/material.dart';
import 'package:dfmc/src/mixins/validation_mixin.dart';
import 'package:provider/provider.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

class ResetPasswordScreen extends StatefulWidget {

  final String phoneno;
  ResetPasswordScreen(this.phoneno);
  @override
  State<StatefulWidget> createState() {
    return ResetPasswordScreenState();
  }
}

class ResetPasswordScreenState extends State<ResetPasswordScreen> with ValidationMixin {
  //creates a reference to the formstate of the form
  final FirebaseMessaging _firebaseMessaging = FirebaseMessaging();
  final formKey = GlobalKey<FormState>();
  final GlobalKey<ScaffoldState> _scafoldKey = GlobalKey<ScaffoldState>();
  String phoneno = '';
  // String password = '';
  String devicetoken = '';

  String code = '';
  String password = '';
  String repeatpassword = '';



  @override
  void initState() {
    super.initState();
    phoneno = widget.phoneno;
  }

  @override
  Widget build(BuildContext context) {
    final appState = Provider.of<AppState>(context);
    return Scaffold(
      key: _scafoldKey,
      appBar: AppBar(
        title: Text("Reset Password"),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Container(
          margin: const EdgeInsets.only(top: 30.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Container(
                margin: const EdgeInsets.all(10.0),
                // child: SingleChildScrollView(
                child: Form(
                  key: formKey,
                  child: loginDetails(appState),
                ),
                // ),
              ),
              Container(
                margin: const EdgeInsets.only(bottom: 20),
              ),
              newUser(context),
            ],
          ),
        ),
      ),
    );
  }

  Widget loginDetails(AppState appState) {
    return Container(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          appName(),
          Container(
            margin: const EdgeInsets.only(bottom: 20),
          ),
          codeField(),

          passwordField(),

          repeatPasswordField(),
    
          Container(
            margin: EdgeInsets.only(top: 25.0),
          ),
          btnField(appState),
        ],
      ),
    );
  }

  Widget logo() {
    return Container(
      // margin: EdgeInsets.only(top: 100.0),
      width: 110.0,
      child: Image(image: AssetImage('lib/assets/images/logo.jpeg')),
    );
  }

  appName() {
    return Container(
      child: Column(
        children: <Widget>[
          logo(),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Container(
                width: 70,
                height: 10,
                decoration: BoxDecoration(color: Colors.red),
              ),
              Container(
                width: 70,
                height: 10,
                decoration: BoxDecoration(color: Colors.yellow),
              ),
              Container(
                width: 70,
                height: 10,
                decoration: BoxDecoration(color: Colors.green),
              )
            ],
          )
        ],
      ),
    );
  }

  Widget codeField() {
    return TextFormField(
      keyboardType: TextInputType.number,
      decoration: InputDecoration(
        labelText: 'Reset Code',
        hintText: 'Enter Reset Code',
      ),
      validator: (String value){
          if(value == null || value ==""){
             return "Please enter reset code";
          }else{
            return null;
          }
      },
      onChanged: (String value) {
        setState(() {
          code = value;
        });
      },
    );
  }

  Widget passwordField() {
    return TextFormField(
      decoration: InputDecoration(
        labelText: 'New Password',
        hintText: 'Enter New Password',
      ),
      validator: validatePassword,
      onChanged: (String value) {
        setState(() {
          password = value;
        });
      },
    );
  }

    Widget repeatPasswordField() {
    return TextFormField(
      decoration: InputDecoration(
        labelText: 'Repeat Password',
        hintText: 'Repeat Password',
      ),
      validator: (String confirmpassword){
        if(confirmpassword != password){
            return "Repeat Password must match password";
        }else{
          return null;
        }
      },
      onChanged: (String value) {
        setState(() {
          repeatpassword = value;
        });
      },
    );
  }


  Widget btnField(AppState appState) {
    return Container(
      width: double.infinity,
      height: 50.0,
      child: RaisedButton(
        onPressed: () async {
          if (formKey.currentState.validate()) {
            formKey.currentState.save();
            loadingBar();
            appState.resetPassword(phoneno, code, password,repeatpassword).then((response) {
              _scafoldKey.currentState.removeCurrentSnackBar();
              if (response['status'] == 'success') {
                showResetSuccess(response['message']);

                Future.delayed(const Duration(milliseconds: 1500), () {
                 Navigator.of(context).pop(); 
                });
               
                
              } else {
                showLoginError("Unable to Login. Please try again");
              }
            });
          }
        },
        color: Colors.blue,
        child: Text(
          "RESET PASSWORD",
          style: TextStyle(color: Colors.white),
        ),
      ),
    );
  }

  newUser(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(10.0),
      child: Row(
        children: <Widget>[
          Text('Remembered Password'),
          Expanded(
            child: RaisedButton(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20.0)),
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('LOGIN HERE'),
            ),
          )
        ],
      ),
    );
  }

  loadingBar() {
    _scafoldKey.currentState.removeCurrentSnackBar();
    _scafoldKey.currentState.showSnackBar(new SnackBar(
      backgroundColor: Color(0xFF1DAE3A),
      duration: new Duration(minutes: 1),
      content: new Row(
        children: <Widget>[
          new CircularProgressIndicator(),
          new Text(
            "  Resetting Password...",
            style: TextStyle(color: Colors.white),
          )
        ],
      ),
    ));
  }

  showLoginError(String message) {
    return _scafoldKey.currentState.showSnackBar(new SnackBar(
      backgroundColor: Colors.red,
      duration: new Duration(seconds: 10),
      content: new Row(
        children: <Widget>[
          new Icon(Icons.close),
          new Text(
            " $message ",
            style: TextStyle(color: Colors.white),
          )
        ],
      ),
    ));
  }

    showResetSuccess(String message) {
    return _scafoldKey.currentState.showSnackBar(new SnackBar(
      backgroundColor: Colors.green,
      duration: new Duration(seconds: 10),
      content: new Row(
        children: <Widget>[
          new Icon(Icons.close),
          new Text(
            " $message ",
            style: TextStyle(color: Colors.white),
          )
        ],
      ),
    ));
  }

}

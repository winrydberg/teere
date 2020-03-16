import 'package:dfmc/src/providers/appsate.dart';
import 'package:dfmc/src/screens/home.dart';
import 'package:dfmc/src/screens/register.dart';
import 'package:dfmc/src/screens/reset_password.dart';
import 'package:flutter/material.dart';
import 'package:dfmc/src/mixins/validation_mixin.dart';
import 'package:provider/provider.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

class ForgotPasswordScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return ForgotPasswordScreenState();
  }
}

class ForgotPasswordScreenState extends State<ForgotPasswordScreen> with ValidationMixin {
  //creates a reference to the formstate of the form
  final FirebaseMessaging _firebaseMessaging = FirebaseMessaging();
  final formKey = GlobalKey<FormState>();
  final GlobalKey<ScaffoldState> _scafoldKey = GlobalKey<ScaffoldState>();
  String phoneno = '';
  String password = '';
  String devicetoken = '';

  @override
  void initState() {
    super.initState();
    _firebaseMessaging.getToken().then((token) {
      devicetoken = token;
      print(devicetoken);
    });
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
          phoneField(),
    
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

  Widget phoneField() {
    return TextFormField(
      keyboardType: TextInputType.phone,
      decoration: InputDecoration(
        labelText: 'Phone No',
        hintText: '0245424859',
      ),
      validator: validatePhoneNo,
      onChanged: (String value) {
        setState(() {
          phoneno = value;
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
            appState.forgotPassword(phoneno).then((response) {
              _scafoldKey.currentState.removeCurrentSnackBar();
              if (response['status'] == 'success') {
                Navigator.pushReplacement(context,
                    MaterialPageRoute(builder: (context) => ResetPasswordScreen(response['phoneno'])));
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
            "  Signing-In...",
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

}

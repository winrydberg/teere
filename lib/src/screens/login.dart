import 'package:dfmc/src/providers/appsate.dart';
import 'package:dfmc/src/screens/home.dart';
import 'package:dfmc/src/screens/register.dart';
import 'package:flutter/material.dart';
import 'package:dfmc/src/mixins/validation_mixin.dart';
import 'package:provider/provider.dart';

class LoginScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return LoginScreenState();
  }
}

class LoginScreenState extends State<LoginScreen> with ValidationMixin {
  //creates a reference to the formstate of the form

  final formKey = GlobalKey<FormState>();
  final GlobalKey<ScaffoldState> _scafoldKey = GlobalKey<ScaffoldState>();
  String phoneno = '';
  String password = '';

  @override
  Widget build(BuildContext context) {
    final appState = Provider.of<AppState>(context);
    return Scaffold(
      key: _scafoldKey,
      appBar: AppBar(
        title: Text("Login Here"),
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
          passwordField(),
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

  Widget passwordField() {
    return TextFormField(
      obscureText: true,
      decoration: InputDecoration(
        labelText: 'Enter Password',
        hintText: 'Your Password',
      ),
      validator: validatePassword,
      onChanged: (String value) {
        setState(() {
          password = value;
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
            appState.loginUser(phoneno, password).then((response) {
              
              _scafoldKey.currentState.removeCurrentSnackBar();
              if (response == true) {
                Navigator.pushReplacement(context,
                    MaterialPageRoute(builder: (context) => HomeScreen()));
              } else {
                showLoginError("Unable to Login. Please try again");
              }
            });
          }
        },
        color: Color(0xFF6B1024),
        child: Text(
          "LOGIN",
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
          Text('Dont have an account?'),
          Expanded(
            child: RaisedButton(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20.0)),
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (conttext) => RegisterScreen()));
              },
              child: Text('SIGN UP'),
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

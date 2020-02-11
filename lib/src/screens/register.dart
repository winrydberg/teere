import 'package:dfmc/src/mixins/validation_mixin.dart';
import 'package:dfmc/src/providers/appsate.dart';
import 'package:dfmc/src/screens/home.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class RegisterScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return RegisterScreenState();
  }
}

class RegisterScreenState extends State<RegisterScreen> with ValidationMixin {
  final formKey = GlobalKey<FormState>();
  final GlobalKey<ScaffoldState> _scafoldKey = GlobalKey<ScaffoldState>();
  String email = '';
  String password = '';
  String confirmPassword = '';
  String firstname = '';
  String lastname = '';
  String phoneno = '';

  @override
  Widget build(BuildContext context) {
    final appState = Provider.of<AppState>(context);
    return Scaffold(
      key: _scafoldKey,
      appBar: AppBar(
        title: Text("Registration"),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Container(
              margin: const EdgeInsets.all(10.0),
              child: SingleChildScrollView(
                child: Form(
                  key: formKey,
                  child: userDetails(appState),
                ),
              ),
            ),
            member(context),
          ],
        ),
      ),
    );
  }

  Widget userDetails(AppState appState) {
    return Container(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          appName(),
          Container(
            margin: const EdgeInsets.only(bottom: 20),
          ),
          firstnameField(),
          lastnameField(),
          phonenoField(),
          emailField(),
          passwordField(),
          Container(
            margin: EdgeInsets.only(top: 25.0),
          ),
          btnField(appState),
        ],
      ),
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

  Widget firstnameField() {
    return TextFormField(
      decoration: InputDecoration(
        labelText: 'First Name',
        hintText: 'you@example.com',
      ),
      validator: validateFirstname,
      onChanged: (String value) {
        setState(() {
          firstname = value;
        });
      },
      onSaved: (String value) {},
    );
  }

  Widget lastnameField() {
    return TextFormField(
      decoration: InputDecoration(
        labelText: 'Surname',
        hintText: 'Enter Surname',
      ),
      validator: validateSurname,
      onChanged: (String value) {
        setState(() {
          lastname = value;
        });
      },
      onSaved: (String value) {},
    );
  }

  Widget phonenoField() {
    return TextFormField(
      keyboardType: TextInputType.phone,
      decoration: InputDecoration(
        labelText: 'Phone Number',
        hintText: 'Enter Phone Number',
      ),
      validator: validatePhoneNo,
      onChanged: (String value) {
        setState(() {
          phoneno = value;
        });
      },
      onSaved: (String value) {},
    );
  }

  Widget emailField() {
    return TextFormField(
      keyboardType: TextInputType.emailAddress,
      decoration: InputDecoration(
        labelText: 'Email Address',
        hintText: 'you@example.com',
      ),
      // validator: validateEmail,
      onChanged: (String value) {
        setState(() {
          email = value;
        });
      },
      onSaved: (String value) {},
    );
  }

  Widget passwordField() {
    return Row(
      children: <Widget>[
        Expanded(
          flex: 1,
          child: TextFormField(
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
            onSaved: (String value) {},
          ),
        ),
        Container(margin: const EdgeInsets.all(5.0)),
        Expanded(
          flex: 1,
          child: TextFormField(
            obscureText: true,
            decoration: InputDecoration(
              labelText: 'Confirm Password',
              hintText: 'Repeat Password',
            ),
            validator: (String value) {
              if (value != password) {
                return "Confirm Password does not match Password";
              }
              return null;
            },
            onChanged: (String value) {
              setState(() {
                confirmPassword = value;
              });
            },
            onSaved: (String value) {},
          ),
        )
      ],
    );
  }

  Widget btnField(AppState appState) {
    return Container(
      width: double.infinity,
      height: 50.0,
      child: RaisedButton(
       
        onPressed: () async {
          Map<String, dynamic> mapdata = {
            'firstname': firstname,
            'lastname': lastname,
            'email': email,
            'phoneno': phoneno,
            'password': password,
          };
          if (formKey.currentState.validate()) {
            formKey.currentState.save();
            loadingBar();
            appState.registerUser(mapdata).then((response) {
              _scafoldKey.currentState.removeCurrentSnackBar();
              if (response['success'] == true) {

                Navigator.pop(context);
              } else {
                showLoginError(response['message']);
              }
            });
          }

        },
        color: Color(0xFF6B1024),
        child: Text(
          "REGISTER",
          style: TextStyle(color: Colors.white),
        ),
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

  member(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(10.0),
      child: Row(
        children: <Widget>[
          Text('Already have an account?'),
          Expanded(
            child: RaisedButton(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20.0)),
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text('SIGN IN'),
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
            "  Registering...",
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

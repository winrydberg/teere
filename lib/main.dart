import 'package:dfmc/src/screens/home.dart';
import 'package:dfmc/src/screens/login.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:provider/provider.dart';
import 'src/providers/appsate.dart';


void main() => runApp(DFMCApp());

class DFMCApp extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    return DFMCAppState();
  }
}


class DFMCAppState extends State<DFMCApp> {

    final FirebaseMessaging _firebaseMessaging = FirebaseMessaging();


  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => AppState()),
      ],
    child: MaterialApp(
      //provides default theme for app globally
      theme: ThemeData(
        brightness: Brightness.light,
        primaryColor: Colors.blue,
        accentColor: Colors.cyan[600],
      ),
      debugShowCheckedModeBanner: false,
      home: chooseWidget(context),
    ),
    );
  }

  Widget chooseWidget(BuildContext context) {

  


    return FutureBuilder(
      future: getUser(),
      builder: (BuildContext context, AsyncSnapshot snapshot){
        if(snapshot.connectionState == ConnectionState.done){
            if(snapshot.data != null){
               return HomeScreen();
            }else{
               return LoginScreen();
            }
        }else{
          return Scaffold(
              body: Center(child: CircularProgressIndicator()),
          );
        }
      },
    );
    
  }

  Future<String> getUser() async{
    final _storage = new FlutterSecureStorage();
    String uuu = await _storage.read(key: "user");
    String _token = await _storage.read(key: "token");
    if(uuu != null && _token != null){
      return "OK";
    }else{
      return null;
    }
  }
}



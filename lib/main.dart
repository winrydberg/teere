import 'package:dfmc/src/screens/home.dart';
import 'package:flutter/material.dart';
// import 'package:dfmc/src/app.dart';
import 'package:provider/provider.dart';

import 'src/providers/appsate.dart';


void main() => runApp(DFMCApp());


class DFMCApp extends StatelessWidget {
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
        primaryColor: Color(0xFF6B1024),
        accentColor: Colors.cyan[600],
      ),
      debugShowCheckedModeBanner: false,
      home: HomeScreen(),
    ),
    );
  }

  Widget chooseWidget() {
    return HomeScreen();
  }
}



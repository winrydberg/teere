import 'package:dfmc/src/screens/home.dart';
import 'package:flutter/material.dart';
import 'package:dfmc/src/screens/login.dart';
import 'package:provider/provider.dart';
import 'package:dfmc/src/providers/appsate.dart';


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
      home: chooseWidget(),
    ),
    );
  }

  Widget chooseWidget() {
    return HomeScreen();
  }
}

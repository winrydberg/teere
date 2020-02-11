import 'dart:convert';
import 'package:dfmc/src/components/applicant.dart';
import 'package:dfmc/src/components/newapplocation.dart';
import 'package:dfmc/src/components/status.dart';
import 'package:dfmc/src/models/user.dart';
import 'package:dfmc/src/providers/appsate.dart';
import 'package:dfmc/src/providers/storage_provider.dart';
import 'package:dfmc/src/screens/about.dart';
import 'package:dfmc/src/screens/application.dart';
import 'package:dfmc/src/screens/check_status.dart';
import 'package:dfmc/src/screens/login.dart';
import 'package:dfmc/src/screens/profile.dart';
import 'package:flutter/material.dart';
import 'package:fab_circular_menu/fab_circular_menu.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';

class HomeScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return HomeScreenState();
  }
}

class HomeScreenState extends State<HomeScreen> {
  int _selectedIndex = 0;
  int _selection;
  BuildContext context;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    SStorageProvider.getTokeninState();
  }

  @override
  Widget build(BuildContext context) {
    context = context;
    double screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        title: Text('Teere'),
        actions: <Widget>[
          PopupMenuButton(onSelected: (dynamic selected) {
            if (selected == "1") {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => LoginScreen()));
            } else if (selected == "2") {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => AboutScreen()));
            } else if (selected == "3") {
              Scaffold.of(context).showSnackBar(SnackBar(
                content: Text("Rate us coming soon in next release"),
              ));
            }
          }, itemBuilder: (BuildContext context) {
            return [
              PopupMenuItem(
                child: Row(
                  children: <Widget>[
                    Icon(
                      Icons.power_settings_new,
                      color: Colors.red,
                    ),
                    Text("Logout"),
                  ],
                ),
                value: "1",
              ),
              PopupMenuItem(
                child: Row(
                  children: <Widget>[
                    Icon(
                      Icons.menu,
                      color: Colors.green,
                    ),
                    Text("About App"),
                  ],
                ),
                value: "2",
              ),
              PopupMenuItem(
                child: Row(
                  children: <Widget>[
                    Icon(
                      Icons.rate_review,
                      color: Colors.lightBlue,
                    ),
                    Text("Rate us"),
                  ],
                ),
                value: "3",
              ),
            ];
          }),
        ],
      ),
      body: pageNavigator(context).elementAt(_selectedIndex),

      // Container(
      //         child: FabCircularMenu(
      //         child: Container(

      //                             child: Center(
      //                 child: Padding(
      //                   padding: const EdgeInsets.only(bottom: 256.0),
      //                   child: Center(
      //                         child: _widgetOptions.elementAt(_selectedIndex),
      //                     ),

      //                 )
      //             ),

      //         ),
      //         ringDiameter: screenWidth * 0.7,
      //         ringColor: Color(0xFF6B1024),
      //         ringWidth: 100,
      //         options: <Widget>[
      //           IconButton(icon: Icon(Icons.share), onPressed: () {}, iconSize: 30.0, color: Colors.white),
      //           IconButton(icon: Icon(FontAwesomeIcons.facebook), onPressed: () {}, iconSize: 30.0, color: Color(0xFF3588EB)),
      //           IconButton(icon: Icon(FontAwesomeIcons.whatsapp), onPressed: () {}, iconSize: 30.0, color: Colors.green),
      //           IconButton(icon: Icon(FontAwesomeIcons.twitter), onPressed: () {}, iconSize: 30.0, color: Color(0xFF83D7FA)),
      //         ],

      //   ),
      // ),

      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            title: Text('Home'),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.notifications),
            title: Text('Notifications'),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            title: Text('Profile'),
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Color(0xFF6B1024),
        onTap: _onItemTapped,
      ),
    );
  }

  List<Widget> pageNavigator(BuildContext context) {
    List<Widget> _widgetOptions = <Widget>[
      home(context),
      Text(
        'Index 2: School',
      ),
      ProfileScreen(),
    ];

    return _widgetOptions;
  }

  static Widget home(BuildContext context) {
    return Container(
      // margin: const EdgeInsets.only(right: 50.0),
      child: Column(
        children: <Widget>[
          greeting(),
          // NewApplication(),
          Container(
            margin: const EdgeInsets.all(10.0),
          ),
          Expanded(
            flex: 1,
            child: Container(
                margin: const EdgeInsets.only(right: 40.0),
                child: Stack(
                  overflow: Overflow.visible,
                  alignment: AlignmentDirectional.topEnd,
                  children: <Widget>[
                    InkWell(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => ApplicationScreen()));
                      },
                      child: Container(
                        width: 350,
                        height: 100,
                        child: Center(
                            child: Container(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Text(
                                "APPLY NOW",
                                style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 20),
                              ),
                              Container(
                                  margin: const EdgeInsets.only(right: 20),
                                  child: Text(
                                    "Submit a new application",
                                    style: TextStyle(color: Colors.white),
                                  )),
                            ],
                          ),
                        )),
                        decoration: BoxDecoration(
                            shape: BoxShape.rectangle,
                            // image: DecorationImage(
                            //   image: AssetImage("lib/assets/images/top.png"),
                            //   fit: BoxFit.fitWidth,
                            //   alignment: Alignment.topCenter,
                            // ),
                            color: Colors.green,
                            borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(35.0),
                                bottomRight: Radius.circular(35.0))),
                      ),
                    ),
                    Positioned(
                      top: -10,
                      right: -45,
                      child: InkWell(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => ApplicationScreen()));
                        },
                        child: Container(
                          width: 90,
                          height: 90,
                          child: IconButton(
                            icon: Icon(
                              Icons.add_circle,
                              color: Colors.green,
                            ),
                            iconSize: 35,
                          ),
                          decoration: BoxDecoration(
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black87.withOpacity(0.4),
                                spreadRadius: 2,
                                blurRadius: 5,
                                offset:
                                    Offset(0, 0), // changes position of shadow
                              ),
                            ],
                            shape: BoxShape.circle,
                            color: Colors.white,
                            // backgroundBlendMode: BlendMode.color
                          ),
                        ),
                      ),
                    ),
                  ],
                )),
          ),

          Expanded(
            flex: 1,
            child: Container(
                margin: const EdgeInsets.only(right: 40.0),
                child: Stack(
                  overflow: Overflow.visible,
                  alignment: AlignmentDirectional.topEnd,
                  children: <Widget>[
                    Container(
                      width: 350,
                      height: 100,
                      child: Center(
                          child: Container(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Text(
                              "CHECK STATUS",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 20),
                            ),
                            Container(
                                margin: const EdgeInsets.only(right: 20),
                                child: Text(
                                  "Check the status of all applications on the go",
                                  style: TextStyle(color: Colors.white),
                                )),
                          ],
                        ),
                      )),
                      decoration: BoxDecoration(
                          shape: BoxShape.rectangle,
                          // image: DecorationImage(
                          //   image: AssetImage("lib/assets/images/top.png"),
                          //   fit: BoxFit.fitWidth,
                          //   alignment: Alignment.topCenter,
                          // ),
                          color: Colors.brown,
                          borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(35.0),
                              bottomRight: Radius.circular(35.0))),
                    ),
                    Positioned(
                      top: -10,
                      right: -45,
                      child: InkWell(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => StatusScreen()));
                        },
                        child: Container(
                          width: 90,
                          height: 90,
                          child: IconButton(
                            icon: Icon(
                              Icons.help,
                              color: Colors.brown,
                            ),
                            iconSize: 35,
                          ),
                          decoration: BoxDecoration(
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black87.withOpacity(0.4),
                                spreadRadius: 2,
                                blurRadius: 5,
                                offset:
                                    Offset(0, 0), // changes position of shadow
                              ),
                            ],
                            shape: BoxShape.circle,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ],
                )),
          )
        ],
      ),
    );
  }

  static Widget greeting() {
    DateTime now = new DateTime.now();
    print(now.hour);
    if (now.hour > 0 && now.hour < 12) {
      return FutureBuilder(
          future: getData(),
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            if (snapshot.data != null) {
              return Align(
                alignment: Alignment.centerLeft,
                child: Column(
                  children: <Widget>[
                    Container(
                      margin: const EdgeInsets.only(top: 10.0),
                      width: 100.0,
                      height: 100.0,
                      decoration: new BoxDecoration(
                        shape: BoxShape.circle,
                        image: new DecorationImage(
                          fit: BoxFit.fill,
                          image: AssetImage("lib/assets/images/user.png"),
                        ),
                      ),
                    ),
                    Container(
                      margin:
                          const EdgeInsets.only(left: 10, right: 10, top: 20.0),
                      height: 50.0,
                      width: double.infinity,
                      child: Center(
                        child: Text(
                          'Good Morning, Solomon',
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 15.0),
                        ),
                      ),
                    ),
                  ],
                ),
              );
            } else {
              return CircularProgressIndicator();
            }
          });
    } else if (now.hour > 12 && now.hour < 16) {
      return FutureBuilder(
          future: getData(),
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            if (snapshot.data != null) {
              return Align(
                alignment: Alignment.centerLeft,
                child: Column(
                  children: <Widget>[
                    Container(
                      margin: const EdgeInsets.only(top: 10.0),
                      width: 100.0,
                      height: 100.0,
                      decoration: new BoxDecoration(
                        shape: BoxShape.circle,
                        image: new DecorationImage(
                          fit: BoxFit.fill,
                          image: AssetImage("lib/assets/images/user.png"),
                        ),
                      ),
                    ),
                    Container(
                      margin:
                          const EdgeInsets.only(left: 10, right: 10, top: 20.0),
                      height: 50.0,
                      width: double.infinity,
                      child: Center(
                        child: Text(
                          'Good Afternoon, ${snapshot.data.firstname}',
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 15.0),
                        ),
                      ),
                    ),
                  ],
                ),
              );
            } else {
              return CircularProgressIndicator();
            }
          });
    } else {
      return FutureBuilder(
          future: getData(),
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            if (snapshot.data != null) {
              return Align(
                alignment: Alignment.center,
                child: Column(
                  children: <Widget>[
                    Container(
                      margin: const EdgeInsets.only(top: 10.0),
                      width: 100.0,
                      height: 100.0,
                      decoration: new BoxDecoration(
                        shape: BoxShape.circle,
                        image: new DecorationImage(
                          fit: BoxFit.fill,
                          image: AssetImage("lib/assets/images/user.png"),
                        ),
                      ),
                    ),
                    Container(
                      margin:
                          const EdgeInsets.only(left: 10, right: 10, top: 20.0),
                      height: 50.0,
                      width: double.infinity,
                      child: Center(
                        child: Text(
                          'Good Evening, ${snapshot.data.firstname}',
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 15.0),
                        ),
                      ),
                    ),
                  ],
                ),
              );
            } else {
              return CircularProgressIndicator();
            }
          });
    }
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  static Future<UserModel> getData({key}) async {
    final _storage = new FlutterSecureStorage();
    String value = await _storage.read(key: "user");
    Map<String, dynamic> usermap = json.decode(value);
    return UserModel.fromJson(usermap);
  }
}

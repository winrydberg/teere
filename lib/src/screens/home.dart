import 'dart:convert';
import 'package:dfmc/src/components/applicant.dart';
import 'package:dfmc/src/components/newapplocation.dart';
import 'package:dfmc/src/components/notifications.dart';
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
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

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

  // @override
  // void initState() {
  //   // TODO: implement initState
  //   super.initState();
  //   SStorageProvider.getTokeninState();
  // }
  

      final FirebaseMessaging _firebaseMessaging = FirebaseMessaging();

  @override
  void initState() {
    super.initState();
   
    _firebaseMessaging.configure(
      onMessage: (Map<String, dynamic> message) async {
        // _selectedIndex =1;
        print("onMessage: $message");
        // _showItemDialog(message);
      },
      // onBackgroundMessage: myBackgroundMessageHandler,
      onLaunch: (Map<String, dynamic> message) async {
        // _selectedIndex =1;
        print("onLaunch: $message");
        // _navigateToItemDetail(message);
      },
      onResume: (Map<String, dynamic> message) async {
        // _selectedIndex =1;
        print("onResume: $message");

        // _navigateToItemDetail(message);
      },
    );

     SStorageProvider.getTokeninState();
  }

  @override
  Widget build(BuildContext context) {
    context = context;
    double screenWidth = MediaQuery.of(context).size.width;
    final appState = Provider.of<AppState>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text('DFMC Mobile'),
        actions: <Widget>[
          PopupMenuButton(onSelected: (dynamic selected) {
            if (selected == "1") {
              final _storage = new FlutterSecureStorage();
              _storage.deleteAll();
              Navigator.pushReplacement(context,
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
      body: Container(
        margin: const EdgeInsets.only(top: 15.0),
        child: StaggeredGridView.count(
          crossAxisCount: 2,
          crossAxisSpacing: 12.0,
          mainAxisSpacing: 12.0,
          padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
          children: <Widget>[
            _buildTile(
              Padding
              (
              
                padding: const EdgeInsets.all(20.0),
                child: Row
                (
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>
                  [
                    Column
                    (
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>
                      [
                        Text('Total Applications', style: TextStyle(color: Colors.blueAccent)),
                        FutureBuilder(
                          future: appState.getTotalApplication(),
                          builder:  (BuildContext context, AsyncSnapshot snapshot){
                              if( snapshot.connectionState ==ConnectionState.done){
                                if(snapshot.data != null){
                                    return  Text('${snapshot.data}', style: TextStyle(color: Colors.black, fontWeight: FontWeight.w700, fontSize: 34.0));
                                }else{
                                   return  Text('0', style: TextStyle(color: Colors.black, fontWeight: FontWeight.w700, fontSize: 34.0));
                                }
                              }else{
                                return CircularProgressIndicator();
                              }
                          },
                        )
                       
                      ],
                    ),
                    Material
                    (
                      color: Colors.blue,
                      borderRadius: BorderRadius.circular(24.0),
                      child: Center
                      (
                        child: Padding
                        (
                          padding: const EdgeInsets.all(16.0),
                          child: Icon(Icons.timeline, color: Colors.white, size: 30.0),
                        )
                      )
                    )
                  ]
                ),
              ),
              onTap: () => Navigator.of(context).push(MaterialPageRoute(builder: (_) => StatusScreen())),
               
            ),
            _buildTile(
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column
                (
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>
                  [
                    Material
                    (
                      color: Colors.teal,
                      shape: CircleBorder(),
                      child: Padding
                      (
                        padding: const EdgeInsets.all(16.0),
                        child: Icon(Icons.add_circle_outline, color: Colors.white, size: 30.0),
                      )
                    ),
                    Padding(padding: EdgeInsets.only(bottom: 16.0)),
                    Text('New', style: TextStyle(color: Colors.black, fontWeight: FontWeight.w700, fontSize: 24.0)),
                    Text('New Application', style: TextStyle(color: Colors.black45)),
                  ]
                ),
              ),
               onTap: () => Navigator.of(context).push(MaterialPageRoute(builder: (_) => ApplicationScreen())),
               
            ),
            _buildTile(
              Padding
              (
                padding: const EdgeInsets.all(20.0),
                child: Column
                (
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>
                  [
                    Material
                    (
                      color: Colors.amber,
                      shape: CircleBorder(),
                      child: Padding
                      (
                        padding: EdgeInsets.all(16.0),
                        child: Icon(Icons.notifications, color: Colors.white, size: 30.0),
                      )
                    ),
                    Padding(padding: EdgeInsets.only(bottom: 16.0)),
                    Text('Alerts', style: TextStyle(color: Colors.black, fontWeight: FontWeight.w700, fontSize: 24.0)),
                    Text('View Notifications', style: TextStyle(color: Colors.black45)),
                  ]
                ),
              ),
               onTap: () => Navigator.of(context).push(MaterialPageRoute(builder: (_) => NotificationsScreen())),
               
            ),
          
            _buildTile(
              Padding
              (
                padding: const EdgeInsets.all(24.0),
                child: Row
                (
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>
                  [
                    Expanded(
                      flex: 5,
                                          child: Column
                      (
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>
                        [
                          Text('Hello, ', style: TextStyle(color: Colors.redAccent)),
                          FutureBuilder(
                            future: getData(),
                            builder: (BuildContext context, AsyncSnapshot snapshot){
                                if(snapshot.connectionState == ConnectionState.done){
                                     if(snapshot.data != null){
                                        return Column(
                                          mainAxisAlignment: MainAxisAlignment.start,
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: <Widget>[
                                            Align(
                                              alignment: Alignment.topLeft,
                                              child: Text('${snapshot.data.firstname}', style: TextStyle(color: Colors.black, fontWeight: FontWeight.w700, fontSize: 20.0)),
                                            ),

                                           Container(
                                             width: MediaQuery.of(context).size.width*0.5,
                                             child: Text('Welcome to DFMC Mobile App, Send Your Application Today.', style: TextStyle(color: Colors.black45))),
                                            
                                          ],
                                        );
                                     }else{
                                       return Text("Welcome .Send Your Application Today.");
                                     }
                                }else{
                                    return CircularProgressIndicator();
                                }
                            },
                          )
                          
                        ],
                      ),
                    ),
                    Material
                    (
                      borderRadius: BorderRadius.circular(24.0),
                      child: Center
                      (
                        child: Padding
                        (
                          padding: EdgeInsets.only(top:12.0, left: 16.0, bottom: 16.0),
                          child: Container(
                      margin: const EdgeInsets.only(top: 10.0),
                      width: 80.0,
                      height: 80.0,
                      decoration: new BoxDecoration(
                        shape: BoxShape.circle,
                        image: new DecorationImage(
                          fit: BoxFit.fill,
                          image: AssetImage("lib/assets/images/user.png"),
                        ),
                      ),
                    ),
                        )
                      )
                    )
                  ]
                ),
              ),

              onTap: () => Navigator.of(context).push(MaterialPageRoute(builder: (_) => ProfileScreen())),
               

            )
          ],
          staggeredTiles: [
            StaggeredTile.extent(2, 110.0),
            StaggeredTile.extent(1, 180.0),
            StaggeredTile.extent(1, 180.0),
            StaggeredTile.extent(2, 220.0),
            // StaggeredTile.extent(2, 110.0),
          ],
        ),
      )

    );
  }

  


  static Future<UserModel> getData({key}) async {
    final _storage = new FlutterSecureStorage();
    String value = await _storage.read(key: "user");
    Map<String, dynamic> usermap = json.decode(value);
    return UserModel.fromJson(usermap);
  }

   Widget _buildTile(Widget child, {Function() onTap}) {
    return Material(
      elevation: 14.0,
      borderRadius: BorderRadius.circular(12.0),
      shadowColor: Color(0x802196F3),
      child: InkWell
      (
        // Do onTap() if it isn't null, otherwise do print()
        onTap: onTap != null ? () => onTap() : () {
            print(onTap);
         },
        child: child
      )
    );
  }
}

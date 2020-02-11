import 'dart:convert';

import 'package:dfmc/src/models/user.dart';
import 'package:dfmc/src/providers/appsate.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:provider/provider.dart';

class ProfileScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return ProfileScreenState();
  }
}

class ProfileScreenState extends State<ProfileScreen> {
   final _storage = FlutterSecureStorage();
  @override
  Widget build(BuildContext context) {
    final appState = Provider.of<AppState>(context);
    // getUserinfo();
    Map<String, dynamic> user;
    return Container(
        child:  FutureBuilder(
          future: appState.getData(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.done) {
              if (snapshot.data != null) {
                return Container(
                  child: Column(
                    // shrinkWrap: true,
                    // padding: EdgeInsets.zero,
                    children: <Widget>[
                      Center(
                        child: logo(),
                      ),
                      ListTile(
                        //{snapshot.data.firstname} ${snapshot.data.lastname}
                        title: Text('NAME'),
                        subtitle: Text(
                            "${snapshot.data.firstname} ${snapshot.data.lastname}"),
                        leading: Icon(Icons.person),
                        onTap: () {},
                      ),
                      ListTile(
                        title: Text('EMAIL ADDRESS'),
                        subtitle: Text("${snapshot.data.email}"),
                        leading: Icon(Icons.email),
                        onTap: () {},
                      ),
                      ListTile(
                        title: Text('PHONE NUMBER'),
                        subtitle: Text("${snapshot.data.phoneno}"),
                        leading: Icon(Icons.call),
                        onTap: () {},
                      ),
                    ],
                  ),
                );
                //userProfile(),

              } else {
                return Text("Nulllllll");
              }
            } else {
              return CircularProgressIndicator();
            }
          },
        ),
    );
  }

  Widget logo() {
    return Center(
      child: Container(
        margin: const EdgeInsets.only(top: 10.0),
        width: 90.0,
        height: 90.0,
        decoration: new BoxDecoration(
          shape: BoxShape.circle,
          image: new DecorationImage(
            fit: BoxFit.fill,
            image: AssetImage("lib/assets/images/user.png"),
          ),
        ),
      ),
    );
  }

  Future<UserModel> getUserinfo() async {
    String data = await _storage.read(key: 'user');
    Map valueMap = json.decode(data);
    var muser = UserModel.fromJson(valueMap);
    print("==========${muser}");
    return muser;
  }
}

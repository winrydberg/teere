import 'package:dfmc/src/models/push_notification.dart';
import 'package:dfmc/src/providers/appsate.dart';
import 'package:dfmc/src/screens/check_status.dart';
import 'package:flutter/material.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

class NotificationsScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return NotificationsState();
  }
}

class NotificationsState extends State<NotificationsScreen> {
  @override
  Widget build(BuildContext context) {
    final appState = Provider.of<AppState>(context);

    return Scaffold(
        appBar: AppBar(
          title: Text('Notifications'),
          centerTitle: true,
        ),
        body: Container(
          child: FutureBuilder(
            future: appState.getNotifications(),
            builder: (BuildContext context, AsyncSnapshot snapshot) {
              if (snapshot.connectionState == ConnectionState.done) {
                List<PushNotification> pushnotifications = snapshot.data;
                if (pushnotifications != null) {
                  return Column(
                    children: <Widget>[
                      Expanded(
                        child: ListView.builder(
                            itemCount: pushnotifications.length,
                            itemBuilder: (BuildContext context, int index) {
                              return Container(
                                  margin: const EdgeInsets.only(top: 15.0),
                                  child: Card(
                                    child: InkWell(
                                      onTap: () {
                                        // Navigator.push(context,
                                        //     MaterialPageRoute(builder: (context) => ApplicationDetailScreen(applications[index])));
                                      },
                                      child: Container(
                                        margin: const EdgeInsets.all(15.0),
                                        child: Column(
                                          mainAxisSize: MainAxisSize.min,
                                          children: <Widget>[
                                            Container(
                                              child: Row(
                                                children: <Widget>[
                                                  Expanded(
                                                    flex: 5,
                                                    child: Column(
                                                      crossAxisAlignment: CrossAxisAlignment.start,
                                                      children: <Widget>[
                                                        Container(
                                                          margin:
                                                              const EdgeInsets.only(
                                                                  top: 10.0,
                                                                  bottom: 10.0),
                                                          child: Text(
                                                            "${pushnotifications[index].message}",
                                                          ),
                                                        ),
                                                        Container(
                                                          child: Row(
                                                            children: <Widget>[
                                                              Icon(Icons.calendar_today, color: Colors.black45,),
                                                              Text('Sent Date: ${new DateFormat.yMMMd().format(DateTime.parse(pushnotifications[index].createdAt))}', style: TextStyle(color: Colors.black45)),
                                                             
                                                            ],
                                                          ),
                                                        )
                                                      ],
                                                    ),
                                                  ),
                                                  Expanded(
                                                    flex: 1,
                                                      child: Material(
                                                          color: Colors.amber,
                                                          shape: CircleBorder(),
                                                          child: Padding(
                                                            padding: EdgeInsets.all(
                                                                13.0),
                                                            child: Icon(
                                                                Icons.notifications,
                                                                color: Colors.white,
                                                                size: 20.0),
                                                          )),
                                                    ),
                                                  
                                                ],
                                              ),
                                            )
                                          ],
                                        ),
                                      ),
                                    ),
                                  ));
                            }),
                      ),
                    ],
                  );
                } else {
                  return Center(
                    child: Container(
                      child: Text("No Notification Available Now"),
                    ),
                  );
                }
              } else {
                return Center(child: CircularProgressIndicator());
              }
            },
          ),
        ));
  }

  Widget _buildTile(Widget child, {Function() onTap}) {
    return Material(
        elevation: 14.0,
        borderRadius: BorderRadius.circular(12.0),
        shadowColor: Color(0x802196F3),
        child: InkWell(
            // Do onTap() if it isn't null, otherwise do print()
            onTap: onTap != null
                ? () => onTap()
                : () {
                    print(onTap);
                  },
            child: child));
  }

  Future getNotifications() {
    return Future.delayed(const Duration(milliseconds: 10));
  }
}

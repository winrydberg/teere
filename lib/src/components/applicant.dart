import 'package:dfmc/src/models/application.dart';
import 'package:dfmc/src/providers/appsate.dart';
import 'package:dfmc/src/screens/application_details.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';

// Adapted from the data table demo in offical flutter gallery:
// https://github.com/flutter/flutter/blob/master/examples/flutter_gallery/lib/demo/material/data_table_demo.dart
class ApplicantScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return ApplicantScreenState();
  }
}

class ApplicantScreenState extends State<ApplicantScreen> {
  @override
  Widget build(BuildContext context) {
    final appState = Provider.of<AppState>(context);
    return FutureBuilder(
      future: appState.getMyApplications(),
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          if (snapshot.data == null) {
            return Container(
              child: Center(
                  child: Column(
                children: <Widget>[
                  Text("No Submissions Found"),
                  Text("Send a New Application Now")
                ],
              )),
            );
          } else {
            List<Application> applications = snapshot.data;
            print(applications);
            return ListView.builder(
                itemCount: applications.length,
                itemBuilder: (BuildContext ctxt, int index) {
                  return Card(
                    child: InkWell(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => ApplicationDetailScreen(
                                    applications[index])));
                      },
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: <Widget>[
                          ListTile(
                            leading: Icon(
                              Icons.album,
                              color: Colors.lightBlue,
                            ),
                            title: Text(
                              "TEERE00${applications[index].id}",
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                            subtitle: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Container(
                                    margin: const EdgeInsets.only(
                                        top: 10.0, bottom: 10.0),
                                    child: Text(
                                      "${applications[index].firstname} ${applications[index].lastname}"
                                          .toUpperCase(),
                                    ),
                                  ),
                                  Container(
                                    child: Text(
                                        'Date Applied: ${new DateFormat.yMMMd().format(DateTime.parse(applications[index].createdAt))}'),
                                  ),
                                ]),
                          ),
                          ButtonBar(
                            children: <Widget>[
                              shouldDelete(applications[index]),
                              chooseBadge(applications[index])
                              // approvedbadge()
                              // FlatButton(
                              //   child: const Text('BUY TICKETS'),
                              //   onPressed: () {/* ... */},
                              // ),
                              // FlatButton(
                              //   child: const Text('LISTEN'),
                              //   onPressed: () {/* ... */},
                              // ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  );
                });
          }
        } else {
          return Center(
            child: CircularProgressIndicator(),
          );
        }
      },
    );

    // Container(
    //   margin: const EdgeInsets.only(top: 20.0),
    //   child: Column(
    //     children: <Widget>[
    //       Container(
    //         margin: const EdgeInsets.only(left: 5.0),
    //         child: Align(
    //           alignment: Alignment.centerLeft,
    //           child: Text("Applicant's History", style: TextStyle(fontWeight: FontWeight.bold),)),),
    //       Container(
    //         decoration: BoxDecoration(
    //           // border: Border.all(color: Colors.blueAccent)
    //         ),
    //         child: Column(
    //           children: <Widget>[
    //                 heading(),
    //                 ItemRow(),
    //           ],
    //         ),
    //       )

    //     ],
    //   ),
    // );
  }

  chooseBadge(Application application) {
    if (application.approved == true) {
      return approvedbadge();
    } else {
      if (application.disapproved == true) {
        return disApprovedbadge();
      } else {
        return pendingapprovalbadge();
      }
    }
  }

 Widget shouldDelete(Application application) {
    if (application.approved == true) {
      return Container();
    } else {
      return Container();
      // return FlatButton(
      //   child: const Text('DELETE APPLICATION'),
      //   onPressed: () {

      //   },
      // );
    }
  }

  approvedbadge() {
    return Container(
      margin: const EdgeInsets.all(5),
      decoration: BoxDecoration(
          color: Colors.green, borderRadius: BorderRadius.circular(5)),
      child: Padding(
        padding: const EdgeInsets.only(
            top: 5.0, bottom: 5.0, left: 10.0, right: 10.0),
        child: Row(
          children: <Widget>[
            Icon(
              Icons.check_box,
              color: Colors.white,
            ),
            Text(
              "Approved",
              style: TextStyle(color: Colors.white),
            )
          ],
        ),
      ),
    );
  }

  pendingapprovalbadge() {
    return Container(
      margin: const EdgeInsets.all(5),
      decoration: BoxDecoration(
          color: Colors.orange, borderRadius: BorderRadius.circular(5)),
      child: Padding(
        padding: const EdgeInsets.only(
            top: 5.0, bottom: 5.0, left: 10.0, right: 10.0),
        child: Row(
          children: <Widget>[
            Icon(
              Icons.check_box,
              color: Colors.white,
            ),
            Text(
              "Pending Approval",
              style: TextStyle(color: Colors.white),
            )
          ],
        ),
      ),
    );
  }

  disApprovedbadge() {
    return Container(
      margin: const EdgeInsets.all(5),
      decoration: BoxDecoration(
          color: Colors.red, borderRadius: BorderRadius.circular(5)),
      child: Padding(
        padding: const EdgeInsets.only(
            top: 5.0, bottom: 5.0, left: 10.0, right: 10.0),
        child: Row(
          children: <Widget>[
            Icon(
              Icons.close,
              color: Colors.white,
            ),
            Text(
              "Disapproved",
              style: TextStyle(color: Colors.white),
            )
          ],
        ),
      ),
    );
  }

  Widget heading() {
    return Container(
      height: 40.0,
      margin: const EdgeInsets.only(top: 5.0, left: 5.0, right: 5.0),
      decoration: BoxDecoration(
        color: Colors.lightBlue[800],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Expanded(
            flex: 1,
            child: Center(
                child: Text(
              "Amount",
              style:
                  TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
            )),
          ),
          Expanded(
            flex: 1,
            child: Center(
                child: Text(
              "Date Applied",
              style:
                  TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
            )),
          ),
          Expanded(
            flex: 1,
            child: Center(
                child: Text(
              "Status",
              style:
                  TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
            )),
          ),
        ],
      ),
    );
  }

  Widget ItemRow() {
    return Container(
      margin: const EdgeInsets.only(left: 5.0, right: 5.0),
      decoration: BoxDecoration(
          border: Border.all(
        color: Colors.lightBlue[800],
      )),
      child: Row(
        children: <Widget>[
          Expanded(
            flex: 1,
            child: Container(
              height: 30,
              child: Center(child: Text("GHC 1000.00")),
            ),
          ),
          Expanded(
            flex: 1,
            child: Container(
              height: 30,
              child: Center(child: Text("1/02/2010")),
            ),
          ),
          Expanded(
            flex: 1,
            child: Container(
              height: 30,
              child: Center(child: Text("Pending")),
            ),
          )
        ],
      ),
    );
  }
}

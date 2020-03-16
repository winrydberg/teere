import 'dart:async';

import 'package:dfmc/src/models/application.dart';
import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_downloader/flutter_downloader.dart';

class ApplicationDetailScreen extends StatefulWidget {
  final Application application;
  ApplicationDetailScreen(this.application);

  @override
  State<StatefulWidget> createState() {
    return ApplicationDetailScreenState();
  }
}

class ApplicationDetailScreenState extends State<ApplicationDetailScreen> {
  Application application;


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    application = widget.application;
    WidgetsFlutterBinding.ensureInitialized();
    FlutterDownloader.initialize();
  }

  @override
  Widget build(BuildContext context) {

    
    return Scaffold(
        appBar: AppBar(
          title: Text("Application Details"),
          centerTitle: true,
        ),
        body: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              showPassport(
                  'http://192.168.8.101:8000/uploads/${application.image}'),
              renderListStyle(application),
            ],
          ),
        ));
  }

  renderListStyle(Application application) {
    return Container(
        child: Column(
      children: <Widget>[
        ListTile(
          leading: Icon(Icons.person),
          title: Text("FULL NAME"),
          subtitle: Text("${application.firstname} ${application.lastname}"),
        ),
        Row(
          children: <Widget>[
            Expanded(
              child: ListTile(
                leading: Icon(Icons.person),
                title: Text("PHONE NUMBER"),
                subtitle: Text("${application.phoneno}"),
              ),
            ),
            Expanded(
              child: ListTile(
                leading: Icon(Icons.person),
                title: Text("EMAIL ADDRESS"),
                subtitle: Text("${application.email}"),
              ),
            ),
          ],
        ),
        Row(
          children: <Widget>[
            Expanded(
              child: ListTile(
                leading: Icon(Icons.person),
                title: Text("ID TYPE"),
                subtitle: Text("${application.idtype}"),
              ),
            ),
            Expanded(
              child: ListTile(
                leading: Icon(Icons.person),
                title: Text("ID NUMBER"),
                subtitle: Text("${application.idnumber}"),
              ),
            ),
          ],
        ),
        ListTile(
          leading: Icon(Icons.person),
          title: Text("DISABILITY TYPE"),
          subtitle: renderDisabilityType(application.disabilitytype),
        ),
        Divider(),
        Row(
          children: <Widget>[
            Expanded(
              child: ListTile(
                leading: Icon(Icons.person),
                title: Text("COMMUNITY"),
                subtitle: Text('${application.community}'),
              ),
            ),
            Expanded(
              child: ListTile(
                leading: Icon(Icons.person),
                title: Text("POSTAL ADDRESS"),
                subtitle: Text('${application.postaladdress}'),
              ),
            ),
          ],
        ),
        Row(
          children: <Widget>[
            Expanded(
              child: ListTile(
                leading: Icon(Icons.person),
                title: Text("STREET NAME"),
                subtitle: Text('${application.streetname}'),
              ),
            ),
            Expanded(
              child: ListTile(
                leading: Icon(Icons.person),
                title: Text("HOUSE NO."),
                subtitle: Text('${application.houseno}'),
              ),
            ),
          ],
        ),
        ListTile(
          leading: Icon(Icons.person),
          title: Text("BUSINESS LOCATION"),
          subtitle: Text('${application.bizlocation}'),
        ),
        Row(
          children: <Widget>[
            Expanded(
              child: ListTile(
                leading: Icon(Icons.person),
                title: Text("EDUCATION"),
                subtitle: Text('${application.education}'),
              ),
            ),
            Expanded(
              child: ListTile(
                leading: Icon(Icons.person),
                title: Text("OCCUPATION"),
                subtitle: Text('${application.occupation}'),
              ),
            ),
          ],
        ),
        Row(
          children: <Widget>[
            Expanded(
              child: ListTile(
                leading: Icon(Icons.person),
                title: Text("YRS IN BUSINESS"),
                subtitle: Text('${application.yearsinbusiness}'),
              ),
            ),
            Expanded(
              child: ListTile(
                leading: Icon(Icons.person),
                title: Text("DEPENDANTS"),
                subtitle: Text('${application.depedants}'),
              ),
            ),
          ],
        ),
        Divider(),
        ListTile(
          leading: Icon(Icons.person),
          title: Text("TOTAL AMOUNT REQUESTED"),
          subtitle: Text('GHC ${application.amount}'),
        ),

       Container(
         child: RaisedButton(
          onPressed: () async{

                final taskId = await FlutterDownloader.enqueue(
                  url: 'https://www.remove.bg/assets/start_remove-79a4598a05a77ca999df1dcb434160994b6fde2c3e9101984fb1be0f16d0a74e.png',
                  savedDir: '',
                  showNotification: true, // show download progress in status bar (for Android)
                  openFileFromNotification: true, // click on notification to open downloaded file (for Android)
                );
                
          },
          child: Text(
            'DOWNLOAD IN PDF',
            style: TextStyle(fontSize: 20)
          ),
        ),
       )
      ],
    ));
  }

  showPassport(String url) {
    return Center(
      child: Container(
        height: 100,
        width: 100,
        child: Center(
          child: Image.network(
            url,
            fit: BoxFit.fill,
          ),
        ),
      ),
    );
  }

  renderDisabilityType(List<dynamic> disabilities) {
    return Text("${disabilities[0]}");

    //   return  ListView.builder(
    //   itemCount: disabilities.length,
    //   itemBuilder: (BuildContext ctxt, int index) {
    //    return Text("${disabilities[index]}");
    //   }
    // );
  }


}

// import 'dart:async';
// import 'dart:io';

// import 'package:flutter/foundation.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_full_pdf_viewer/full_pdf_viewer_scaffold.dart';
// import 'package:path_provider/path_provider.dart';

// class ApplicationDetailScreen extends StatefulWidget {
//   @override
//   State<StatefulWidget> createState() {
//     return ApplicationDetailScreenState();
//   }

// }

// class ApplicationDetailScreenState extends State<ApplicationDetailScreen> {
//   String pathPDF = "";

//   @override
//   void initState() {
//     super.initState();
//     createFileOfPdfUrl().then((f) {
//       setState(() {
//         pathPDF = f.path;
//         print(pathPDF);
//       });
//     });
//   }

//   Future<File> createFileOfPdfUrl() async {
//     final url = "http://192.168.8.101:8000/download-pdf/2";
//     final filename = url.substring(url.lastIndexOf("/") + 1);
//     var request = await HttpClient().getUrl(Uri.parse(url));
//     var response = await request.close();
//     var bytes = await consolidateHttpClientResponseBytes(response);
//     String dir = (await getApplicationDocumentsDirectory()).path;
//     File file = new File('$dir/$filename');
//     await file.writeAsBytes(bytes);
//     return file;
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: const Text('Plugin example app')),
//       body: Center(
//         child: RaisedButton(
//           child: Text("Open PDF"),
//           onPressed: () => Navigator.push(
//             context,
//             MaterialPageRoute(builder: (context) => PDFScreen(pathPDF)),
//           ),
//         ),
//       ),
//     );
//   }
// }

// class PDFScreen extends StatelessWidget {
//   String pathPDF = "";
//   PDFScreen(this.pathPDF);

//   @override
//   Widget build(BuildContext context) {
//     return PDFViewerScaffold(
//         appBar: AppBar(
//           title: Text("Document"),
//           actions: <Widget>[
//             IconButton(
//               icon: Icon(Icons.share),
//               onPressed: () {},
//             ),
//           ],
//         ),
//         path: pathPDF);
//   }
// }

import 'dart:io';

import 'package:dfmc/src/models/application.dart';
import 'package:dfmc/src/models/push_notification.dart';
import 'package:dfmc/src/models/user.dart';
import 'package:dfmc/src/providers/storage_provider.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
// import 'package:dio/dio.dart';
import 'package:path/path.dart';

class AppState with ChangeNotifier {
  final _storage = new FlutterSecureStorage();
  static final _baseURL = "https://teere.digicodesystems.com/api";
  // static final _baseURL = "http://192.168.43.99:8000/api";

  static String _token = '';
  static String devicetoken = '';
  static bool isRegionFetched = false;
  static List<Map<String, dynamic>> regions = [];
  static List<Map<String, dynamic>> districts = [];
  static List<Application> applications = [];
  // Map<String, String> headers = {"Content-type": "application/json"};
  Map<String, String> headers = {
    'Content-type': 'application/json',
    'Accept': 'application/json',
  };

  UserModel theuser;
  Map<String, dynamic> user;

  setDeviceToken(String dt) {
    devicetoken = dt;
  }

  Future<String> loadUser() async {
    final _storage = new FlutterSecureStorage();
    String uuu = await _storage.read(key: "user");
    _token = await _storage.read(key: "token");
    if (uuu != null && _token != null) {
      return "OK";
    } else {
      return null;
    }
  }

  Future<bool> loginUser(
      String phoneno, String password, String devicet) async {
    final _storage = new FlutterSecureStorage();
    var response = await http.post(_baseURL + '/login',
        headers: headers,
        body: jsonEncode({
          "phoneno": phoneno,
          "password": password,
          "devicetoken": devicet
        }));
    final int statusCode = response.statusCode;

    if (statusCode < 200 || statusCode > 400 || json == null) {
      // throw new Exception("Error while fetching data");
      return false;
    }
    Map<String, dynamic> mapres = jsonDecode(response.body);

    setUser(mapres["user"]);
    String uuu = await _storage.read(key: 'user');
    // print("==================$uuu");
    if (mapres['success'] == true) {
      _token = mapres['token'];
      SStorageProvider.saveToken(mapres['token']);
      //  print(_token);
      return true;
    } else {
      return false;
    }
  }

  Future<Map<String, dynamic>> registerUser(Map<String, dynamic> data) async {
    var response =
        await http.post(_baseURL + '/register', headers: headers, body: jsonEncode({
      'firstname': data["firstname"],
      'lastname': data['lastname'],
      'email': data['email'],
      'phoneno': data['phoneno'],
      'password': data['password'],
      'devicetoken': data['devicetoken']
    }));
    Map<String, dynamic> mapres = jsonDecode(response.body);
    print(mapres);
    return mapres;
  }

  // Future<UserModel> getUserinfo() async {
  //     final _storage = new FlutterSecureStorage();
  //   String data = await _storage.read(key: 'user');
  //   // print("==========${data}");
  //   Map valueMap = json.decode(data);
  //   var muser = UserModel.fromJson(valueMap);
  //   print("-------------NEW=============${muser}");
  //   return muser;
  // }

  static void setToken(String token) {
    print("the storage=======$token");
    _token = token;
  }

  Future<String> setUser(Map<String, dynamic> data) async {
    String uuser = json.encode(data).toString();
    await _storage.write(key: "user", value: uuser);
    return "11";
  }

  Future<UserModel> getData() async {
    // final _storage = new FlutterSecureStorage();
    String value = await _storage.read(key: "user");
    Map<String, dynamic> usermap = json.decode(value);
    theuser = UserModel.fromJson(usermap);
    return UserModel.fromJson(usermap);
  }

  // Future<Null> apply(String firstname,String lastname, String phoneno,
  //                   String maritalstatus, String gender, String idtype, String idnumber,
  //                   String dob, String gfdmember, String disabilitytype, String communityname,
  //                   String postaladdress, String houseno, String streenname, String businesslocation,
  //                   String education, String occupation, String yearsinobusines, String dependants,
  //                   String objective, String fundintents, String totalamount, String groupapplication,
  //                   String budgets, bool agreed,
  // File file) async{

  //   List<int> imageBytes = file.readAsBytesSync();
  //   String base64Image = base64Encode(imageBytes);
  //   print(base64Image);
  //   var response = await http.post(_baseURL + '/apply', body: {
  //       "firstname": firstname,
  //       "lastname": lastname,
  //       "phoneno": phoneno,
  //       "marital_status": maritalstatus,
  //       "gender": gender,
  //       "idtype": idtype,
  //       "idnumber": idnumber,
  //       "dob": dob,
  //       "gfdmember": gfdmember,
  //       "disabilitytype": disabilitytype,
  //       "communityname": communityname,
  //       "postaladdress": postaladdress,
  //       "houseno": houseno,
  //       "streenname": streenname,
  //       "business_location": businesslocation,
  //       "education": education,
  //       "occupation": occupation,
  //       "yearsinobusines": yearsinobusines,
  //       "dependants": dependants,
  //       "objective": objective,
  //       "fundintents": fundintents,
  //       "totalamount": totalamount,
  //       "groupapplication": groupapplication,
  //       "budgets": budgets,
  //       "info_approval": agreed,
  //       "photo": file != null ? 'data:image/png;base64,' + base64Image : '',

  //   });

  //   print(response.body);

  //   // return response;
  // }

  Future<String> applying(Map<String, dynamic> user) async {
    print(user);

    //  return 'ok';

    List<int> imageBytes = user['file'].readAsBytesSync();
    String base64Image = base64Encode(imageBytes);

    // print(firstname);

    var response = await http.post(_baseURL + '/apply',
        headers: {
          "Authorization": "Bearer $_token",
          'Content-type': 'application/json',
          'Accept': 'application/json',
          }, 
        body:jsonEncode({
        "firstname": user['firstname'],
        "photo": 'data:image/png;base64,'+base64Image,
        "lastname": user['lastname'],
        "maritalstatus": user['maritalstatus'],
        "gender": user['gender'],
        "idtype": user['idtype'],
        "idnumber": user['idnumber'],
        "dob": user['dob'],
        "gfdmember": user['gfdmember'],
        "disabilitytype": user['disabilitytype'],
        "communityname": user['communityname'],
        "houseno": user['houseno'],
        "postaladdress": user['postaladdress'],
        "phoneno": user['phoneno'],
        "streenname": user['streenname'],
        "education": user['education'],
        "occupation": user['occupation'],
        "yearsinbusiness": user['yearsinbusiness'],
        'business_location': user['bizlocation'],
        "dependants": user['dependants'],
        "objective": user['objective'],
        "totalamount": user['totalamount'],
        "fundintents": user['fundintents'],
        "groupapplication": user['groupapplication'],
        'budgets': user['budgets'],
        'info_approval': user['agreed'],
        'region': user['region'],
        'district': user['district'],
    }));


        //  "firstname": ${user['firstname']},
        // "photo": 'data:image/png;base64,'+$base64Image,
        // "lastname": ${user['lastname']},
        // "maritalstatus": ${user['maritalstatus']},
        // "gender": ${user['gender']},
        // "idtype": ${user['idtype']},
        // "idnumber": ${user['idnumber']},
        // "dob": ${user['dob']},
        // "gfdmember": ${user['gfdmember']},
        // "disabilitytype": ${user['disabilitytype']},
        // "communityname": ${user['communityname']},
        // "houseno": ${user['houseno']},
        // "postaladdress": ${user['postaladdress']},
        // "phoneno": ${user['phoneno']},
        // "streenname": ${user['streenname']},
        // "education": ${user['education']},
        // "occupation": ${user['occupation']},
        // "yearsinbusiness": ${user['yearsinbusiness']},
        // 'business_location': ${user['bizlocation']},
        // "dependants": ${user['dependants']},
        // "objective": ${user['objective']},
        // "totalamount": ${user['totalamount']},
        // "fundintents": ${user['fundintents']},
        // "groupapplication": ${user['groupapplication']},
        // 'budgets': ${user['budgets']},
        // 'info_approval': ${user['agreed']},
        // 'region': ${user['region']},
        // 'district': ${user['district']},

    Map<String, dynamic> mapres = jsonDecode(response.body);

// print(response.body);
    print(mapres.toString());
    if (mapres["success"] == true) {
      return "1";
    } else {
      return "0";
    }
  }

  static Future<Null> getRegions() async {
    if (!isRegionFetched) {
      regions = [];
      var response = await http.get(_baseURL + '/regions',
          headers: {"Authorization": "Bearer $_token"});
      Map<String, dynamic> mapregions = json.decode(response.body);
      print(mapregions);
      List<dynamic> theregions = mapregions["regions"];
      isRegionFetched = true;
      for (int i = 0; i < theregions.length; i++) {
        List<Map<String, dynamic>> _results = regions
            .where((item) => item["name"].startsWith(theregions[i]["name"]))
            .toList();
        if (_results.length > 0) {
        } else {
          Map<String, dynamic> reg = theregions[i];
          regions.add(reg);
        }
      }
    }
  }

  static setDistrict(String thedistricts) {
    districts = [];
    List<Map<String, dynamic>> _results =
        regions.where((item) => item["name"].startsWith(thedistricts)).toList();
    List<dynamic> mydistricts = _results[0]["districts"];
    for (int i = 0; i < mydistricts.length; i++) {
      Map<String, dynamic> dts = mydistricts[i];
      districts.add(dts);
    }
    //print(districts);
  }

  Future<List<Application>> getMyApplications() async {
    applications = [];
    var response = await http.get(_baseURL + '/my-applications',
        headers: {"Authorization": "Bearer $_token"});
    // print("auth====${response.body}");
    List<dynamic> mapapplications = json.decode(response.body)['applications'];
    print("auth====$mapapplications");
    mapapplications.forEach((application) {
      Application temp = Application.fromJson(application);
      applications.add(temp);
    });

    print(applications);
    return applications;
  }


  Future<String> getTotalApplication() async {
    var response = await http.get(_baseURL + '/total-applications',
        headers: {"Authorization": "Bearer $_token"});
    String total = json.decode(response.body)['totalapplication'];
  
    return total;
  }

  Future<List<PushNotification>> getNotifications() async {

    List<PushNotification> pushnotifications =[];
    var response = await http.get(_baseURL + '/notifications',
        headers: {"Authorization": "Bearer $_token"});
    // var pushnotifications = jsonDecode(response.body)['pushnotifications'];
    List<dynamic> mappushnotifications = json.decode(response.body)['pushnotifications'];
    mappushnotifications.forEach((notification) {
      PushNotification temp = PushNotification.fromJson(notification);
      pushnotifications.add(temp);
    });

    return pushnotifications;
  }

   Future<Map<String, dynamic>> forgotPassword(String phoneno) async {
    var response =
        await http.post(_baseURL + '/forgot-password', headers: headers, body: jsonEncode({
      'phoneno': phoneno,
    }));
    Map<String, dynamic> mapres = jsonDecode(response.body);
    print(mapres);
    return mapres;
  }


Future<Map<String, dynamic>> resetPassword(String phoneno, String code, String password, String repeatpassword) async {
    var response =
        await http.post(_baseURL + '/reset-password', headers: headers, body: jsonEncode({
      'phoneno': phoneno,
      'code': code,
      'password': password,
      'repeatpassword': repeatpassword
    }));
   
    Map<String, dynamic> mapres = jsonDecode(response.body);
     print(phoneno+''+code);
    return mapres;
  }




}







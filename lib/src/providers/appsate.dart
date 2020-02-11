import 'dart:io';

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
  static final _baseURL = "http://192.168.8.101:8000/api";
  static String _token = '';
  static bool isRegionFetched = false;
  static List<Map<String, dynamic>> regions =[];
  static List<Map<String, dynamic>> districts =[];

  UserModel theuser;
  Map<String, dynamic> user;

  Future<bool> loginUser(String phoneno, String password) async {
    final _storage = new FlutterSecureStorage();
    var response = await http.post(_baseURL + '/login',
        body: {'phoneno': phoneno, 'password': password});
    Map<String, dynamic> mapres = json.decode(response.body);
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
    var response = await http.post(_baseURL + '/register', body: {
      'firstname': data['firstname'],
      'lastname': data['lastname'],
      'email': data['email'],
      'phoneno': data['phoneno'],
      'password': data['password']
    });
    Map<String, dynamic> mapres = json.decode(response.body);
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


  static void setToken(String token){
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
    String base64Image =  base64Encode(imageBytes);

   

    // print(firstname);


      var response = await http.post(_baseURL + '/apply', body: {
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
        'district': user['district']
    });

    Map<String, dynamic> mapres = json.decode(response.body);
    if(mapres["success"] ==true){
      return "1";
    }else{
      return "0";
    }
  }


  static Future<Null> getRegions() async {
    if(!isRegionFetched){
        var response = await http.get(_baseURL + '/regions',
        headers: {
          "Authorization":"Bearer $_token"
        });
        Map<String, dynamic> mapregions = json.decode(response.body);
        print(mapregions);
        List<dynamic> theregions = mapregions["regions"];
        isRegionFetched = true;
        for(int i=0;i<theregions.length; i++){
          Map<String, dynamic> reg = theregions[i];
          regions.add(reg);
        }
    }
  }

  static setDistrict(String thedistricts ){
    districts =[];
    List<Map<String,dynamic>> _results = regions.where((item) => item["name"].startsWith(thedistricts)).toList();
    List<dynamic> mydistricts = _results[0]["districts"];
     for(int i=0;i<mydistricts.length; i++){
          Map<String, dynamic> dts = mydistricts[i];
          districts.add(dts);
        }
    print(districts);
  }



}

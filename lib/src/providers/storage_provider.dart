import 'dart:convert';
import 'package:dfmc/src/providers/appsate.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';




class SStorageProvider {
     

    static  saveData(String key,data) async{
      final _storage = new FlutterSecureStorage();
       await _storage.write(key: key, value: data.toString());
      //  return true;
     }

     static saveToken(String token) async{
       final _storage = new FlutterSecureStorage();
       await _storage.write(key: "token", value: token);
     }


     static getTokeninState() async{
       final _storage = new FlutterSecureStorage();
       String token = await _storage.read(key: "token");
       print(token);
       AppState.setToken(token);
     }



     
 


}
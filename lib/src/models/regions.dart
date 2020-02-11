import 'district.dart';

class Region {
    int id;
    String name;
    String createdAt;
    String updatedAt;
    List<District> districts;

   //named constructor
   Region.fromJson(Map<String, dynamic> parsedJson, List<District> dts){
     id = parsedJson['id'];
     name = parsedJson['name'];
     createdAt = parsedJson['lastname'];
     updatedAt = parsedJson['phoneno'];
     districts = dts;
   }

    // Map<String, dynamic> toMap() {
    //     var map = <String, dynamic>{
    //       'lastname': lastname,
    //       'firstname': lastname,
    //       'phoneno': phoneno,
    //       'email': email,
    //       'createdAt': createdAt,
    //       'updatedAt': updatedAt
    //    };
    //     if (id != null) {
    //       map['id'] = id;
    //     }
    //     return map;
    // }


}
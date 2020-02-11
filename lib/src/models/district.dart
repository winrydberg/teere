class District {
    int id;
    String name;
    String createdAt;
    String updatedAt;
    int regionid;



    // String token;


   //constructor
  //  UserModel(this.id, this.firstname, this.);

   //named constructor
   District.fromJson(Map<String, dynamic> parsedJson){
     id = parsedJson['id'];
     name = parsedJson['name'];
     createdAt = parsedJson['created_at'];
     updatedAt = parsedJson['updated_at'];
     regionid = parsedJson["region_id"];
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
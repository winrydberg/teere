class PushNotification {
    int id;
    String title;
    String message;
    String devicetoken;
    int userid;
    String createdAt;



    // String token;


   //constructor
  //  UserModel(this.id, this.firstname, this.);

   //named constructor
   PushNotification.fromJson(Map<String, dynamic> parsedJson){
     id = parsedJson['id'];
     title = parsedJson['title'];
     message = parsedJson['message'];
     devicetoken = parsedJson['device_token:'];
     userid = parsedJson["user-id"];
     createdAt = parsedJson['created_at'];
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
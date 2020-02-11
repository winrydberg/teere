class UserModel {
    int id;
    String lastname;
    String firstname;
    String phoneno;
    String email;
    String createdAt;
    String updatedAt;


    // String token;


   //constructor
  //  UserModel(this.id, this.firstname, this.);

   //named constructor
   UserModel.fromJson(Map<String, dynamic> parsedJson){
     id = parsedJson['id'];
     firstname = parsedJson['firstname'];
     lastname = parsedJson['lastname'];
     phoneno = parsedJson['phoneno'];
     email = parsedJson['email'];
     createdAt = parsedJson['created_at'];
     updatedAt = parsedJson['updated_at'];
   }

    Map<String, dynamic> toMap() {
        var map = <String, dynamic>{
          'lastname': lastname,
          'firstname': lastname,
          'phoneno': phoneno,
          'email': email,
          'createdAt': createdAt,
          'updatedAt': updatedAt
       };
        if (id != null) {
          map['id'] = id;
        }
        return map;
    }


}
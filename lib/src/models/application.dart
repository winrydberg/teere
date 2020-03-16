import 'dart:convert';

class Application {
    int id;
    String lastname;
    String firstname;
    String phoneno;
    String email;
    String image;
    String gender;
    String maritalstatus;


    String dob;
    String idtype;
    String idnumber;
    String gfdmember;
    List<dynamic> disabilitytype;
    String community;
    String postaladdress;
    String houseno;
    String streetname;
    String bizlocation;
    String education;
    String occupation;
    String depedants;
    int amount;
    String yearsinbusiness;


    bool approved;
    bool disapproved;
    String createdAt;
    String updatedAt;


    // String token;


   //constructor
  //  UserModel(this.id, this.firstname, this.);

   //named constructor
   Application.fromJson(Map<String, dynamic> parsedJson){
     id = parsedJson['id'];
     firstname = parsedJson['firstname'];
     lastname = parsedJson['lastname'];
     phoneno = parsedJson['phoneno'];
     email = parsedJson['email'];
     image = parsedJson['image'];
     gender = parsedJson['gender'];
     maritalstatus = parsedJson['marital_status'];

     dob = parsedJson['dob'];
     idtype = parsedJson['idtype'];
     idnumber = parsedJson['idnumber'];
     gfdmember = parsedJson['gfdmember'];
     disabilitytype = jsonDecode(parsedJson['disabilitytype']);
     community = parsedJson['community'];
     postaladdress = parsedJson['postal_address'];
     houseno = parsedJson['houseno'];
     streetname = parsedJson['streetname'];
     bizlocation = parsedJson['business_location'];
     education = parsedJson['education'];
     occupation = parsedJson['occupation'];
     yearsinbusiness = parsedJson['yearsinobusines'];
     amount = parsedJson['total_amount'];





     
     approved = parsedJson['approved']==1 ? true : false;
     disapproved = parsedJson['disapproved'] ==1 ? true : false;
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
class ValidationMixin {

  String validateFirstname(String value) {
    if (value.length <= 0) {
      return 'First Name is required';
    }
    return null;
  }

  String validateSurname(String value) {
    if (value.length <= 0) {
      return 'Surname is required';
    }
    return null;
  }
  String validateEmail(String value) {
    //return null if valid
    //return string (with error message if not valid)
    if (!value.contains('@')) {
      return 'Please Enter valid email';
    }
    return null;
  }

  String validatePassword(String value) {
    if (value.length < 6) {
      return 'Must be at least 6 characters';
    }
    return null;
  }

  String validatePhoneNo(String value) {
    if (value.length > 0) {
      String patttern = r'(^(?:[+0]9)?[0-9]{10,12}$)';
      RegExp regExp = new RegExp(patttern);
      if (!regExp.hasMatch(value)) {
        return 'Phone Number not valid';
      } else {
        return null;
      }
    } else {
      return 'Phone Number is required';
    }
  }
}

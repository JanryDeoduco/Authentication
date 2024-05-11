import 'dart:convert';

class UserName{
  // Attributes
  String? fname;
  String? lname;
  String? email;
  // Constructor
  UserName(this.fname, this.lname, this.email);

  factory UserName.fromJson(Map<String, dynamic> json) {
    return UserName(
      json['fname'],
      json['lname'],
      json['email']
    );
  }
}


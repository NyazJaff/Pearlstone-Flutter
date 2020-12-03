import 'package:flutter/material.dart';
// import 'package:flutter_session/flutter_session.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserModel {
  int id;
  String user_name;
  String first_name;
  String second_name;
  String last_name;
  String contact_number;
  String building_name;
  String address_line_1;
  String address_line_2;
  String city;
  String country;
  String postcode;
  String email;
  String role;

  UserModel(
      this.id,
      this.user_name,
      this.first_name,
      this.second_name,
      this.last_name,
      this.contact_number,
      this.building_name,
      this.address_line_1,
      this.address_line_2,
      this.city,
      this.country,
      this.postcode,
      this.email,
      this.role
      );



  UserModel.fromJson(Map<String, dynamic> json) {
    id             = json['id'];
    user_name      = json['user_name'];
    first_name     = json['first_name'];
    second_name    = json['second_name'];
    last_name      = json['last_name'];
    contact_number = json['contact_number'];
    building_name  = json['building_name'];
    address_line_1 = json['address_line_1'];
    address_line_2 = json['address_line_2'];
    city           = json['city'];
    country        = json['country'];
    postcode       = json['postcode'];
    email          = json['email'];
    role           = json['rol'];
  }

  Map<String, dynamic> toJson() =>
      {
        'id'             : id,
        'user_name'      : user_name,
        'first_name'     : first_name,
        'second_name'    : second_name,
        'last_name'      : last_name,
        'contact_number' : contact_number,
        'building_name'  : building_name,
        'address_line_1' : address_line_1,
        'address_line_2' : address_line_2,
        'city'           : city,
        'country'        : country,
        'postcode'       : postcode,
        'email'          : email,
        'rol'            : role,
      };
}



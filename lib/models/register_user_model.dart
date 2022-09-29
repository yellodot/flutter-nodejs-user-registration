import 'dart:convert';
// ignore: implementation_imports
import 'package:flutter/src/widgets/editable_text.dart';

RegisterUserModel registerUserModelFromJson(String str) => RegisterUserModel.fromJson(json.decode(str));

String registerUserModelToJson(RegisterUserModel data) => json.encode(data.toJson());

class RegisterUserModel {
  String? firstname;
  String? lastname;
  String? birthdate;

  RegisterUserModel(TextEditingController firstNameController, TextEditingController lastNameController, TextEditingController birtDateController, {this.firstname, this.lastname, this.birthdate});

  RegisterUserModel.fromJson(Map<String, dynamic> json) {
    firstname = json['firstname'];
    lastname = json['lastname'];
    birthdate = json['birthdate'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['firstname'] = firstname;
    data['lastname'] = lastname;
    data['birthdate'] = birthdate;
    return data;
  }
}
import 'dart:convert';

List<RegisterUserModel> RegisterUserModelFromJson(String str) => List<RegisterUserModel>.from(json.decode(str).map((x) => RegisterUserModel.fromJson(x)));

String RegisterUserModelToJson(List<RegisterUserModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class RegisterUserModel {
  String? firstname;
  String? lastname;
  String? birthdate;

  RegisterUserModel({this.firstname, this.lastname, this.birthdate});

  RegisterUserModel.fromJson(Map<String, dynamic> json) {
    firstname = json['firstname'];
    lastname = json['lastname'];
    birthdate = json['birthdate'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['firstname'] = this.firstname;
    data['lastname'] = this.lastname;
    data['birthdate'] = this.birthdate;
    return data;
  }
}
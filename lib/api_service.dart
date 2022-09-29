import 'dart:convert';
import 'dart:developer';
import 'package:http/http.dart' as http;
import 'package:usecase_assurly/utils/constants.dart';
import 'package:usecase_assurly/models/register_user_model.dart';
import 'package:usecase_assurly/models/user_model.dart';

class ApiService {
  // fetch users from API
  Future<List<UserModel>?> getUsers() async {
    try {
      var url = Uri.parse(ApiConstants.baseUrl + ApiConstants.usersEndpoint);
      var response = await http.get(url);
      if (response.statusCode == 200) {
        List<UserModel> _model = userModelFromJson(response.body);
        return _model;
      }
    } catch (e) {
      log(e.toString());
    }
    return null;
  }

  // send new user data to API
  Future<RegisterUserModel> createUser(RegisterUserModel user) async {
    var url = Uri.parse(ApiConstants.baseUrl + ApiConstants.usersEndpoint);
    var response = await http.post(url,
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: RegisterUserModelToJson(user));
    if (response.statusCode == 201) {
      return RegisterUserModel.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to create a user.');
    }
  }
}

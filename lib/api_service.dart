import 'dart:developer';
import 'package:http/http.dart' as http;
import 'package:usecase_assurly/constants.dart';
import 'package:usecase_assurly/register_user_model.dart';
import 'package:usecase_assurly/user_model.dart';

class ApiService {
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

  Future<void> createUsers() async {
    try {
      var url = Uri.parse(ApiConstants.baseUrl + ApiConstants.usersEndpoint);
      var response = await http.post(url);
      if (response.statusCode == 201) {
        return;
      }
    } catch (e) {
      log(e.toString());
    }
    return null;
  }

}

// ignore_for_file: avoid_print

import 'dart:convert';

import 'package:el_karooz/model/user_interface.dart';
import 'package:el_karooz/service/base_url.dart';

class UserService extends BaseService {
  UserService() : super();
  Future<bool> logoutUser() async {
    removeToken();
    return true;
  }

  Future<bool> userIsLoggedIn() async {
    const String url = 'user/check-user-authority';
    final response = await postRequest(url, {});
    if (response.statusCode >= 200 && response.statusCode < 300) {
      return true;
    } else {
      return false;
    }
  }

  Future<bool> loginUser(String email, String password, String fcmToken) async {
    const String url = 'user/login';
    Map<String, String> body = {
      'email': email,
      'password': password,
      'fcmToken': fcmToken
    };
    final response = await postRequest(url, body);
    if (response.statusCode >= 200 && response.statusCode < 300) {
      setToken(response.body);
      return true;
    } else {
      return false;
    }
  }

  Future<Map<String,dynamic>> registerUser(UserModel user, String fcmToken) async {
    const String url = 'user/register';
    Map<String, dynamic> body = {
      'fullName': user.fullName,
      'email': user.email,
      'password': user.password,
      'phoneNumber': user.phoneNumber,
      'FCMToken': fcmToken,
      'birthday': user.birthday,
      'education': user.education,
      'gender': user.gender
    };
    final response = await postRequest(url, body);
    if (response.statusCode >= 200 && response.statusCode < 300) {
      return {
        'status': true,
        'message': 'تم التسجيل بنجاح',
      };
    } else {
      Map<String, dynamic> convertBody = json.decode(response.body);

      String message = convertBody['message'] ?? "";
      return {'status': false, 'message': message};
    }
  }

  Future profile() async {
    const String url = 'user/profile';
    final response = await getRequest(url, {});
    if (response.statusCode >= 200 && response.statusCode < 300) {
      return response.body;
    } else {
      return false;
    }
  }
}

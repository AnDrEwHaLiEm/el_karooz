import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class BaseService {
  static const String baseUrl = 'http://192.168.1.13:4000';
  Future setToken(String token) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    pref.setString('token', token);
  }


  Future removeToken() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    pref.remove('token');
  }

  Future<http.Response> postRequest(
      String url, Map<String, dynamic> body) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    String? tokenString = pref.getString('token');
    tokenString ??= '{"token": ""}';
    Map<String, dynamic> convertToken = json.decode(tokenString);

    String token = convertToken['token'] ?? "";
  
    String jsonBody = jsonEncode(body);

    final response = await http.post(
      Uri.parse('$baseUrl/$url'),
      body: jsonBody,
      headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        'Authorization': '123=$token'
      },
    );

    return response;
  }

  Future<http.Response> getRequest(
      String url, Map<String, dynamic> params) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    String? tokenString = pref.getString('token');
    Map<String, dynamic> convertToken = json.decode(tokenString!);
    String token = convertToken['token'];
    final response = await http.get(
      Uri.parse('$baseUrl/$url?${Uri(queryParameters: params)}'),
      headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        'Authorization': '123=$token'
      },
    );

    return response;
  }

  Future<http.Response> putRequest(
      String url, Map<String, dynamic> body) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    String? tokenString = pref.getString('token');
    Map<String, dynamic> convertToken = json.decode(tokenString!);
    String token = convertToken['token'];
    String jsonBody = jsonEncode(body);
    final response = await http.put(
      Uri.parse('$baseUrl/$url'),
      body: jsonBody,
      headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        'Authorization': '123=$token'
      },
    );

    return response;
  }

  Future<http.Response> deleteRequest(
      String url, Map<String, dynamic> body) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    String? tokenString = pref.getString('token');
    Map<String, dynamic> convertToken = json.decode(tokenString!);
    String token = convertToken['token'];
    String jsonBody = jsonEncode(body);
    final response = await http.delete(
      Uri.parse('$baseUrl/$url'),
      body: jsonBody,
      headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        'Authorization': '123=$token'
      },
    );

    return response;
  }
}



// ignore_for_file: non_constant_identifier_names

import 'dart:convert';
import 'package:http/http.dart';
import 'package:postman/service/model/cars_resonse.dart';
import 'package:postman/service/model/users_model.dart';


class Network {
  static String BASE = "64ab0f4a0c6d844abedf2536.mockapi.io";
  static Map<String, String> headers = {'Content-Type': 'application/json'};
  /* Http Apis*/
  static String API_LIST = "/Users";
  static String API_GET = "/Users";
  static String API_CREATE = "/Users/";
  static String API_UPDATE = "/Users/"; //{id}
  static String API_DELETE = "/Users/"; //{id}

  /* Http Requests*/
  static Future<String?> GET(String api, Map<String, dynamic> params) async {
    var uri = Uri.https(BASE, api, params);
    var response = await get(uri, headers: headers);
    if (response.statusCode == 200) {
      return response.body;
    }
    return null;
  }

  static Future<String?> POST(String api, Map<String, dynamic> params) async {
    var uri = Uri.https(BASE, api);
    var response = await post(uri, headers: headers, body: jsonEncode(params));
    if (response.statusCode == 200 || response.statusCode == 201) {
      return response.body;
    }
    return null;
  }

  static Future<String?> PUT(String api, Map<String, dynamic> params) async {
    var uri = Uri.https(BASE, api);
    var response = await put(uri, headers: headers, body: jsonEncode(params));
    if (response.statusCode == 200 || response.statusCode == 202) {
      return response.body;
    }
    return null;
  }

  static Future<String?> DEL(String api, Map<String, dynamic> params) async {
    var uri = Uri.https(BASE, api, params);
    var response = await delete(uri, headers: headers);
    if (response.statusCode == 200) {
      return response.body;
    }
    return null;
  }

/* Http Response*/
  static Map<String, dynamic> paramsEmpty() {
    Map<String, dynamic> params = {};
    return params;
  }

  static Map<String, dynamic> paramsCreate(Cars cars) {
    Map<String, dynamic> params = {};
    params.addAll({
      'name': cars.name ,
      'color': cars.color.toString(),
      'number': cars.number.toString(),
    });
    return params;
  }

  static Map<String, dynamic> paramsUpdate(Users users) {
    Map<String, dynamic> params = {};
    params.addAll({
      'name': users.name.toString() ,
      'age': users.age.toString(),
      'language': users.language.toString(),
    });
    return params;
  }

/* Http Parsing*/
  static List <Users> parsePostList(String response) {
    dynamic json = jsonDecode(response);
    var data = List<Users>.from(json.map((x)=>Users.fromJson(x)));
    return data;
  }
}

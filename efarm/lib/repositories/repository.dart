import 'package:dio/dio.dart';
import 'package:efarm/utils/app_constant.dart';
import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../models/auth_error_model.dart';
import '../models/user_model.dart';
import '../models/users_response.dart';

class Repository{
  final Dio _dio = Dio();
  final String _serverUrl = '${Constant.serverUrl}api/v1/';


  Future<void> persistToken(String token) async {
    // Save the token locally using shared preferences or any other persistent storage solution.
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('access_token', token);
  }

  Future<void> setLoggedInStatus(bool isLoggedIn) async {
    // Save the token locally using shared preferences or any other persistent storage solution.
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('is_logged', isLoggedIn);
  }

  Future<bool> isLoggedIn() async {
    // Save the token locally using shared preferences or any other persistent storage solution.
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool('is_logged') ?? false;
  }

  Future<bool> deleteToken() async {
    // Delete the token from local storage.
    final prefs = await SharedPreferences.getInstance();
    final success = await prefs.remove('access_token');

    if (success) {
      return true;
    }else{
      return false;
    }
  }

  Future<String> getToken() async {
    // Check if there's a token stored in local storage.
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('access_token');

    if (token != null) {
      return token;
    }else{
      return "";
    }
  }

  Future<String?> authenticate({
    required String email,
    required String password,
  }) async {
    try {
      var response = await _dio.post('${_serverUrl}login',
          options: Options(
              headers: {
                'Accept': 'application/json',
              }),
          data: {'email': email, 'password': password});

      if (response.statusCode == 200 && response.data != '') {
        persistToken(response.data);
        return response.data;
      }else{
        return null;
      }
    } catch (error) {
      return null;
    }
  }

  Future registerUser({
    required String email,
    required String phone,
    required String name,
    required String password,
    required String address,
    required String type
  }) async {
    var result = <String, dynamic>{};
    try {
      var response = await _dio.post('${_serverUrl}register',
          options: Options(
              receiveDataWhenStatusError: true,
              headers: {
                'Accept': 'application/json',
              }),
          data: {'name': name, 'phone': phone, 'email': email, 'password': password, 'address':address, 'type': type});
      if (response.statusCode == 201 && response.data != '') {
        final token = await authenticate(email: email, password: password);
        if (token != null) {
          result['hasError'] = false;
          result['user'] = UserModel.fromJson(response.data);
          return result;
        }
      }
    } catch (exception) {
      if (exception.runtimeType == DioError) {
        var dioException = exception as DioError;
        // if (kDebugMode) {
        //   print("Exception Data: ${dioException.response?.data}");
        // }
        if(dioException.response?.statusCode == 422){
          result['hasError'] = true;
          result['error'] = AuthErrorModel.fromJson(dioException.response?.data);
          return result;
        }
      }
      rethrow; // or do something else with response
    }
  }



  Future<UserModel?> getUser(String token) async {
    try {
      var user = await Dio().get('${_serverUrl}user',
          options: Options(headers: {
            'Authorization': 'Bearer $token',
            'Accept': 'application/json',
          }));

      if (user.statusCode == 200 && user.data != '') {
        return UserModel.fromJson(user.data);
      }else{
        return null;
      }
    } catch (error) {
      if (kDebugMode) {
        print(error);
      }
      return null;
    }
  }

  Future<UsersResponse> getUsers() async {
    try {
      final token = await getToken();
      var user = await Dio().get('${_serverUrl}users',
          options: Options(headers: {
            'Authorization': 'Bearer $token',
            'Accept': 'application/json',
          }));

      if (user.statusCode == 200 && user.data != '') {
        return UsersResponse.fromJson(user.data);
      }else{
        return UsersResponse.withError("Something went wrong...");
      }
    } catch (error) {
      if (kDebugMode) {
        print(error);
      }
      return UsersResponse.withError(error.toString());
    }
  }
}
import 'dart:convert';

 import 'package:flutter/material.dart';
import 'package:huungry/features/auth/presentations/manager/login/cubit.dart';
 import 'package:shared_preferences/shared_preferences.dart';
 import '../../features/auth/data/models/user_model.dart';
import '../constants/const_string.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';


class AppController {
  AppController._() {
    init();
  }

  static final AppController _instance = AppController._();

  static AppController get instance => _instance;

  late SharedPreferences _sharedPreferences;

  static const _userKey = 'app_user_data';

  Future init() async {
    _sharedPreferences = await SharedPreferences.getInstance();
  }

  bool isLoggedIn() {
    return _sharedPreferences.getBool(isLoggedin) ?? false;
  }
  

  Future setLoggedIn(bool loggedIn) async {
    await _sharedPreferences.setBool(isLoggedin, loggedIn);
  }

  /// Save UserModel in secure storage
  Future<void> setUser(UserModel user) async {
    final userJson = jsonEncode(user.toJson());
    await setSecuredString(_userKey, userJson);
  }

  /// Retrieve UserModel from secure storage
  Future<UserModel> getUser() async {
    final userJson = await getSecuredString(_userKey);
    if (userJson.isEmpty) return UserModel.emptyOne();
    try {
      final data = jsonDecode(userJson);
      return UserModel.fromJson(data);
    } catch (_) {
      return UserModel.emptyOne();
    }
  }



  bool onBoardingDone() {
    return _sharedPreferences.getBool(onBoardingText) ?? false;
  }

  Future setBoardingDone(bool value) async {
    await _sharedPreferences.setBool(onBoardingText, value);
  }






  Future<void> logout(BuildContext context) async {
   AuthCubit.get(context).logout();
    await setLoggedIn(false);
    await _sharedPreferences.setBool(onBoardingText, true);
    await setSecuredString(tokenText, '');

    await clearUser();
  }

  static setSecuredString(String key, String value) async {
    const flutterSecureStorage = FlutterSecureStorage();
    debugPrint(
      "FlutterSecureStorage : setSecuredString with key : $key and value : $value",
    );
    await flutterSecureStorage.write(key: key, value: value);
  }

  static Future<String> getSecuredString(String key) async {
    const flutterSecureStorage = FlutterSecureStorage();
    debugPrint('FlutterSecureStorage : getSecuredString with key : $key');
    return await flutterSecureStorage.read(key: key) ?? '';
  }

  static clearAllSecuredData() async {
    debugPrint('FlutterSecureStorage : all data has been cleared');
    const flutterSecureStorage = FlutterSecureStorage();
    await flutterSecureStorage.deleteAll();
  }

  /// Clear stored user data
  Future<void> clearUser() async {
    const flutterSecureStorage = FlutterSecureStorage();
    await flutterSecureStorage.delete(key: _userKey);
  }
}

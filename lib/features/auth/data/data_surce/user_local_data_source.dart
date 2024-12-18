import 'dart:convert';
import 'package:getjob/core/constants/string.dart';
import 'package:getjob/core/errors/exceptions.dart';
import 'package:getjob/features/auth/data/models/user_model.dart';
import 'package:getjob/main.dart';
import 'package:shared_preferences/shared_preferences.dart';

abstract class UserLocalDataSource {
  Future<void> setUser(UserModel user);
  UserModel getUser();
  bool checkLogin();
  Future<void> saveLogin();
  Future<void> deleteUser();
  Future<void> deleteLogin();
  Future<bool> logout();
  Future<bool> setFirstStart();
  bool checkFirstStart();
}

class UserLocalDataSourceImpl implements UserLocalDataSource {
  final SharedPreferences sharedPreferences = sharedpref;

  UserLocalDataSourceImpl();
  @override
  UserModel getUser() {
    final result =
        sharedPreferences.getString(SharedPreferenceKeys.addOrGetUserKey);

    if (result != null) {
      return UserModel.fromJson(jsonDecode(result));
    } else {
      throw CacheExcptions(message: 'no data in the saved in local device');
    }
  }

  @override
  Future<void> setUser(UserModel user) async {
    await sharedPreferences.setString(
        SharedPreferenceKeys.addOrGetUserKey, jsonEncode(user.toJson()));
  }

  @override
  bool checkLogin() {
    return sharedPreferences.getBool(SharedPreferenceKeys.checkLoginKey) ??
        false;
  }

  @override
  Future<void> saveLogin() async {
    final result = await sharedPreferences.setBool(
        SharedPreferenceKeys.checkLoginKey, true);
    !result ? throw CacheExcptions(message: 'the process is faild') : null;
  }

  @override
  Future<void> deleteLogin() async {
    final result =
        await sharedPreferences.remove(SharedPreferenceKeys.checkLoginKey);
    !result ? throw CacheExcptions(message: 'the process is faild') : null;
  }

  @override
  Future<void> deleteUser() async {
    final result =
        await sharedPreferences.remove(SharedPreferenceKeys.addOrGetUserKey);
    !result ? throw CacheExcptions(message: 'the process is faild') : null;
  }

  @override
  Future<bool> logout() async {
    final res1 =
        await sharedPreferences.remove(SharedPreferenceKeys.addOrGetUserKey);
    final res2 =
        await sharedPreferences.remove(SharedPreferenceKeys.checkLoginKey);
    return res1 && res2;
  }

  @override
  bool checkFirstStart() {
    return sharedPreferences.getBool(SharedPreferenceKeys.firstStart) ?? true;
  }

  @override
  Future<bool> setFirstStart() async {
    return await sharedPreferences.setBool(
        SharedPreferenceKeys.firstStart, false);
  }
}

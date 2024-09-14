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
    final result =
        sharedPreferences.getBool(SharedPreferenceKeys.checkLoginKey);
    if (result != null) {
      return true;
    } else {
      return false;
    }
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
}

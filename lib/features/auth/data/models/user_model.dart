import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:getjob/core/constants/string.dart';
import 'package:getjob/features/auth/domain/entities/user.dart';

class UserModel extends Users {
  UserModel(
      {required super.name,
      required super.image,
      required super.password,
      required super.email,
      required super.id,
      super.file,
      required super.verify});

  factory UserModel.fromUserCredential(
      DocumentSnapshot<Map<String, dynamic>> data,
      UserCredential userCredential) {
    return UserModel(
      name: data[UserStringConst.userName],
      image: data[UserStringConst.userImage],
      password: data[UserStringConst.userPassword],
      email: data[UserStringConst.userEmail],
      id: data[UserStringConst.userId],
      verify: userCredential.user!.emailVerified,
    );
  }

  factory UserModel.fromUsers(Users user) {
    return UserModel(
        name: user.name,
        image: user.image,
        password: user.password,
        email: user.email,
        id: user.id,
        verify: user.verify,
        file: user.file);
  }

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
        name: json[SharedPreferenceKeys.userNameKey],
        image: json[SharedPreferenceKeys.userImageKey],
        password: json[SharedPreferenceKeys.userPassword],
        email: json[SharedPreferenceKeys.userEmail],
        id: json[SharedPreferenceKeys.userId],
        verify: json[SharedPreferenceKeys.userverify]);
  }

  Map<String, dynamic> toJson() {
    return {
      SharedPreferenceKeys.userId: id,
      SharedPreferenceKeys.userEmail: email,
      SharedPreferenceKeys.userImageKey: image,
      SharedPreferenceKeys.userNameKey: name,
      SharedPreferenceKeys.userPassword: password,
      SharedPreferenceKeys.userverify: verify
    };
  }
}

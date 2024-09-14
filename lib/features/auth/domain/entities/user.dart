import 'dart:io';

class Users {
  final String name;
  String image;
  String password;
  final String email;
  String id;
  final File? file;
  final bool verify;

  Users(
      {required this.name,
      required this.image,
      required this.password,
      required this.email,
      required this.id,
      required this.verify,
      this.file});
}

import 'package:getjob/core/constants/string.dart';

class PersonModel {
  String? name;
  String? email;
  String? imageUrl;

  PersonModel({this.email, this.name, this.imageUrl});
  PersonModel.fromJson(Map<String, dynamic> json) {
    name = json[workerUserName];
    email = json[workerEmail];
    imageUrl = json[workerImage];
  }
}

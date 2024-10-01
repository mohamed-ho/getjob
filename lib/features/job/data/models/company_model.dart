import 'package:getjob/core/constants/string.dart';

class CompanyModel {
  String? name;
  String? email;
  String? imageUrl;

  CompanyModel({this.email, this.name, this.imageUrl});
  CompanyModel.fromJson(Map<String, dynamic> json) {
    name = json[workerUserName];
    email = json[workerEmail];
    imageUrl = json[workerImage];
  }
}

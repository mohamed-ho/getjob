// ignore_for_file: non_constant_identifier_names
import 'package:getjob/core/constants/string.dart';

class OrderModel {
  String? CVUrl;
  String? workername;
  String? email;
  String? address;
  String? jobId;
  String? message;
  String? workerId;

  OrderModel(
      {required this.CVUrl,
      required this.workername,
      required this.address,
      required this.email,
      required this.jobId,
      required this.message,
      required this.workerId});
  OrderModel.formJson(Map json) {
    CVUrl = json[orderCv];
    workername = json[orderworkerName];
    address = json[ordercounty];
    email = json[email];
    jobId = json[orderjobId];
    message = json[orderMessage];
    workerId = json[orderWorkerId];
  }
}

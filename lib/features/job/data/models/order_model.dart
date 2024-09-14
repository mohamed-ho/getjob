import 'package:getjob/core/constants/string.dart';

class OrderModel {
  String? CVUrl;
  String? Workername;
  String? email;
  String? address;
  String? jobId;
  String? message;
  String? workerId;

  OrderModel(
      {required this.CVUrl,
      required this.Workername,
      required this.address,
      required this.email,
      required this.jobId,
      required this.message,
      required this.workerId});
  OrderModel.formJson(Map json) {
    CVUrl = json[orderCv];
    Workername = json[orderworkerName];
    address = json[ordercounty];
    email = json[email];
    jobId = json[orderjobId];
    message = json[orderMessage];
    workerId = json[orderWorkerId];
  }
}

import 'package:cloud_firestore/cloud_firestore.dart';

class Job {
  final String id;
  final String title;
  final int salary;
  final String description;
  final String address;
  final String type;
  final String category;
  final String subCategory;
  final String companyId;
  final String companyName;
  final String companyImage;
  final int numberOfOrders;
  final int readedOrders;
  final Timestamp sharedAt;
  final List<dynamic> jobQualifications;

  Job(
      {required this.id,
      required this.title,
      required this.salary,
      required this.description,
      required this.address,
      required this.type,
      required this.category,
      required this.subCategory,
      required this.companyId,
      required this.companyName,
      required this.companyImage,
      required this.numberOfOrders,
      required this.jobQualifications,
      required this.readedOrders,
      required this.sharedAt});
}

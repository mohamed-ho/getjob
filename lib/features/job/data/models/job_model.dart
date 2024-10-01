import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:getjob/core/constants/string.dart';
import 'package:getjob/features/job/domain/entities/job.dart';

class JobModel extends Job {
  JobModel(
      {required super.id,
      required super.title,
      required super.salary,
      required super.description,
      required super.address,
      required super.type,
      required super.category,
      required super.subCategory,
      required super.companyId,
      required super.companyName,
      required super.companyImage,
      required super.numberOfOrders,
      required super.jobQualifications,
      required super.readedOrders,
      required super.sharedAt});

  factory JobModel.fromJson(QueryDocumentSnapshot<Map<String, dynamic>> json) {
    return JobModel(
        id: json.id,
        title: json[JobStringConst.jobTitle],
        salary: json[JobStringConst.jobSalary],
        description: json[JobStringConst.jobDescription],
        address: json[JobStringConst.jobAddress],
        type: json[JobStringConst.jobType],
        category: json[JobStringConst.jobCatecory],
        subCategory: json[JobStringConst.jobSubCategory],
        companyId: json[JobStringConst.jobCompanyId],
        companyName: json[JobStringConst.jobCompanyName],
        companyImage: json[JobStringConst.jobCompanyImage],
        numberOfOrders: json[JobStringConst.jobNumberOfOrder],
        jobQualifications: json[JobStringConst.jobQualifications],
        readedOrders: json[JobStringConst.jobReadedOrder],
        sharedAt: json[JobStringConst.jobShareTime]);
  }

  factory JobModel.fromJob(Job job) {
    return JobModel(
        id: job.id,
        title: job.title,
        salary: job.salary,
        description: job.description,
        address: job.address,
        type: job.type,
        category: job.category,
        subCategory: job.subCategory,
        companyId: job.companyId,
        companyName: job.companyName,
        companyImage: job.companyImage,
        numberOfOrders: job.numberOfOrders,
        jobQualifications: job.jobQualifications,
        readedOrders: job.readedOrders,
        sharedAt: job.sharedAt);
  }

  Map<String, dynamic> toJson() {
    return {
      JobStringConst.jobTitle: title,
      JobStringConst.jobSalary: salary,
      JobStringConst.jobDescription: description,
      JobStringConst.jobAddress: address,
      JobStringConst.jobType: type,
      JobStringConst.jobCatecory: category,
      JobStringConst.jobSubCategory: subCategory,
      JobStringConst.jobCompanyId: companyId,
      JobStringConst.jobCompanyName: companyName,
      JobStringConst.jobCompanyImage: companyImage,
      JobStringConst.jobNumberOfOrder: numberOfOrders,
      JobStringConst.jobQualifications: jobQualifications,
      JobStringConst.jobReadedOrder: readedOrders,
      JobStringConst.jobShareTime: sharedAt
    };
  }
}

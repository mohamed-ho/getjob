import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:getjob/core/constants/string.dart';
import 'package:getjob/features/jobOrder/domain/entities/job_order.dart';

class JobOrderModel extends JobOrder {
  JobOrderModel(
      {required super.id,
      required super.companyName,
      required super.jobTitle,
      required super.companyImage,
      required super.isDelivered,
      required super.salary,
      required super.address,
      required super.userId,
      required super.applicationId,
      required super.jobId});

  factory JobOrderModel.fromJobOrder(JobOrder jobOrder) {
    return JobOrderModel(
        id: jobOrder.id,
        companyName: jobOrder.companyName,
        jobTitle: jobOrder.jobTitle,
        companyImage: jobOrder.companyImage,
        isDelivered: jobOrder.isDelivered,
        salary: jobOrder.salary,
        address: jobOrder.address,
        userId: jobOrder.userId,
        applicationId: jobOrder.applicationId,
        jobId: jobOrder.jobId);
  }

  factory JobOrderModel.queryDocumentSnapshot(QueryDocumentSnapshot query) {
    return JobOrderModel(
        id: query.id,
        companyName: query[JobOrderStringCosnt.companyName],
        jobTitle: query[JobOrderStringCosnt.jobTitle],
        companyImage: query[JobOrderStringCosnt.companyImage],
        isDelivered: query[JobOrderStringCosnt.isDelivered],
        salary: query[JobOrderStringCosnt.salary],
        address: query[JobOrderStringCosnt.address],
        userId: query[JobOrderStringCosnt.userId],
        applicationId: query[JobOrderStringCosnt.applicationId],
        jobId: query[JobOrderStringCosnt.jobId]);
  }

  Map<String, dynamic> toJson() {
    return {
      JobOrderStringCosnt.companyName: companyName,
      JobOrderStringCosnt.companyImage: companyImage,
      JobOrderStringCosnt.jobTitle: jobTitle,
      JobOrderStringCosnt.salary: salary,
      JobOrderStringCosnt.address: address,
      JobOrderStringCosnt.isDelivered: isDelivered,
      JobOrderStringCosnt.userId: userId,
      JobOrderStringCosnt.applicationId: applicationId,
      JobOrderStringCosnt.jobId: jobId
    };
  }
}

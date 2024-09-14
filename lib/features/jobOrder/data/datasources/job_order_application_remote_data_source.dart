import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:getjob/core/constants/string.dart';
import 'package:getjob/features/applications/data/data_source/application_remote_data_source.dart';
import 'package:getjob/features/auth/auth_enjection_container.dart';
import 'package:getjob/features/job/data/Data_source/job_remote_date_source.dart';
import 'package:getjob/features/job/data/models/job_model.dart';
import 'package:getjob/features/job/domain/entities/filter_job.dart';
import 'package:getjob/features/jobOrder/data/models/job_order_model.dart';

abstract class JobOrderApplicationRemoteDataSource {
  Future<void> addJobOrder(JobOrderModel jobOrder);
  Future<void> deleteJobOrder(JobOrderModel jobOrder);
  Future<void> updateJobOrderIsDelivered(String jobOrderId);
  Future<List<JobOrderModel>> getJobOrders(String userId);
}

class JobOrderApplicationRemoteDataSourcImpl
    implements JobOrderApplicationRemoteDataSource {
  final FirebaseFirestore firebaseFirestore;

  JobOrderApplicationRemoteDataSourcImpl({required this.firebaseFirestore});
  @override
  Future<void> addJobOrder(JobOrderModel jobOrder) async {
    try {
      await firebaseFirestore
          .collection(FireBaseStringConst.jobOrderCollectinName)
          .add(jobOrder.toJson());
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<void> deleteJobOrder(JobOrderModel jobOrder) async {
    try {
      final application =
          await ls<ApplicationRemoteDataSource>().getJobApplication(jobOrder);
      await ls<ApplicationRemoteDataSource>()
          .deleteUserApplication(application);
      await firebaseFirestore
          .collection(FireBaseStringConst.jobOrderCollectinName)
          .doc(jobOrder.id)
          .delete();
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<void> updateJobOrderIsDelivered(String jobOrderId) async {
    try {
      await firebaseFirestore
          .collection(FireBaseStringConst.jobOrderCollectinName)
          .doc(jobOrderId)
          .update({JobOrderStringCosnt.isDelivered: true});
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<List<JobOrderModel>> getJobOrders(String userId) async {
    try {
      final result = await firebaseFirestore
          .collection(FireBaseStringConst.jobOrderCollectinName)
          .where(JobOrderStringCosnt.userId, isEqualTo: userId)
          .get();
      return List<JobOrderModel>.from(
          result.docs.map((e) => JobOrderModel.queryDocumentSnapshot(e)));
    } catch (e) {
      rethrow;
    }
  }
}

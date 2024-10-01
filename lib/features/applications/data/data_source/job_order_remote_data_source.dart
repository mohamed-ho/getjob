import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:getjob/core/constants/string.dart';

abstract class JobOrderRemoteDataSource {
  Future<int> getJobOrders(String jobId);
  Future<void> increaseJobOrders(String jobId);
  Future<void> decreaseJobOrders(String jobId);
  Future<int> getUnReadingOrders(String jobId);
  Future<void> updateReadedOrders(String jobId);
  Future<int> getReadedOrders(String jobId);
}

class JobOrderRemoteDataSourceImpl extends JobOrderRemoteDataSource {
  final FirebaseFirestore firebaseFirestore;

  JobOrderRemoteDataSourceImpl({required this.firebaseFirestore});
  @override
  Future<void> decreaseJobOrders(String jobId) async {
    try {
      final numberOfOrders = await getJobOrders(jobId);
      await firebaseFirestore
          .collection(FireBaseStringConst.jobCollectionName)
          .doc(jobId)
          .update({JobStringConst.jobNumberOfOrder: numberOfOrders - 1});
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<int> getJobOrders(String jobId) async {
    try {
      final request = await firebaseFirestore
          .collection(FireBaseStringConst.jobCollectionName)
          .doc(jobId)
          .get();
      return request[JobStringConst.jobNumberOfOrder];
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<int> getUnReadingOrders(String jobId) async {
    try {
      final numberOfOrders = await getJobOrders(jobId);
      final numberOfReadedOrders = await getReadedOrders(jobId);
      return numberOfOrders - numberOfReadedOrders;
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<void> increaseJobOrders(String jobId) async {
    try {
      final numberOfOrders = await getJobOrders(jobId);
      await firebaseFirestore
          .collection(FireBaseStringConst.jobCollectionName)
          .doc(jobId)
          .update({JobStringConst.jobNumberOfOrder: numberOfOrders + 1});
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<int> getReadedOrders(String jobId) async {
    final request = await firebaseFirestore
        .collection(FireBaseStringConst.jobCollectionName)
        .doc(jobId)
        .get();
    return request[JobStringConst.jobReadedOrder];
  }

  @override
  Future<void> updateReadedOrders(String jobId) async {
    final numberOfOrders = await getJobOrders(jobId);
    await firebaseFirestore
        .collection(FireBaseStringConst.jobCollectionName)
        .doc(jobId)
        .update({JobStringConst.jobReadedOrder: numberOfOrders});
  }
}

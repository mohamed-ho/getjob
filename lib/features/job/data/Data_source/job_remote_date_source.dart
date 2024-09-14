import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:getjob/core/constants/string.dart';
import 'package:getjob/features/job/data/models/job_model.dart';
import 'package:getjob/features/job/domain/entities/filter_job.dart';

abstract class JobRemoteDateSource {
  Future<void> addJob(JobModel job);

  Future<List<JobModel>> getJobs();
  Future<void> deleteJob(String jobId);
  Future<void> updateJob(JobModel job);
  Future<List<JobModel>> getJobsByFilter({required FilterJob filter});
  Future<List<JobModel>> getFevoriteJobs(int numberOfJobs);
}

class JobRemoteDateSourceImpl implements JobRemoteDateSource {
  final FirebaseFirestore firebaseFirestore;

  JobRemoteDateSourceImpl({required this.firebaseFirestore});
  @override
  Future<void> addJob(JobModel job) async {
    try {
      await firebaseFirestore
          .collection(FireBaseStringConst.jobCollectionName)
          .add(job.toJson());
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<void> deleteJob(String jobId) async {
    try {
      await firebaseFirestore
          .collection(FireBaseStringConst.jobCollectionName)
          .doc(jobId)
          .delete();
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<List<JobModel>> getJobs() async {
    try {
      QuerySnapshot<Map<String, dynamic>> result = await firebaseFirestore
          .collection(FireBaseStringConst.jobCollectionName)
          .orderBy(JobStringConst.jobShareTime)
          .get();
      return List<JobModel>.from(result.docs.map((e) => JobModel.fromJson(e)));
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<void> updateJob(JobModel job) async {
    try {
      firebaseFirestore
          .collection(FireBaseStringConst.jobCollectionName)
          .doc(job.id)
          .update(job.toJson());
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<List<JobModel>> getJobsByFilter({required FilterJob filter}) async {
    try {
      QuerySnapshot<Map<String, dynamic>> response = await firebaseFirestore
          .collection(FireBaseStringConst.jobCollectionName)
          .get();
      List<QueryDocumentSnapshot<Map<String, dynamic>>> result = response.docs;
      if (filter.salary != null) {
        QuerySnapshot<Map<String, dynamic>> response = await firebaseFirestore
            .collection(FireBaseStringConst.jobCollectionName)
            .where(JobStringConst.jobSalary,
                isGreaterThanOrEqualTo: filter.salary![0],
                isLessThanOrEqualTo: filter.salary![1])
            .get();
        result = response.docs;
      }
      if (filter.companyId != null) {
        result = result
            .where((value) =>
                value[JobStringConst.jobCompanyId] == filter.companyId)
            .toList();
      }

      if (filter.category != null) {
        result = result
            .where(
                (value) => value[JobStringConst.jobCatecory] == filter.category)
            .toList();
      }
      if (filter.subCategory != null) {
        result = result
            .where((value) =>
                value[JobStringConst.jobSubCategory] == filter.subCategory)
            .toList();
      }
      if (filter.location != null) {
        result = result
            .where(
                (value) => value[JobStringConst.jobAddress] == filter.location)
            .toList();
      }

      if (filter.type != null) {
        result = result
            .where((value) => value[JobStringConst.jobType] == filter.type)
            .toList();
      }
      return List<JobModel>.from(result.map((e) => JobModel.fromJson(e)));
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<List<JobModel>> getFevoriteJobs(int numberOfJobs) async {
    try {
      QuerySnapshot<Map<String, dynamic>> response = await firebaseFirestore
          .collection(FireBaseStringConst.jobCollectionName)
          .orderBy(JobStringConst.jobNumberOfOrder, descending: true)
          .get();
      final result =
          List<JobModel>.from(response.docs.map((e) => JobModel.fromJson(e)));
      if (result.length < numberOfJobs) return result;
      return result.getRange(0, numberOfJobs).toList();
    } catch (e) {
      rethrow;
    }
  }
}

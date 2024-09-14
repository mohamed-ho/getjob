import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:getjob/core/constants/string.dart';
import 'package:getjob/features/applications/data/models/application_model.dart';
import 'package:getjob/features/applications/domain/entities/application.dart';
import 'package:getjob/features/auth/auth_enjection_container.dart';
import 'package:getjob/features/applications/data/data_source/job_order_remote_data_source.dart';
import 'package:getjob/features/auth/data/data_surce/user_local_data_source.dart';
import 'package:getjob/features/jobOrder/data/datasources/job_order_application_remote_data_source.dart';
import 'package:getjob/features/jobOrder/data/models/job_order_model.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as path;
import 'package:http/http.dart' as http;

abstract class ApplicationRemoteDataSource {
  Future<void> addApplication(
      ApplicationModel application, JobOrderModel jobOrder);
  Future<void> updateApplication(ApplicationModel application);
  Future<List<ApplicationModel>> getJobApplications(String jobId);
  Future<List<ApplicationModel>> getUserApplications(String userId);
  Future<void> deleteJobApplications(String jobId);
  Future<void> deleteUserApplication(Application application);
  Future<ApplicationModel> getJobApplication(JobOrderModel jobOrder);
  Future<bool> youActuallySendApplication(String jobId);
  Future<File> downloadCV(String cvUrl);
  String openCv(String cvUrl);
  Future<void> openPDF(BuildContext context, String url);
}

class ApplicationRemoteDataSourceImpl implements ApplicationRemoteDataSource {
  final FirebaseFirestore firebaseFirestore;
  final FirebaseStorage firebaseStorage;
  ApplicationRemoteDataSourceImpl(
      {required this.firebaseFirestore, required this.firebaseStorage});
  CollectionReference<Map<String, dynamic>> _getJobApplicationCollection(
      String jobId) {
    return firebaseFirestore
        .collection(FireBaseStringConst.jobCollectionName)
        .doc(jobId)
        .collection(FireBaseStringConst.applicationsCollectionName);
  }

  @override
  Future<void> addApplication(
      ApplicationModel application, JobOrderModel jobOrder) async {
    try {
      if (await youActuallySendApplication(application.jobId)) {
        throw Exception(ErrorStringConst.youActuallySendApplicationError);
      } else {
        final filePath = path.extension(application.cvFile!.path);
        final cvRef = firebaseStorage.ref(FireBaseStringConst.usersCVsPath).child(
            '${application.applicationOwnerId}${application.jobId}$filePath');
        await cvRef.putFile(application.cvFile!);
        application.filePath = await cvRef.getDownloadURL();
        String applicationId = '';
        await _getJobApplicationCollection(application.jobId)
            .add(application.toJson())
            .then((value) {
          applicationId = value.id;
        });
        await ls<JobOrderRemoteDataSource>()
            .increaseJobOrders(application.jobId);
        jobOrder.applicationId = applicationId;
        await ls<JobOrderApplicationRemoteDataSource>().addJobOrder(jobOrder);
      }
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<void> deleteJobApplications(String jobId) async {
    try {
      final data = await _getJobApplicationCollection(jobId).get();

      WriteBatch batch = FirebaseFirestore.instance.batch();
      for (var doc in data.docs) {
        await firebaseStorage
            .ref(FireBaseStringConst.usersCVsPath)
            .child(_extractFileName(
                doc[ApplicationStringConst.applicationCvFilePath]))
            .delete();
        batch.delete(doc.reference);
      }
      await batch.commit();
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<void> deleteUserApplication(Application application) async {
    try {
      await firebaseStorage
          .ref(FireBaseStringConst.usersCVsPath)
          .child(_extractFileName(application.filePath))
          .delete();
      await _getJobApplicationCollection(application.jobId)
          .doc(application.id)
          .delete();
      await ls<JobOrderRemoteDataSource>().decreaseJobOrders(application.jobId);
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<List<ApplicationModel>> getJobApplications(String jobId) async {
    try {
      final data = await _getJobApplicationCollection(jobId).get();
      await ls<JobOrderRemoteDataSource>().updateReadedOrders(jobId);
      return List<ApplicationModel>.from(
          data.docs.map((e) => ApplicationModel.fromQueryDocumentSnapshot(e)));
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<List<ApplicationModel>> getUserApplications(String userId) async {
    try {
      final data = await firebaseFirestore
          .collection(FireBaseStringConst.jobCollectionName)
          .get();
      List<String> jobsId = List<String>.from(data.docs.map((e) => e.id));
      List<ApplicationModel> result = [];
      for (String jobId in jobsId) {
        final query = await _getJobApplicationCollection(jobId)
            .where(ApplicationStringConst.applicationOwnerId, isEqualTo: userId)
            .get();
        if (query.docs.isNotEmpty) {
          for (var doc in query.docs) {
            final app = ApplicationModel.fromQueryDocumentSnapshot(doc);
            result.add(app);
          }
        }
      }
      return result;
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<void> updateApplication(ApplicationModel application) async {
    try {
      if (application.cvFile == null) {
        await _getJobApplicationCollection(application.jobId)
            .doc(application.id)
            .update(application.toJson());
      } else {
        await firebaseStorage
            .ref(FireBaseStringConst.usersCVsPath)
            .child(_extractFileName(application.filePath))
            .delete();
        await firebaseStorage
            .ref(FireBaseStringConst.usersCVsPath)
            .child(path.basename(_extractFileName(application.filePath)))
            .putFile(application.cvFile!);
        await _getJobApplicationCollection(application.jobId)
            .doc(application.id)
            .update(application.toJson());
      }
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<ApplicationModel> getJobApplication(JobOrderModel jobOrder) async {
    try {
      final result = await firebaseFirestore
          .collection(FireBaseStringConst.jobCollectionName)
          .doc(jobOrder.jobId)
          .collection(FireBaseStringConst.applicationsCollectionName)
          .doc(jobOrder.applicationId)
          .get();
      if (result.data() != null) {
        return ApplicationModel(
            id: result.id,
            applicationOwnerId:
                result[ApplicationStringConst.applicationOwnerId],
            jobId: result[ApplicationStringConst.applicationJobId],
            firstName: result[ApplicationStringConst.applicationOwnerFirstName],
            lastName: result[ApplicationStringConst.applicationOwnerLastName],
            email: result[ApplicationStringConst.applicationeOwnerEmail],
            address: result[ApplicationStringConst.applicationOwnerAddress],
            message: result[ApplicationStringConst.applicationMessage],
            filePath: result[ApplicationStringConst.applicationCvFilePath],
            applicationOwnerImage:
                result[ApplicationStringConst.applicationOwnerImage]);
      } else {
        throw Exception('its application did not found');
      }
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<bool> youActuallySendApplication(String jobId) async {
    try {
      final result = await firebaseFirestore
          .collection(FireBaseStringConst.jobCollectionName)
          .doc(jobId)
          .collection(FireBaseStringConst.applicationsCollectionName)
          .where(ApplicationStringConst.applicationOwnerId,
              isEqualTo: ls<UserLocalDataSource>().getUser().id)
          .get();
      if (result.docs.isNotEmpty) {
        return true;
      } else {
        return false;
      }
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<void> openPDF(BuildContext context, String url) {
    // TODO: implement openPDF
    throw UnimplementedError();
  }

  @override
  Future<File> downloadCV(String cvUrl) async {
    final response = await http.get(Uri.parse(cvUrl));
    final bytes = response.bodyBytes;
    final dir = await getApplicationDocumentsDirectory();
    final file = File('${dir.path}/downloaded_pdf.pdf');
    await file.writeAsBytes(bytes);
    return file;
  }

  @override
  String openCv(String cvUrl) {
    String filePath = '';
    downloadCV(cvUrl).then((file) {
      filePath = file.path;
    });
    return filePath;
  }
}

String _extractFileName(String url) {
  // Extract the file path parameter
  final uri = Uri.parse(url);
  final filePath = uri.pathSegments.last;

  // Decode the URL-encoded file path
  final decodedPath = Uri.decodeFull(filePath);

  // Extract the file name
  final fileName = decodedPath.split('/').last;

  return fileName;
}

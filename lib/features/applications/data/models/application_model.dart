import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:getjob/core/constants/string.dart';
import 'package:getjob/features/applications/domain/entities/application.dart';

class ApplicationModel extends Application {
  ApplicationModel(
      {required super.id,
      required super.applicationOwnerId,
      required super.jobId,
      required super.firstName,
      required super.lastName,
      required super.email,
      required super.address,
      required super.message,
      required super.filePath,
      required super.applicationOwnerImage,
      super.cvFile});
  factory ApplicationModel.fromQueryDocumentSnapshot(
      QueryDocumentSnapshot querDecument) {
    return ApplicationModel(
        id: querDecument[ApplicationStringConst.applicationId],
        applicationOwnerId:
            querDecument[ApplicationStringConst.applicationOwnerId],
        jobId: querDecument[ApplicationStringConst.applicationJobId],
        firstName:
            querDecument[ApplicationStringConst.applicationOwnerFirstName],
        lastName: querDecument[ApplicationStringConst.applicationOwnerLastName],
        email: querDecument[ApplicationStringConst.applicationeOwnerEmail],
        address: querDecument[ApplicationStringConst.applicationOwnerAddress],
        message: querDecument[ApplicationStringConst.applicationMessage],
        filePath: querDecument[ApplicationStringConst.applicationCvFilePath],
        applicationOwnerImage:
            querDecument[ApplicationStringConst.applicationOwnerImage]);
  }
  Map<String, dynamic> toJson() {
    return {
      ApplicationStringConst.applicationId: id,
      ApplicationStringConst.applicationOwnerId: applicationOwnerId,
      ApplicationStringConst.applicationJobId: jobId,
      ApplicationStringConst.applicationOwnerFirstName: firstName,
      ApplicationStringConst.applicationOwnerLastName: lastName,
      ApplicationStringConst.applicationeOwnerEmail: email,
      ApplicationStringConst.applicationOwnerAddress: address,
      ApplicationStringConst.applicationMessage: message,
      ApplicationStringConst.applicationCvFilePath: filePath,
      ApplicationStringConst.applicationOwnerImage: applicationOwnerImage
    };
  }

  factory ApplicationModel.fromApplication(Application application) {
    return ApplicationModel(
        id: application.id,
        applicationOwnerId: application.applicationOwnerId,
        jobId: application.jobId,
        firstName: application.firstName,
        lastName: application.lastName,
        email: application.email,
        address: application.address,
        message: application.message,
        filePath: application.filePath,
        cvFile: application.cvFile,
        applicationOwnerImage: application.applicationOwnerImage);
  }
}

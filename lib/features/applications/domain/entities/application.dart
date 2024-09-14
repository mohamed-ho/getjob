import 'dart:io';

class Application {
  final String id;
  final String applicationOwnerId;
  final String firstName;
  final String lastName;
  final String email;
  final String address;
  final String message;
  final String jobId;
  final File? cvFile;
  String filePath;
  final String applicationOwnerImage;

  Application(
      {required this.id,
      required this.applicationOwnerId,
      required this.jobId,
      required this.firstName,
      required this.lastName,
      required this.email,
      required this.address,
      required this.message,
      required this.filePath,
      this.cvFile,
      required this.applicationOwnerImage});
}

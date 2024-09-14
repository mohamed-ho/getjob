class JobOrder {
  final String id;
  final String companyName;
  final String jobTitle;
  final String companyImage;
  final bool isDelivered;
  final int salary;
  final String address;
  final String userId;
  String applicationId;
  final String jobId;

  JobOrder(
      {required this.id,
      required this.companyName,
      required this.jobTitle,
      required this.companyImage,
      required this.isDelivered,
      required this.salary,
      required this.address,
      required this.userId,
      required this.applicationId,
      required this.jobId});
}

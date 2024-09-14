import 'package:dartz/dartz.dart';
import 'package:getjob/core/errors/failure.dart';
import 'package:getjob/features/applications/domain/entities/application.dart';
import 'package:getjob/features/jobOrder/domain/entities/job_order.dart';

abstract class ApplicationRepository {
  Future<Either<Failure, void>> addApplication(
      Application application, JobOrder jobOrder);
  Future<Either<Failure, void>> updateApplication(Application application);
  Future<Either<Failure, List<Application>>> getJobApplications(String jobId);
  Future<Either<Failure, List<Application>>> getUserApplications(String userId);

  Future<Either<Failure, void>> deleteJobApplications(String jobId);
  Future<Either<Failure, void>> deleteUserApplication(Application application);
  Future<Either<Failure, Application>> getJobApplication(JobOrder jobOrder);
}

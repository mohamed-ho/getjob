import 'package:dartz/dartz.dart';
import 'package:getjob/core/errors/exceptions.dart';
import 'package:getjob/core/errors/failure.dart';
import 'package:getjob/features/applications/data/data_source/application_remote_data_source.dart';
import 'package:getjob/features/applications/data/models/application_model.dart';
import 'package:getjob/features/applications/domain/entities/application.dart';
import 'package:getjob/features/applications/domain/repository/order_application.dart';
import 'package:getjob/features/jobOrder/data/models/job_order_model.dart';
import 'package:getjob/features/jobOrder/domain/entities/job_order.dart';

class ApplicationRepositoryImpl implements ApplicationRepository {
  final ApplicationRemoteDataSource applicationRemoteDataSource;

  ApplicationRepositoryImpl({required this.applicationRemoteDataSource});
  @override
  Future<Either<Failure, void>> addApplication(
      Application application, JobOrder jobOrder) async {
    try {
      final result = await applicationRemoteDataSource.addApplication(
          ApplicationModel.fromApplication(application),
          JobOrderModel.fromJobOrder(jobOrder));
      return Right(result);
    } catch (e) {
      return Left(ServerFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> deleteJobApplications(String jobId) async {
    try {
      final result =
          await applicationRemoteDataSource.deleteJobApplications(jobId);
      return Right(result);
    } catch (e) {
      return Left(ServerFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> deleteUserApplication(
      Application application) async {
    try {
      final result =
          await applicationRemoteDataSource.deleteUserApplication(application);
      return Right(result);
    } catch (e) {
      return Left(ServerFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, List<Application>>> getJobApplications(
      String jobId) async {
    try {
      final result =
          await applicationRemoteDataSource.getJobApplications(jobId);
      return Right(result);
    } catch (e) {
      return Left(ServerFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, List<Application>>> getUserApplications(
      String userId) async {
    try {
      final result =
          await applicationRemoteDataSource.getUserApplications(userId);
      return Right(result);
    } catch (e) {
      return Left(ServerFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> updateApplication(
      Application application) async {
    try {
      final result = await applicationRemoteDataSource
          .updateApplication(ApplicationModel.fromApplication(application));
      return Right(result);
    } catch (e) {
      return Left(ServerFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, Application>> getJobApplication(
      JobOrder jobOrder) async {
    try {
      final result = await applicationRemoteDataSource
          .getJobApplication(JobOrderModel.fromJobOrder(jobOrder));
      return Right(result);
    } catch (e) {
      return Left(ServerFailure(message: e.toString()));
    }
  }
}

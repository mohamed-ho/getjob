import 'package:dartz/dartz.dart';
import 'package:getjob/core/errors/exceptions.dart';
import 'package:getjob/core/errors/failure.dart';
import 'package:getjob/features/jobOrder/data/datasources/job_order_application_remote_data_source.dart';
import 'package:getjob/features/jobOrder/data/models/job_order_model.dart';
import 'package:getjob/features/jobOrder/domain/entities/job_order.dart';
import 'package:getjob/features/jobOrder/domain/repositories/job_order_repository.dart';

class JobOrderRepositoryImpl implements JobOrderRepository {
  final JobOrderApplicationRemoteDataSource jobOrderApplicationRemoteDataSourc;

  JobOrderRepositoryImpl({required this.jobOrderApplicationRemoteDataSourc});
  @override
  Future<Either<Failure, void>> addJobOrder(JobOrder jobOrder) async {
    try {
      final result = await jobOrderApplicationRemoteDataSourc
          .addJobOrder(JobOrderModel.fromJobOrder(jobOrder));
      return Right(result);
    } on ServerExceptions catch (e) {
      return Left(ServerFailure(message: e.message!));
    }
  }

  @override
  Future<Either<Failure, void>> deleteJobOrder(JobOrder jobOrder) async {
    try {
      final result = await jobOrderApplicationRemoteDataSourc
          .deleteJobOrder(JobOrderModel.fromJobOrder(jobOrder));
      return Right(result);
    } on ServerExceptions catch (e) {
      return Left(ServerFailure(message: e.message!));
    }
  }

  @override
  Future<Either<Failure, void>> updateJobOrderIsDelivered(
      String jobOrderId) async {
    try {
      final result = await jobOrderApplicationRemoteDataSourc
          .updateJobOrderIsDelivered(jobOrderId);
      return Right(result);
    } on ServerExceptions catch (e) {
      return Left(ServerFailure(message: e.message!));
    }
  }

  @override
  Future<Either<Failure, List<JobOrder>>> getJobOrders(String userId) async {
    try {
      final result =
          await jobOrderApplicationRemoteDataSourc.getJobOrders(userId);
      return Right(result);
    } on ServerExceptions catch (e) {
      return Left(ServerFailure(message: e.message!));
    }
  }
}

import 'package:dartz/dartz.dart';
import 'package:getjob/core/errors/failure.dart';
import 'package:getjob/features/jobOrder/domain/entities/job_order.dart';

abstract class JobOrderRepository {
  Future<Either<Failure, void>> addJobOrder(JobOrder jobOrder);
  Future<Either<Failure, void>> deleteJobOrder(JobOrder jobOrder);
  Future<Either<Failure, void>> updateJobOrderIsDelivered(String jobOrderId);
  Future<Either<Failure, List<JobOrder>>> getJobOrders(String jobOrderId);
}

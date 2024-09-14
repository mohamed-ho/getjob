import 'package:dartz/dartz.dart';
import 'package:getjob/core/errors/failure.dart';
import 'package:getjob/core/usecase/usecase.dart';
import 'package:getjob/features/jobOrder/domain/entities/job_order.dart';
import 'package:getjob/features/jobOrder/domain/repositories/job_order_repository.dart';

class GetJobOrderUsecase implements Usecase<void, String> {
  final JobOrderRepository jobOrderRepository;

  GetJobOrderUsecase({required this.jobOrderRepository});
  @override
  Future<Either<Failure, List<JobOrder>>> call(String params) async {
    return await jobOrderRepository.getJobOrders(params);
  }
}

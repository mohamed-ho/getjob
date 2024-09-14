import 'package:dartz/dartz.dart';
import 'package:getjob/core/errors/failure.dart';
import 'package:getjob/core/usecase/usecase.dart';
import 'package:getjob/features/jobOrder/domain/entities/job_order.dart';
import 'package:getjob/features/jobOrder/domain/repositories/job_order_repository.dart';

class DeleteJobOrderUsecase implements Usecase<void, JobOrder> {
  final JobOrderRepository jobOrderRepository;

  DeleteJobOrderUsecase({required this.jobOrderRepository});
  @override
  Future<Either<Failure, void>> call(JobOrder jobOrder) async {
    return await jobOrderRepository.deleteJobOrder(jobOrder);
  }
}

import 'package:dartz/dartz.dart';
import 'package:getjob/core/errors/failure.dart';
import 'package:getjob/core/usecase/usecase.dart';
import 'package:getjob/features/jobOrder/domain/entities/job_order.dart';
import 'package:getjob/features/jobOrder/domain/repositories/job_order_repository.dart';

class AddJobOrderUsecase implements Usecase<void, JobOrder> {
  final JobOrderRepository jobOrderRepository;

  AddJobOrderUsecase({required this.jobOrderRepository});
  @override
  Future<Either<Failure, void>> call(JobOrder params) async {
    return await jobOrderRepository.addJobOrder(params);
  }
}

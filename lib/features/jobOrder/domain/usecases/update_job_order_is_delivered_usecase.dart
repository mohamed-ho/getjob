import 'package:dartz/dartz.dart';
import 'package:getjob/core/errors/failure.dart';
import 'package:getjob/core/usecase/usecase.dart';
import 'package:getjob/features/jobOrder/domain/repositories/job_order_repository.dart';

class UpdateJobOrderIsDeliveredUsecase implements Usecase<void, String> {
  final JobOrderRepository jobOrderRepository;

  UpdateJobOrderIsDeliveredUsecase({required this.jobOrderRepository});
  @override
  Future<Either<Failure, void>> call(String params) async {
    return await jobOrderRepository.updateJobOrderIsDelivered(params);
  }
}

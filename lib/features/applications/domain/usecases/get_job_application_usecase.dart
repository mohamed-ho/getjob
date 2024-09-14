import 'package:dartz/dartz.dart';
import 'package:getjob/core/errors/failure.dart';
import 'package:getjob/core/usecase/usecase.dart';
import 'package:getjob/features/applications/domain/entities/application.dart';
import 'package:getjob/features/applications/domain/repository/order_application.dart';
import 'package:getjob/features/jobOrder/domain/entities/job_order.dart';

class GetJobApplicationUsecase implements Usecase<Application, JobOrder> {
  final ApplicationRepository applicationRepository;

  GetJobApplicationUsecase({required this.applicationRepository});
  @override
  Future<Either<Failure, Application>> call(JobOrder jobOrder) async {
    return await applicationRepository.getJobApplication(jobOrder);
  }
}

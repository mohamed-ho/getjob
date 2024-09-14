import 'package:dartz/dartz.dart';
import 'package:getjob/core/errors/failure.dart';
import 'package:getjob/core/usecase/usecase.dart';
import 'package:getjob/features/applications/domain/repository/order_application.dart';

class DeleteJobApplicationsUsecase implements Usecase<void, String> {
  final ApplicationRepository applicationRepository;

  DeleteJobApplicationsUsecase({required this.applicationRepository});
  @override
  Future<Either<Failure, void>> call(String params) async {
    return await applicationRepository.deleteJobApplications(params);
  }
}

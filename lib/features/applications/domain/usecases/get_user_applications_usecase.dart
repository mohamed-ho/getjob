import 'package:dartz/dartz.dart';
import 'package:getjob/core/errors/failure.dart';
import 'package:getjob/core/usecase/usecase.dart';
import 'package:getjob/features/applications/domain/entities/application.dart';
import 'package:getjob/features/applications/domain/repository/order_application.dart';

class GetUserApplicationUsecase implements Usecase<List<Application>, String> {
  final ApplicationRepository applicationRepository;
  GetUserApplicationUsecase({required this.applicationRepository});
  @override
  Future<Either<Failure, List<Application>>> call(String params) async {
    return await applicationRepository.getJobApplications(params);
  }
}

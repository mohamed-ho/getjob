import 'package:dartz/dartz.dart';
import 'package:getjob/core/errors/failure.dart';
import 'package:getjob/core/usecase/usecase.dart';
import 'package:getjob/features/applications/domain/entities/application.dart';
import 'package:getjob/features/applications/domain/repository/order_application.dart';

class DeleteUserApplicationUsecase implements Usecase<void, Application> {
  final ApplicationRepository applicationRepository;

  DeleteUserApplicationUsecase({required this.applicationRepository});
  @override
  Future<Either<Failure, void>> call(Application params) async {
    return await applicationRepository.deleteUserApplication(params);
  }
}

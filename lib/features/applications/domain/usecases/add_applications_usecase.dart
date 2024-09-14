import 'package:dartz/dartz.dart';
import 'package:getjob/core/errors/failure.dart';
import 'package:getjob/core/usecase/usecase.dart';
import 'package:getjob/features/applications/domain/repository/order_application.dart';

class AddApplicationUsecase implements Usecase<void, List<dynamic>> {
  final ApplicationRepository applicationRepository;

  AddApplicationUsecase({required this.applicationRepository});
  @override
  Future<Either<Failure, void>> call(List<dynamic> params) async {
    return await applicationRepository.addApplication(params[0], params[1]);
  }
}

import 'package:dartz/dartz.dart';
import 'package:getjob/core/errors/failure.dart';
import 'package:getjob/core/usecase/usecase.dart';
import 'package:getjob/features/auth/domain/repository/user_repository.dart';

class ChangePasswordUsecase implements Usecase<void, String> {
  final UsersRepository usersRepository;

  ChangePasswordUsecase({required this.usersRepository});

  @override
  Future<Either<Failure, void>> call(String params) async {
    return await usersRepository.changePassword(params);
  }
}

import 'package:dartz/dartz.dart';
import 'package:getjob/core/errors/failure.dart';
import 'package:getjob/core/usecase/usecase.dart';
import 'package:getjob/features/auth/domain/repository/user_repository.dart';

class LogoutUsersUsecase implements Usecase<void, NoParams> {
  final UsersRepository usersRepository;

  LogoutUsersUsecase({required this.usersRepository});
  @override
  Future<Either<Failure, void>> call(NoParams params) async {
    return await usersRepository.logout();
  }
}

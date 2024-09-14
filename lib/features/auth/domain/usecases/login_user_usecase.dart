import 'package:dartz/dartz.dart';
import 'package:getjob/core/errors/failure.dart';
import 'package:getjob/core/usecase/usecase.dart';
import 'package:getjob/features/auth/domain/entities/user.dart';
import 'package:getjob/features/auth/domain/repository/user_repository.dart';

class LoginUsersUsecase implements Usecase<Users, List<String>> {
  final UsersRepository usersRepository;

  LoginUsersUsecase({required this.usersRepository});
  @override
  Future<Either<Failure, Users>> call(List<String> params) async {
    return await usersRepository.login(params[0], params[1]);
  }
}

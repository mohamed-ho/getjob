import 'package:dartz/dartz.dart';
import 'package:getjob/core/errors/failure.dart';
import 'package:getjob/core/usecase/usecase.dart';
import 'package:getjob/features/auth/domain/entities/user.dart';
import 'package:getjob/features/auth/domain/repository/user_repository.dart';

class LoginWithFacebookUsecase implements Usecase<Users, NoParams> {
  final UsersRepository usersRepository;

  LoginWithFacebookUsecase({required this.usersRepository});
  @override
  Future<Either<Failure, Users>> call(NoParams params) async {
    return await usersRepository.loginWithFacebook();
  }
}
import 'package:dartz/dartz.dart';
import 'package:getjob/core/errors/failure.dart';
import 'package:getjob/core/usecase/usecase.dart';
import 'package:getjob/features/auth/domain/entities/user.dart';
import 'package:getjob/features/auth/domain/repository/user_repository.dart';

class UpdateUsersUsecase implements Usecase<void, Users> {
  final UsersRepository usersRepository;

  UpdateUsersUsecase({required this.usersRepository});
  @override
  Future<Either<Failure, void>> call(Users params) async {
    return await usersRepository.update(params);
  }
}
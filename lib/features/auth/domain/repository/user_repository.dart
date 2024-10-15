import 'package:dartz/dartz.dart';
import 'package:getjob/core/errors/failure.dart';
import 'package:getjob/features/auth/domain/entities/user.dart';

abstract class UsersRepository {
  Future<Either<Failure, void>> sginUp(Users users);
  Future<Either<Failure, Users>> login(String email, String password);
  Future<Either<Failure, void>> update(Users users);
  Future<Either<Failure, void>> logout();
  Future<Either<Failure, void>> changePassword(String email);
  Future<Either<Failure, void>> deleteAccount();
}

import 'package:dartz/dartz.dart';
import 'package:getjob/core/errors/failure.dart';
import 'package:getjob/features/auth/data/data_surce/user_remote_data_source.dart';
import 'package:getjob/features/auth/data/models/user_model.dart';

import 'package:getjob/features/auth/domain/entities/user.dart';
import 'package:getjob/features/auth/domain/repository/user_repository.dart';

class UsersRepositoryImpl implements UsersRepository {
  final UserRemoteDataSource usersRemoteDataSource;

  UsersRepositoryImpl({required this.usersRemoteDataSource});
  @override
  Future<Either<Failure, Users>> login(String email, String password) async {
    try {
      final result =
          await usersRemoteDataSource.login(email: email, password: password);
      return Right(result);
    } catch (e) {
      return Left(ServerFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> logout() async {
    try {
      final result = await usersRemoteDataSource.logout();
      return Right(result);
    } catch (e) {
      return Left(ServerFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> sginUp(Users user) async {
    try {
      final result =
          await usersRemoteDataSource.signUp(UserModel.fromUsers(user));
      return Right(result);
    } catch (e) {
      return Left(ServerFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> update(Users user) async {
    try {
      final result =
          await usersRemoteDataSource.updateUser(UserModel.fromUsers(user));
      return Right(result);
    } catch (e) {
      return Left(ServerFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, Users>> loginWithFacebook() async {
    try {
      final result = await usersRemoteDataSource.loginWithFacebook();
      return Right(result);
    } catch (e) {
      return Left(ServerFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, Users>> loginWithGoogle() async {
    try {
      final result = await usersRemoteDataSource.loginWithGoogle();
      return Right(result);
    } catch (e) {
      return Left(ServerFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> changePassword(String email) async {
    try {
      final result = await usersRemoteDataSource.changePassword(email);
      return Right(result);
    } catch (e) {
      return Left(ServerFailure(message: e.toString()));
    }
  }
}

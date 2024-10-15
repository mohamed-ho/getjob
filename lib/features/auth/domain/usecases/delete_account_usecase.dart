import 'package:dartz/dartz.dart';
import 'package:getjob/core/errors/failure.dart';
import 'package:getjob/core/usecase/usecase.dart';
import 'package:getjob/features/auth/domain/repository/user_repository.dart';

class DeleteAccountUsecase implements Usecase<void, NoParams> {
  final UsersRepository usersRepository;

  DeleteAccountUsecase({required this.usersRepository});
  @override
  Future<Either<Failure, void>> call(params) async {
    return await usersRepository.deleteAccount();
  }
}

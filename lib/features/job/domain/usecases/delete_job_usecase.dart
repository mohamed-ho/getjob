import 'package:dartz/dartz.dart';
import 'package:getjob/core/errors/failure.dart';
import 'package:getjob/core/usecase/usecase.dart';
import 'package:getjob/features/job/domain/repository/job_repository.dart';

class DeleteJobUsecase implements Usecase<void, String> {
  final JobRepository jobRepository;

  DeleteJobUsecase({required this.jobRepository});
  @override
  Future<Either<Failure, void>> call(String params) async {
    return await jobRepository.deleteJob(params);
  }
}

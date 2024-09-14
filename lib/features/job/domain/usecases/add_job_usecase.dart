import 'package:dartz/dartz.dart';
import 'package:getjob/core/errors/failure.dart';
import 'package:getjob/core/usecase/usecase.dart';
import 'package:getjob/features/job/domain/entities/job.dart';
import 'package:getjob/features/job/domain/repository/job_repository.dart';

class AddJobUsecase implements Usecase<void, Job> {
  final JobRepository jobRepository;

  AddJobUsecase({required this.jobRepository});
  @override
  Future<Either<Failure, void>> call(Job params) async {
    return await jobRepository.addJob(params);
  }
}

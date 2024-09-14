import 'package:dartz/dartz.dart';
import 'package:getjob/core/errors/failure.dart';
import 'package:getjob/core/usecase/usecase.dart';
import 'package:getjob/features/job/domain/entities/job.dart';
import 'package:getjob/features/job/domain/repository/job_repository.dart';

class GetJobsUsecase implements Usecase<List<Job>, NoParams> {
  final JobRepository jobRepository;

  GetJobsUsecase({required this.jobRepository});
  @override
  Future<Either<Failure, List<Job>>> call(NoParams params) async {
    return await jobRepository.getJobs();
  }
}

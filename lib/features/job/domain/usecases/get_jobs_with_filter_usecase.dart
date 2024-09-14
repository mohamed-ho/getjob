import 'package:dartz/dartz.dart';
import 'package:getjob/core/errors/failure.dart';
import 'package:getjob/core/usecase/usecase.dart';
import 'package:getjob/features/job/domain/entities/filter_job.dart';
import 'package:getjob/features/job/domain/entities/job.dart';
import 'package:getjob/features/job/domain/repository/job_repository.dart';

class GetJobsWithFilterUsecase implements Usecase<List<Job>, FilterJob> {
  final JobRepository jobRepository;

  GetJobsWithFilterUsecase({required this.jobRepository});
  @override
  Future<Either<Failure, List<Job>>> call(FilterJob params) async {
    return await jobRepository.getJobsWithFilter(params);
  }
}

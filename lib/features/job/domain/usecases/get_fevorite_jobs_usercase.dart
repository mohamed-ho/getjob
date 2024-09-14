import 'package:dartz/dartz.dart';
import 'package:getjob/core/errors/failure.dart';
import 'package:getjob/core/usecase/usecase.dart';
import 'package:getjob/features/job/domain/entities/job.dart';
import 'package:getjob/features/job/domain/repository/job_repository.dart';

class GetfevoriteJobsUsercase implements Usecase<List<Job>, int> {
  final JobRepository jobRepository;

  GetfevoriteJobsUsercase({required this.jobRepository});
  @override
  Future<Either<Failure, List<Job>>> call(int params) async {
    return await jobRepository.getFevoriteJobs(params);
  }
}

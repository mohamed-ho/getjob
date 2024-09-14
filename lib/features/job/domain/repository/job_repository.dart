import 'package:dartz/dartz.dart';
import 'package:getjob/core/errors/failure.dart';
import 'package:getjob/features/job/domain/entities/filter_job.dart';
import 'package:getjob/features/job/domain/entities/job.dart';

abstract class JobRepository {
  Future<Either<Failure, void>> addJob(Job job);
  Future<Either<Failure, List<Job>>> getJobsWithFilter(FilterJob filter);
  Future<Either<Failure, List<Job>>> getJobs();
  Future<Either<Failure, void>> updateJob(Job job);
  Future<Either<Failure, void>> deleteJob(String jobId);
  Future<Either<Failure, List<Job>>> getFevoriteJobs(int numberOfJobs);
}

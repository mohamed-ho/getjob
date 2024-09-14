import 'package:dartz/dartz.dart';
import 'package:getjob/core/errors/exceptions.dart';
import 'package:getjob/core/errors/failure.dart';
import 'package:getjob/features/job/data/Data_source/job_remote_date_source.dart';
import 'package:getjob/features/job/data/models/job_model.dart';
import 'package:getjob/features/job/domain/entities/filter_job.dart';
import 'package:getjob/features/job/domain/entities/job.dart';
import 'package:getjob/features/job/domain/repository/job_repository.dart';

class JobRepositoryImpl implements JobRepository {
  final JobRemoteDateSource jobRemoteDateSource;

  JobRepositoryImpl({required this.jobRemoteDateSource});
  @override
  Future<Either<Failure, void>> addJob(Job job) async {
    try {
      final result = await jobRemoteDateSource.addJob(JobModel.fromJob(job));
      return Right(result);
    } on ServerExceptions catch (e) {
      return Left(ServerFailure(message: e.message!));
    }
  }

  @override
  Future<Either<Failure, void>> deleteJob(String jobId) async {
    try {
      final result = await jobRemoteDateSource.deleteJob(jobId);
      return Right(result);
    } on ServerExceptions catch (e) {
      return Left(ServerFailure(message: e.message!));
    }
  }

  @override
  Future<Either<Failure, List<Job>>> getFevoriteJobs(int numberOfJobs) async {
    try {
      final result = await jobRemoteDateSource.getFevoriteJobs(numberOfJobs);
      return Right(result);
    } on ServerExceptions catch (e) {
      return Left(ServerFailure(message: e.message!));
    }
  }

  @override
  Future<Either<Failure, List<Job>>> getJobs() async {
    try {
      final result = await jobRemoteDateSource.getJobs();
      return Right(result);
    } on ServerExceptions catch (e) {
      return Left(ServerFailure(message: e.message!));
    }
  }

  @override
  Future<Either<Failure, List<Job>>> getJobsWithFilter(FilterJob filter) async {
    try {
      final result = await jobRemoteDateSource.getJobsByFilter(filter: filter);
      return Right(result);
    } on ServerExceptions catch (e) {
      return Left(ServerFailure(message: e.message!));
    }
  }

  @override
  Future<Either<Failure, void>> updateJob(Job job) async {
    try {
      final result = await jobRemoteDateSource.updateJob(JobModel.fromJob(job));
      return Right(result);
    } on ServerExceptions catch (e) {
      return Left(ServerFailure(message: e.message!));
    }
  }
}

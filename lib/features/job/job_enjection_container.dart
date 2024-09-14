import 'package:getjob/features/auth/auth_enjection_container.dart';
import 'package:getjob/features/job/data/Data_source/job_remote_date_source.dart';
import 'package:getjob/features/job/data/repository/job_repository_impl.dart';
import 'package:getjob/features/job/domain/repository/job_repository.dart';
import 'package:getjob/features/job/domain/usecases/add_job_usecase.dart';
import 'package:getjob/features/job/domain/usecases/delete_job_usecase.dart';
import 'package:getjob/features/job/domain/usecases/get_fevorite_jobs_usercase.dart';
import 'package:getjob/features/job/domain/usecases/get_jobs_usecase.dart';
import 'package:getjob/features/job/domain/usecases/get_jobs_with_filter_usecase.dart';
import 'package:getjob/features/job/domain/usecases/update_job_usecase.dart';
import 'package:getjob/features/job/presentation/bloc/job_bloc.dart';

class JobEnjectionContainer {
  void init() {
    ls.registerFactory(() => JobBloc(
        addJobUsecase: ls(),
        deleteJobUsecase: ls(),
        getJobsUsecase: ls(),
        getJobsWithFilterUsecase: ls(),
        getfevoriteJobsUsercase: ls(),
        updateJobUsecase: ls()));

    ls.registerLazySingleton(() => AddJobUsecase(jobRepository: ls()));
    ls.registerLazySingleton(() => DeleteJobUsecase(jobRepository: ls()));
    ls.registerLazySingleton(() => GetJobsUsecase(jobRepository: ls()));
    ls.registerLazySingleton(
        () => GetJobsWithFilterUsecase(jobRepository: ls()));
    ls.registerLazySingleton(
        () => GetfevoriteJobsUsercase(jobRepository: ls()));
    ls.registerLazySingleton(() => UpdateJobUsecase(jobRepository: ls()));
    ls.registerLazySingleton<JobRepository>(
        () => JobRepositoryImpl(jobRemoteDateSource: ls()));
    ls.registerLazySingleton<JobRemoteDateSource>(
        () => JobRemoteDateSourceImpl(firebaseFirestore: ls()));
  }
}

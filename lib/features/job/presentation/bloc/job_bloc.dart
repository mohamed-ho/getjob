// ignore: depend_on_referenced_packages
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:getjob/core/usecase/usecase.dart';
import 'package:getjob/features/job/domain/entities/filter_job.dart';
import 'package:getjob/features/job/domain/entities/job.dart';
import 'package:getjob/features/job/domain/usecases/add_job_usecase.dart';
import 'package:getjob/features/job/domain/usecases/delete_job_usecase.dart';
import 'package:getjob/features/job/domain/usecases/get_fevorite_jobs_usercase.dart';
import 'package:getjob/features/job/domain/usecases/get_jobs_usecase.dart';
import 'package:getjob/features/job/domain/usecases/get_jobs_with_filter_usecase.dart';
import 'package:getjob/features/job/domain/usecases/update_job_usecase.dart';

part 'job_event.dart';
part 'job_state.dart';

class JobBloc extends Bloc<JobEvent, JobState> {
  final AddJobUsecase addJobUsecase;
  final DeleteJobUsecase deleteJobUsecase;
  final GetfevoriteJobsUsercase getfevoriteJobsUsercase;
  final GetJobsUsecase getJobsUsecase;
  final GetJobsWithFilterUsecase getJobsWithFilterUsecase;
  final UpdateJobUsecase updateJobUsecase;
  JobBloc(
      {required this.addJobUsecase,
      required this.deleteJobUsecase,
      required this.getJobsUsecase,
      required this.getJobsWithFilterUsecase,
      required this.getfevoriteJobsUsercase,
      required this.updateJobUsecase})
      : super(JobInitial()) {
    on<AddJobEvent>((event, emit) async {
      emit(JobLoadingState());
      final result = await addJobUsecase(event.job);
      result.fold((l) => emit(JobErrorState(message: l.message)),
          (r) => emit(JobLoadedState()));
    });
    on<DeleteJobEvent>(
      (event, emit) async {
        emit(JobLoadingState());
        final result = await deleteJobUsecase(event.jobId);
        result.fold((l) => emit(JobErrorState(message: l.message)),
            (r) => emit(JobLoadedState()));
      },
    );
    on<GetFevoriteJobsEvent>(
      (event, emit) async {
        emit(JobLoadingState());
        final result = await getfevoriteJobsUsercase(event.numberOfJobs);
        result.fold((l) => emit(JobErrorState(message: l.message)),
            (r) => emit(JobGetedState(jobs: r)));
      },
    );
    on<GetJobsEvent>(
      (event, emit) async {
        emit(JobLoadingState());
        final result = await getJobsUsecase(NoParams());
        result.fold((l) => emit(JobErrorState(message: l.message)),
            (r) => emit(JobGetedState(jobs: r)));
      },
    );
    on<GetJobsWithFilterEvent>(
      (event, emit) async {
        emit(JobLoadingState());
        final result = await getJobsWithFilterUsecase(event.filterJob);
        result.fold((l) => emit(JobErrorState(message: l.message)),
            (r) => emit(JobGetedState(jobs: r)));
      },
    );

    on<UpdateJobEvent>(
      (event, emit) async {
        emit(JobLoadingState());
        final result = await updateJobUsecase(event.job);
        result.fold((l) => emit(JobErrorState(message: l.message)),
            (r) => emit(JobLoadedState()));
      },
    );
  }
}

part of 'job_bloc.dart';

sealed class JobEvent extends Equatable {
  const JobEvent();

  @override
  List<Object> get props => [];
}

final class AddJobEvent extends JobEvent {
  final Job job;
  const AddJobEvent({required this.job});
  @override
  List<Object> get props => [job];
}

final class UpdateJobEvent extends JobEvent {
  final Job job;
  const UpdateJobEvent({required this.job});
  @override
  List<Object> get props => [job];
}

final class GetJobsEvent extends JobEvent {}

final class DeleteJobEvent extends JobEvent {
  final String jobId;
  const DeleteJobEvent({required this.jobId});
  @override
  List<Object> get props => [jobId];
}

final class GetFevoriteJobsEvent extends JobEvent {
  final int numberOfJobs;
  const GetFevoriteJobsEvent({required this.numberOfJobs});
  @override
  List<Object> get props => [numberOfJobs];
}

final class GetJobsWithFilterEvent extends JobEvent {
  final FilterJob filterJob;
  const GetJobsWithFilterEvent({required this.filterJob});
  @override
  List<Object> get props => [filterJob];
}

part of 'job_bloc.dart';

sealed class JobState extends Equatable {
  const JobState();

  @override
  List<Object> get props => [];
}

final class JobInitial extends JobState {}

final class JobLoadingState extends JobState {}

final class JobLoadedState extends JobState {}

final class JobErrorState extends JobState {
  final String message;
  const JobErrorState({required this.message});
  @override
  List<Object> get props => [message];
}

final class JobGetedState extends JobState {
  final List<Job> jobs;
  const JobGetedState({required this.jobs});
  @override
  List<Object> get props => [jobs];
}

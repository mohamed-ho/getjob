part of 'application_bloc.dart';

sealed class ApplicationEvent extends Equatable {
  const ApplicationEvent();

  @override
  List<Object> get props => [];
}

final class AddApplicationEvent extends ApplicationEvent {
  final Application application;
  final JobOrder jobOrder;
  const AddApplicationEvent(
      {required this.application, required this.jobOrder});
  @override
  List<Object> get props => [application, jobOrder];
}

final class UpdateApplicationEvent extends ApplicationEvent {
  final Application application;
  const UpdateApplicationEvent({required this.application});
  @override
  List<Object> get props => [application];
}

final class DeleteJobApplicationsEvent extends ApplicationEvent {
  final String jobId;
  const DeleteJobApplicationsEvent({required this.jobId});
  @override
  List<Object> get props => [jobId];
}

final class DeleteUserApplicationEvent extends ApplicationEvent {
  final Application application;
  const DeleteUserApplicationEvent({required this.application});
  @override
  List<Object> get props => [application];
}

final class GetJobApplicationsEvent extends ApplicationEvent {
  final String jobId;
  const GetJobApplicationsEvent({required this.jobId});
  @override
  List<Object> get props => [jobId];
}

final class GetUserApplicationsEvent extends ApplicationEvent {
  final String userId;
  const GetUserApplicationsEvent({required this.userId});
  @override
  List<Object> get props => [userId];
}

final class GetJobApplicationEvent extends ApplicationEvent {
  final JobOrder jobOrder;
  const GetJobApplicationEvent({required this.jobOrder});
  @override
  List<Object> get props => [jobOrder];
}

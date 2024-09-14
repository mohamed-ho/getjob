part of 'application_bloc.dart';

sealed class ApplicationState extends Equatable {
  const ApplicationState();

  @override
  List<Object> get props => [];
}

final class ApplicationInitial extends ApplicationState {}

final class ApplicationErrorState extends ApplicationState {
  final String message;
  const ApplicationErrorState({required this.message});
  @override
  List<Object> get props => [message];
}

final class ApplicationGetedState extends ApplicationState {
  final List<Application> applications;
  const ApplicationGetedState({required this.applications});
  @override
  List<Object> get props => [applications];
}

final class ApplicationLoadingState extends ApplicationState {}

final class ApplicationLoadedState extends ApplicationState {}

final class GetedJobApplicationState extends ApplicationState {
  final Application application;
  const GetedJobApplicationState({required this.application});
  @override
  List<Object> get props => [application];
}

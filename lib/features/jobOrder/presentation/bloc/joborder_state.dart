part of 'joborder_bloc.dart';

abstract class JoborderState extends Equatable {
  const JoborderState();

  @override
  List<Object> get props => [];
}

class JoborderInitial extends JoborderState {}

class JobOrderLoadingState extends JoborderState {}

class JobOrderLoadedState extends JoborderState {}

class JobOrderGetedState extends JoborderState {
  final List<JobOrder> jobOrders;
  const JobOrderGetedState({required this.jobOrders});
  @override
  List<Object> get props => [jobOrders];
}

class JobOrderErrorState extends JoborderState {
  final String message;
  const JobOrderErrorState({required this.message});
  @override
  List<Object> get props => [message];
}

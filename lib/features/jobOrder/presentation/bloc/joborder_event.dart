part of 'joborder_bloc.dart';

abstract class JoborderEvent extends Equatable {
  const JoborderEvent();

  @override
  List<Object> get props => [];
}

final class AddJobOrderEvent extends JoborderEvent {
  final JobOrder jobOrder;

  const AddJobOrderEvent({required this.jobOrder});
  @override
  List<Object> get props => [jobOrder];
}

final class DeleteJobOrderEvent extends JoborderEvent {
  final JobOrder jobOrder;

  const DeleteJobOrderEvent({required this.jobOrder});
  @override
  List<Object> get props => [jobOrder];
}

final class UpdateJobOrderIsDeliveredevent extends JoborderEvent {
  final String jobOrderId;

  const UpdateJobOrderIsDeliveredevent({required this.jobOrderId});
  @override
  List<Object> get props => [jobOrderId];
}

final class GetJobOrderEvent extends JoborderEvent {
  final String userId;

  const GetJobOrderEvent({required this.userId});
  @override
  List<Object> get props => [userId];
}

// ignore: depend_on_referenced_packages
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:getjob/features/jobOrder/domain/entities/job_order.dart';
import 'package:getjob/features/jobOrder/domain/usecases/add_job_order_usecase.dart';
import 'package:getjob/features/jobOrder/domain/usecases/delete_job_order_usecase.dart';
import 'package:getjob/features/jobOrder/domain/usecases/get_job_order_usecase.dart';
import 'package:getjob/features/jobOrder/domain/usecases/update_job_order_is_delivered_usecase.dart';

part 'joborder_event.dart';
part 'joborder_state.dart';

class JoborderBloc extends Bloc<JoborderEvent, JoborderState> {
  final AddJobOrderUsecase addJobOrderUsecase;
  final DeleteJobOrderUsecase deleteJobOrderUsecase;
  final GetJobOrderUsecase getJobOrderUsecase;
  final UpdateJobOrderIsDeliveredUsecase updateJobOrderIsDeliveredUsecase;
  JoborderBloc(
      {required this.addJobOrderUsecase,
      required this.deleteJobOrderUsecase,
      required this.getJobOrderUsecase,
      required this.updateJobOrderIsDeliveredUsecase})
      : super(JoborderInitial()) {
    on<AddJobOrderEvent>((event, emit) async {
      emit(JobOrderLoadingState());
      final result = await addJobOrderUsecase(event.jobOrder);
      result.fold((l) => emit(JobOrderErrorState(message: l.message)),
          (r) => (emit(JobOrderLoadedState())));
    });

    on<DeleteJobOrderEvent>((event, emit) async {
      emit(JobOrderLoadingState());
      final result = await deleteJobOrderUsecase(event.jobOrder);
      result.fold((l) => emit(JobOrderErrorState(message: l.message)),
          (r) => (emit(JobOrderLoadedState())));
    });

    on<UpdateJobOrderIsDeliveredevent>((event, emit) async {
      emit(JobOrderLoadingState());
      final result = await updateJobOrderIsDeliveredUsecase(event.jobOrderId);
      result.fold((l) => emit(JobOrderErrorState(message: l.message)),
          (r) => (emit(JobOrderLoadedState())));
    });

    on<GetJobOrderEvent>((event, emit) async {
      emit(JobOrderLoadingState());
      final result = await getJobOrderUsecase(event.userId);
      result.fold((l) => emit(JobOrderErrorState(message: l.message)),
          (r) => (emit(JobOrderGetedState(jobOrders: r))));
    });
  }
}

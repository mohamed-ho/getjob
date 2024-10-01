// ignore: depend_on_referenced_packages
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:getjob/features/applications/domain/entities/application.dart';
import 'package:getjob/features/applications/domain/usecases/add_applications_usecase.dart';
import 'package:getjob/features/applications/domain/usecases/delete_job_applications_usecase.dart';
import 'package:getjob/features/applications/domain/usecases/delete_user_application_usecase.dart';
import 'package:getjob/features/applications/domain/usecases/get_job_application_usecase.dart';
import 'package:getjob/features/applications/domain/usecases/get_job_applications_usecase.dart';
import 'package:getjob/features/applications/domain/usecases/get_user_applications_usecase.dart';
import 'package:getjob/features/applications/domain/usecases/update_applications_usecase.dart';
import 'package:getjob/features/jobOrder/domain/entities/job_order.dart';

part 'application_event.dart';
part 'application_state.dart';

class ApplicationBloc extends Bloc<ApplicationEvent, ApplicationState> {
  final AddApplicationUsecase addApplicationUsecase;
  final DeleteJobApplicationsUsecase deleteJobApplicationsUsecase;
  final DeleteUserApplicationUsecase deleteUserApplicationUsecase;
  final GetJobApplicationsUsecase getJobApplicationsUsecase;
  final GetUserApplicationUsecase getUserApplicationUsecase;
  final UpdateApplicationsUsecase updateApplicationsUsecase;
  final GetJobApplicationUsecase getJobApplicationUsecase;
  ApplicationBloc(
      {required this.addApplicationUsecase,
      required this.deleteJobApplicationsUsecase,
      required this.deleteUserApplicationUsecase,
      required this.getJobApplicationsUsecase,
      required this.getUserApplicationUsecase,
      required this.updateApplicationsUsecase,
      required this.getJobApplicationUsecase})
      : super(ApplicationInitial()) {
    on<AddApplicationEvent>((event, emit) async {
      emit(ApplicationLoadingState());
      final result =
          await addApplicationUsecase([event.application, event.jobOrder]);
      result.fold((l) => emit(ApplicationErrorState(message: l.message)),
          (r) => emit(ApplicationLoadedState()));
    });

    on<DeleteJobApplicationsEvent>((event, emit) async {
      emit(ApplicationLoadingState());
      final result = await deleteJobApplicationsUsecase(event.jobId);
      result.fold((l) => emit(ApplicationErrorState(message: l.message)),
          (r) => emit(ApplicationLoadedState()));
    });

    on<DeleteUserApplicationEvent>((event, emit) async {
      emit(ApplicationLoadingState());
      final result = await deleteUserApplicationUsecase(event.application);
      result.fold((l) => emit(ApplicationErrorState(message: l.message)),
          (r) => emit(ApplicationLoadedState()));
    });

    on<GetJobApplicationsEvent>((event, emit) async {
      emit(ApplicationLoadingState());
      final result = await getJobApplicationsUsecase(event.jobId);
      result.fold((l) => emit(ApplicationErrorState(message: l.message)),
          (r) => emit(ApplicationGetedState(applications: r)));
    });

    on<GetUserApplicationsEvent>((event, emit) async {
      emit(ApplicationLoadingState());
      final result = await getUserApplicationUsecase(event.userId);
      result.fold((l) => emit(ApplicationErrorState(message: l.message)),
          (r) => emit(ApplicationGetedState(applications: r)));
    });

    on<UpdateApplicationEvent>((event, emit) async {
      emit(ApplicationLoadingState());
      final result = await updateApplicationsUsecase(event.application);
      result.fold((l) => emit(ApplicationErrorState(message: l.message)),
          (r) => emit(ApplicationLoadedState()));
    });

    on<GetJobApplicationEvent>((event, emit) async {
      emit(ApplicationLoadingState());
      final result = await getJobApplicationUsecase(event.jobOrder);
      result.fold((l) => emit(ApplicationErrorState(message: l.message)),
          (r) => emit(GetedJobApplicationState(application: r)));
    });
  }
}

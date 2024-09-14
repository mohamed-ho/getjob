import 'package:getjob/features/auth/auth_enjection_container.dart';
import 'package:getjob/features/jobOrder/data/datasources/job_order_application_remote_data_source.dart';
import 'package:getjob/features/jobOrder/data/repositories/job_order_repository_impl.dart';
import 'package:getjob/features/jobOrder/domain/repositories/job_order_repository.dart';
import 'package:getjob/features/jobOrder/domain/usecases/add_job_order_usecase.dart';
import 'package:getjob/features/jobOrder/domain/usecases/delete_job_order_usecase.dart';
import 'package:getjob/features/jobOrder/domain/usecases/get_job_order_usecase.dart';
import 'package:getjob/features/jobOrder/domain/usecases/update_job_order_is_delivered_usecase.dart';
import 'package:getjob/features/jobOrder/presentation/bloc/joborder_bloc.dart';

class JobOrderInjection {
  init() {
    ls.registerFactory(() => JoborderBloc(
        addJobOrderUsecase: ls(),
        deleteJobOrderUsecase: ls(),
        getJobOrderUsecase: ls(),
        updateJobOrderIsDeliveredUsecase: ls()));

    ls.registerLazySingleton(
        () => AddJobOrderUsecase(jobOrderRepository: ls()));
    ls.registerLazySingleton(
        () => DeleteJobOrderUsecase(jobOrderRepository: ls()));
    ls.registerLazySingleton(
        () => GetJobOrderUsecase(jobOrderRepository: ls()));
    ls.registerLazySingleton(
        () => UpdateJobOrderIsDeliveredUsecase(jobOrderRepository: ls()));

    ls.registerLazySingleton<JobOrderRepository>(
        () => JobOrderRepositoryImpl(jobOrderApplicationRemoteDataSourc: ls()));
    ls.registerLazySingleton<JobOrderApplicationRemoteDataSource>(
        () => JobOrderApplicationRemoteDataSourcImpl(firebaseFirestore: ls()));
  }
}

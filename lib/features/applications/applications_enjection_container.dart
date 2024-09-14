import 'package:firebase_storage/firebase_storage.dart';
import 'package:getjob/features/applications/data/data_source/application_remote_data_source.dart';
import 'package:getjob/features/applications/data/data_source/job_order_remote_data_source.dart';
import 'package:getjob/features/applications/data/repository/application_repository_impl.dart';
import 'package:getjob/features/applications/domain/repository/order_application.dart';
import 'package:getjob/features/applications/domain/usecases/add_applications_usecase.dart';
import 'package:getjob/features/applications/domain/usecases/delete_job_applications_usecase.dart';
import 'package:getjob/features/applications/domain/usecases/delete_user_application_usecase.dart';
import 'package:getjob/features/applications/domain/usecases/get_job_application_usecase.dart';
import 'package:getjob/features/applications/domain/usecases/get_job_applications_usecase.dart';
import 'package:getjob/features/applications/domain/usecases/get_user_applications_usecase.dart';
import 'package:getjob/features/applications/domain/usecases/update_applications_usecase.dart';
import 'package:getjob/features/applications/presentation/bloc/application_bloc.dart';
import 'package:getjob/features/auth/auth_enjection_container.dart';

class ApplicationsEnjectionContainer {
  void init() {
    ls.registerFactory(() => ApplicationBloc(
        addApplicationUsecase: ls(),
        deleteJobApplicationsUsecase: ls(),
        deleteUserApplicationUsecase: ls(),
        getJobApplicationsUsecase: ls(),
        getUserApplicationUsecase: ls(),
        updateApplicationsUsecase: ls(),
        getJobApplicationUsecase: ls()));

    ls.registerLazySingleton(
        () => AddApplicationUsecase(applicationRepository: ls()));
    ls.registerLazySingleton(
        () => DeleteJobApplicationsUsecase(applicationRepository: ls()));
    ls.registerLazySingleton(
        () => DeleteUserApplicationUsecase(applicationRepository: ls()));
    ls.registerLazySingleton(
        () => GetJobApplicationsUsecase(applicationRepository: ls()));
    ls.registerLazySingleton(
        () => GetUserApplicationUsecase(applicationRepository: ls()));
    ls.registerLazySingleton(
        () => UpdateApplicationsUsecase(applicationRepository: ls()));
    ls.registerLazySingleton(
        () => GetJobApplicationUsecase(applicationRepository: ls()));

    ls.registerLazySingleton<ApplicationRepository>(
        () => ApplicationRepositoryImpl(applicationRemoteDataSource: ls()));
    ls.registerLazySingleton<ApplicationRemoteDataSource>(() =>
        ApplicationRemoteDataSourceImpl(
            firebaseFirestore: ls(), firebaseStorage: ls()));
    ls.registerLazySingleton<JobOrderRemoteDataSource>(
        () => JobOrderRemoteDataSourceImpl(firebaseFirestore: ls()));
    ls.registerLazySingleton(() => FirebaseStorage.instance);
  }
}

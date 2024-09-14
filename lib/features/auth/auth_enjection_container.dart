import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get_it/get_it.dart';
import 'package:getjob/features/auth/data/data_surce/user_local_data_source.dart';
import 'package:getjob/features/auth/data/data_surce/user_remote_data_source.dart';
import 'package:getjob/features/auth/data/repository/user_repository_impl.dart';
import 'package:getjob/features/auth/domain/repository/user_repository.dart';
import 'package:getjob/features/auth/domain/usecases/change_password_usecase.dart';
import 'package:getjob/features/auth/domain/usecases/login_user_usecase.dart';
import 'package:getjob/features/auth/domain/usecases/logout_user_usecase.dart';
import 'package:getjob/features/auth/domain/usecases/sginup_user_usecase.dart';
import 'package:getjob/features/auth/domain/usecases/update_user_usecase.dart';
import 'package:getjob/features/auth/presentation/bloc/user_bloc.dart';

final ls = GetIt.instance;

class AuthEnjectionContainer {
  void init() {
    ls.registerFactory(() => UserBloc(
        loginUsersUsecase: ls(),
        updateUsersUsecase: ls(),
        sginupUsersUsecase: ls(),
        logoutUsersUsecase: ls(),
        userLocalDataSource: ls(),
        changePasswordUsecase: ls()));

    ls.registerLazySingleton(() => LoginUsersUsecase(usersRepository: ls()));
    ls.registerLazySingleton(() => UpdateUsersUsecase(usersRepository: ls()));
    ls.registerLazySingleton(() => SginupUsersUsecase(usersRepository: ls()));
    ls.registerLazySingleton(() => LogoutUsersUsecase(usersRepository: ls()));
    ls.registerLazySingleton(
        () => ChangePasswordUsecase(usersRepository: ls()));
    ls.registerLazySingleton<UsersRepository>(
        () => UsersRepositoryImpl(usersRemoteDataSource: ls()));
    ls.registerLazySingleton<UserRemoteDataSource>(() =>
        UserRemoteDataSourceImpl(firebaseAuth: ls(), firebaseFirestore: ls()));
    ls.registerLazySingleton<UserLocalDataSource>(
        () => UserLocalDataSourceImpl());
    ls.registerLazySingleton(() => FirebaseAuth.instance);
    ls.registerLazySingleton(() => FirebaseFirestore.instance);
  }
}

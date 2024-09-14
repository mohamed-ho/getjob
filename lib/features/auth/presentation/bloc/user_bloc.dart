import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:getjob/core/usecase/usecase.dart';
import 'package:getjob/features/auth/data/data_surce/user_local_data_source.dart';
import 'package:getjob/features/auth/data/models/user_model.dart';
import 'package:getjob/features/auth/domain/entities/user.dart';
import 'package:getjob/features/auth/domain/usecases/change_password_usecase.dart';
import 'package:getjob/features/auth/domain/usecases/login_user_usecase.dart';
import 'package:getjob/features/auth/domain/usecases/logout_user_usecase.dart';
import 'package:getjob/features/auth/domain/usecases/sginup_user_usecase.dart';
import 'package:getjob/features/auth/domain/usecases/update_user_usecase.dart';

part 'user_event.dart';
part 'user_state.dart';

class UserBloc extends Bloc<UserEvent, UserState> {
  final LoginUsersUsecase loginUsersUsecase;
  final UpdateUsersUsecase updateUsersUsecase;
  final SginupUsersUsecase sginupUsersUsecase;
  final LogoutUsersUsecase logoutUsersUsecase;
  final UserLocalDataSource userLocalDataSource;
  final ChangePasswordUsecase changePasswordUsecase;
  final String _hash = 'MohamedHosnyHassanAmir1102000';
  UserBloc(
      {required this.loginUsersUsecase,
      required this.updateUsersUsecase,
      required this.sginupUsersUsecase,
      required this.logoutUsersUsecase,
      required this.userLocalDataSource,
      required this.changePasswordUsecase})
      : super(UserInitial()) {
    on<SignUpUserEvent>((event, emit) async {
      emit(LoadingUserState());
      final result = await sginupUsersUsecase(event.user);
      result.fold((l) => emit(UserErrorState(message: l.message)),
          (r) => emit(SignUpUserState()));
    });

    on<LoginUserEvent>(
      (event, emit) async {
        emit(LoadingUserState());

        final result = await loginUsersUsecase([event.email, event.password]);
        result.fold((l) => emit(UserErrorState(message: l.message)), (r) {
          userLocalDataSource.setUser(UserModel.fromUsers(r));
          r.verify ? userLocalDataSource.saveLogin() : null;
          emit(LoginUserState(user: r));
        });
      },
    );

    on<UpdateUserEvent>((event, emit) async {
      emit(LoadingUserState());
      final result = await updateUsersUsecase(event.user);
      result.fold((l) => emit(UserErrorState(message: l.message)),
          (r) => emit(UpdateUserState()));
    });

    on<LogoutUserEvent>((event, emit) async {
      emit(LoadingUserState());
      final result = await logoutUsersUsecase(NoParams());
      result.fold((l) => emit(UserErrorState(message: l.message)),
          (r) => emit(LogoutUserState()));
    });

    on<ChangePasswordEvent>(
      (event, emit) async {
        emit(LoadingUserState());
        final result = await changePasswordUsecase(event.email);
        result.fold((l) => emit(UserErrorState(message: l.message)),
            (r) => emit(LoadedUserState()));
      },
    );
  }
}

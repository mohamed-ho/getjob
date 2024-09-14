part of 'user_bloc.dart';

sealed class UserState extends Equatable {
  const UserState();

  @override
  List<Object> get props => [];
}

final class UserInitial extends UserState {}

final class LoginUserState extends UserState {
  final Users user;

  const LoginUserState({required this.user});
  @override
  List<Object> get props => [user];
}

final class SignUpUserState extends UserState {}

final class LogoutUserState extends UserState {}

final class UpdateUserState extends UserState {}

final class UserErrorState extends UserState {
  final String message;

  const UserErrorState({required this.message});
  @override
  List<Object> get props => [message];
}

final class LoadingUserState extends UserState {}

final class LoadedUserState extends UserState {}

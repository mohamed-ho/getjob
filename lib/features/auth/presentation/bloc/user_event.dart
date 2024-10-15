part of 'user_bloc.dart';

sealed class UserEvent extends Equatable {
  const UserEvent();

  @override
  List<Object> get props => [];
}

final class LoginUserEvent extends UserEvent {
  final String email;
  final String password;
  const LoginUserEvent({required this.email, required this.password});
  @override
  List<Object> get props => [email, password];
}

final class SignUpUserEvent extends UserEvent {
  final Users user;

  const SignUpUserEvent({required this.user});
  @override
  List<Object> get props => [user];
}

final class UpdateUserEvent extends UserEvent {
  final Users user;

  const UpdateUserEvent({required this.user});
  @override
  List<Object> get props => [user];
}

final class LogoutUserEvent extends UserEvent {}

final class InitUserEvent extends UserEvent {}

final class DeleteAccountEvent extends UserEvent {}

final class ChangePasswordEvent extends UserEvent {
  final String email;

  const ChangePasswordEvent({required this.email});
  @override
  List<Object> get props => [email];
}

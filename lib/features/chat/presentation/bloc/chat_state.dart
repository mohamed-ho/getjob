part of 'chat_bloc.dart';

sealed class ChatState extends Equatable {
  const ChatState();

  @override
  List<Object> get props => [];
}

final class ChatInitial extends ChatState {}

final class ChatErrorState extends ChatState {
  final String message;

  const ChatErrorState({required this.message});
  @override
  List<Object> get props => [message];
}

final class ChatLoadingState extends ChatState {}

final class ChatLoadedState extends ChatState {}

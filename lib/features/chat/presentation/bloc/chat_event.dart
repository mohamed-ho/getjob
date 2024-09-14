part of 'chat_bloc.dart';

sealed class ChatEvent extends Equatable {
  const ChatEvent();

  @override
  List<Object> get props => [];
}

class AddFriendEvent extends ChatEvent {
  final String friendId;

  const AddFriendEvent({required this.friendId});
  @override
  List<Object> get props => [friendId];
}

class DeleteFriendEvent extends ChatEvent {
  final String friendId;

  const DeleteFriendEvent({required this.friendId});
  @override
  List<Object> get props => [friendId];
}

class DeleteMessageEvent extends ChatEvent {
  final String messageId;

  const DeleteMessageEvent({required this.messageId});
  @override
  List<Object> get props => [messageId];
}

class AddMessageEvent extends ChatEvent {
  final Message message;

  const AddMessageEvent({required this.message});
  @override
  List<Object> get props => [message];
}

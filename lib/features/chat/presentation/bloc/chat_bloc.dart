// ignore: depend_on_referenced_packages
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:getjob/features/chat/domian/entities/message.dart';
import 'package:getjob/features/chat/domian/usecases/add_friend_usecase.dart';
import 'package:getjob/features/chat/domian/usecases/add_message_usecase.dart';
import 'package:getjob/features/chat/domian/usecases/delete_friend_usecase.dart';
import 'package:getjob/features/chat/domian/usecases/delete_message_usecase.dart';
part 'chat_event.dart';
part 'chat_state.dart';

class ChatBloc extends Bloc<ChatEvent, ChatState> {
  final AddFriendUsecase addFriendUsecase;
  final AddMessageUsecase addMessageUsecase;
  final DeleteMessageUsecase deleteMessageUsecase;
  final DeleteFriendUsecase deleteFriendUsecase;
  ChatBloc({
    required this.addFriendUsecase,
    required this.addMessageUsecase,
    required this.deleteFriendUsecase,
    required this.deleteMessageUsecase,
  }) : super(ChatInitial()) {
    on<AddFriendEvent>((event, emit) async {
      emit(ChatLoadingState());
      final result = await addFriendUsecase(event.friendId);
      result.fold((l) => emit(ChatErrorState(message: l.message)),
          (r) => emit(ChatLoadedState()));
    });

    on<AddMessageEvent>((event, emit) async {
      emit(ChatLoadingState());
      final result = await addMessageUsecase(event.message);
      result.fold((l) => emit(ChatErrorState(message: l.message)),
          (r) => emit(ChatLoadedState()));
    });

    on<DeleteFriendEvent>((event, emit) async {
      emit(ChatLoadingState());
      final result = await deleteFriendUsecase(event.friendId);
      result.fold((l) => emit(ChatErrorState(message: l.message)),
          (r) => emit(ChatLoadedState()));
    });

    on<DeleteMessageEvent>((event, emit) async {
      emit(ChatLoadingState());
      final result = await deleteMessageUsecase(event.messageId);
      result.fold((l) => emit(ChatErrorState(message: l.message)),
          (r) => emit(ChatLoadedState()));
    });
  }
}

import 'package:getjob/features/auth/auth_enjection_container.dart';
import 'package:getjob/features/chat/data/data_source/chat_remote_data_source.dart';
import 'package:getjob/features/chat/data/repositories/chat_repository_impl.dart';
import 'package:getjob/features/chat/domian/repositories/chat_repository.dart';
import 'package:getjob/features/chat/domian/usecases/add_friend_usecase.dart';
import 'package:getjob/features/chat/domian/usecases/add_message_usecase.dart';
import 'package:getjob/features/chat/domian/usecases/delete_friend_usecase.dart';
import 'package:getjob/features/chat/domian/usecases/delete_message_usecase.dart';
import 'package:getjob/features/chat/presentation/bloc/chat_bloc.dart';

class ChatEnjectionContainer {
  void init() {
    ls.registerFactory(() => ChatBloc(
        addFriendUsecase: ls(),
        addMessageUsecase: ls(),
        deleteFriendUsecase: ls(),
        deleteMessageUsecase: ls()));
    ls.registerLazySingleton(() => AddFriendUsecase(chatRepository: ls()));
    ls.registerLazySingleton(() => AddMessageUsecase(chatRepository: ls()));
    ls.registerLazySingleton(() => DeleteFriendUsecase(chatRepository: ls()));
    ls.registerLazySingleton(() => DeleteMessageUsecase(chatRepository: ls()));

    ls.registerLazySingleton<ChatRepository>(
        () => ChatRepositoryImpl(chatRemoteDataSource: ls()));

    ls.registerLazySingleton<ChatRemoteDataSource>(
        () => ChatRemoteDataSourceImpl(firebaseFirestore: ls()));
  }
}

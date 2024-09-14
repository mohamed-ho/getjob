import 'package:dartz/dartz.dart';
import 'package:getjob/core/errors/failure.dart';
import 'package:getjob/core/usecase/usecase.dart';
import 'package:getjob/features/chat/domian/repositories/chat_repository.dart';

class AddFriendUsecase implements Usecase<void, String> {
  final ChatRepository chatRepository;

  AddFriendUsecase({required this.chatRepository});
  @override
  Future<Either<Failure, void>> call(String params) async {
    return await chatRepository.addFriend(params);
  }
}

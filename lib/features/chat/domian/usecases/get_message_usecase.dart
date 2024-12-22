import 'package:getjob/features/chat/domian/repositories/chat_repository.dart';

class GetMessageUsecase {
  final ChatRepository chatRepository;
  GetMessageUsecase({required this.chatRepository});

  Stream<List<Map<String, dynamic>>> call(String friendId) async* {
    try {
      yield* chatRepository.getMessage(friendId);
    } catch (e) {
      rethrow;
    }
  }
}
